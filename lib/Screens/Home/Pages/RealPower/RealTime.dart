import 'package:flutter/material.dart';
import 'PowerIndicator.dart';
import 'powerWebSocket.dart';
import 'devices.dart';
import 'diviceLiset.dart';

class RealTimeMonitoring extends StatefulWidget {
  const RealTimeMonitoring({Key? key}) : super(key: key);

  @override
  _RealTimeMonitoringState createState() => _RealTimeMonitoringState();
}

class _RealTimeMonitoringState extends State<RealTimeMonitoring> {
  static const double maxPower = 1500;

  double availablePower = 0;
  String errorMessage = "";

  final List<Device> devices = [
    Device(name: "AC", power: 400),
    Device(name: "Fan", power: 100),
    Device(name: "TV", power: 200),
    Device(name: "Heater", power: 500),
    Device(name: "Laptop", power: 150),
    Device(name: "Refrigerator", power: 300),
    Device(name: "Servo Motor", power: 50),
  ];

  late WebSocketService webSocketService;
  String connectionStatus = "Disconnected";

  @override
  void initState() {
    super.initState();
    webSocketService = WebSocketService();
    _initializeWebSocket();
  }

  void _initializeWebSocket() {
    try {
      webSocketService.connect('ws://192.168.0.100:81', _updateAvailablePower);
      setState(() {
        connectionStatus = "Connecting...";
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (webSocketService.connectionStatus == "Connected") {
          setState(() {
            connectionStatus = "Connected";
          });
        } else {
          setState(() {
            connectionStatus = "Failed to connect";
          });
        }
      });
    } catch (e) {
      setState(() {
        connectionStatus = "Error connecting: $e";
      });
    }
  }

  @override
  void dispose() {
    webSocketService.close();
    super.dispose();
  }

  void _updateAvailablePower(Map<String, dynamic> data) {
    if (mounted) {
      setState(() {
        availablePower = (data['potentio'] as num).toDouble() * 15;
      });
      _checkPowerStatus();
    }
  }

  void _toggleDevice(int index) {
    setState(() {
      devices[index].isOn = !devices[index].isOn;
    });

    if (devices[index].name == "Servo Motor") {
      webSocketService.send(devices[index].isOn ? "on" : "off");
    }

    _checkPowerStatus(index);
  }

  void _checkPowerStatus([int? lastToggledIndex]) {
    final totalConsumption = _calculateTotalPowerConsumption();
    if (totalConsumption > availablePower) {
      if (lastToggledIndex != null && devices[lastToggledIndex].isOn) {
        setState(() {
          devices[lastToggledIndex].isOn = false;
        });
        _showPowerExceededDialog(devices[lastToggledIndex].name);
      }
      setState(() {
        errorMessage = "Warning: Consumed power exceeds available power!";
      });
    } else {
      setState(() {
        errorMessage = "";
      });
    }
  }

  double _calculateTotalPowerConsumption() {
    return devices
        .where((device) => device.isOn)
        .fold(0.0, (sum, device) => sum + device.power);
  }

  void _showPowerExceededDialog(String deviceName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Power Exceeded"),
          content: Text(
              "Turning on '$deviceName' exceeds available power. It has been turned off."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalConsumption = _calculateTotalPowerConsumption();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Life Monitoring'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'WebSocket Status: $connectionStatus',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            PowerIndicator(
              availablePower: availablePower,
              totalConsumption: totalConsumption,
              maxPower: maxPower,
            ),
            const SizedBox(height: 10),
            _buildColorLegend(),
            const SizedBox(height: 10),
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(fontSize: 16, color: Colors.red),
              ),
            const SizedBox(height: 20),
            Expanded(
              child: DeviceList(
                devices: devices,
                onToggleDevice: _toggleDevice,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(color: Colors.green, label: 'Available'),
        const SizedBox(width: 20),
        _buildLegendItem(color: Colors.red, label: 'Consumed'),
        const SizedBox(width: 20),
        _buildLegendItem(color: Colors.grey.shade300, label: 'Max'),
      ],
    );
  }

  Widget _buildLegendItem({required Color color, required String label}) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 16),
        const SizedBox(width: 4),
        Text(label),
      ],
    );
  }
}