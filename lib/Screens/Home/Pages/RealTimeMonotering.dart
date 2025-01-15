// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
//
// class RealTimeMonitoring extends StatefulWidget {
//   @override
//   _RealTimeMonitoringState createState() => _RealTimeMonitoringState();
// }
//
// class _RealTimeMonitoringState extends State<RealTimeMonitoring> {
//   static const double maxPower = 1500;
//
//   double availablePower = 0;
//   String errorMessage = "";
//
//   final List<Map<String, dynamic>> devices = [
//     {"name": "AC", "power": 400, "isOn": false},
//     {"name": "Fan", "power": 100, "isOn": false},
//     {"name": "TV", "power": 200, "isOn": false},
//     {"name": "Heater", "power": 500, "isOn": false},
//     {"name": "Laptop", "power": 150, "isOn": false},
//     {"name": "Refrigerator", "power": 300, "isOn": false},
//     {"name": "Servo Motor", "power": 50, "isOn": false},
//   ];
//
//   late final WebSocketChannel channel;
//   String connectionStatus = "Disconnected";
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeWebSocket();
//   }
//
//   void _initializeWebSocket() {
//     try {
//       channel = WebSocketChannel.connect(
//         Uri.parse('ws://192.168.0.100:81'),
//       );
//       connectionStatus = "Connected";
//
//       channel.stream.listen(
//             (data) {
//           try {
//             final parsedData = jsonDecode(data);
//             _updateAvailablePower(parsedData);
//           } catch (e) {
//             debugPrint('Error parsing WebSocket data: $e');
//           }
//         },
//         onDone: () {
//           setState(() {
//             connectionStatus = "Disconnected";
//           });
//         },
//         onError: (error) {
//           setState(() {
//             connectionStatus = "Error: $error";
//           });
//         },
//       );
//     } catch (e) {
//       setState(() {
//         connectionStatus = "Error connecting: $e";
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     channel.sink.close();
//     super.dispose();
//   }
//
//   void _updateAvailablePower(Map<String, dynamic> data) {
//     setState(() {
//       availablePower = (data['potentio'] as num).toDouble() * 15;
//     });
//     _checkPowerStatus();
//   }
//
//   void _toggleDevice(int index) {
//     setState(() {
//       devices[index]["isOn"] = !devices[index]["isOn"];
//     });
//
//     if (devices[index]["name"] == "Servo Motor") {
//       channel.sink.add(devices[index]["isOn"] ? "on" : "off");
//     }
//
//     _checkPowerStatus(index);
//   }
//
//   void _checkPowerStatus([int? lastToggledIndex]) {
//     final totalConsumption = _calculateTotalPowerConsumption();
//     if (totalConsumption > availablePower) {
//       if (lastToggledIndex != null && devices[lastToggledIndex]["isOn"]) {
//         setState(() {
//           devices[lastToggledIndex]["isOn"] = false;
//         });
//         _showPowerExceededDialog(devices[lastToggledIndex]["name"]);
//       }
//       setState(() {
//         errorMessage = "Warning: Consumed power exceeds available power!";
//       });
//     } else {
//       setState(() {
//         errorMessage = "";
//       });
//     }
//   }
//
//   double _calculateTotalPowerConsumption() {
//     return devices
//         .where((device) => device["isOn"])
//         .fold(0.0, (sum, device) => sum + device["power"]);
//   }
//
//   void _showPowerExceededDialog(String deviceName) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text("Power Exceeded"),
//           content: Text(
//               "Turning on '$deviceName' exceeds available power. It has been turned off."),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final totalConsumption = _calculateTotalPowerConsumption();
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Life Monitoring'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text(
//               'WebSocket Status: $connectionStatus',
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),
//             _buildPowerIndicator(totalConsumption),
//             const SizedBox(height: 10),
//             _buildColorLegend(),
//             const SizedBox(height: 10),
//             if (errorMessage.isNotEmpty)
//               Text(
//                 errorMessage,
//                 style: const TextStyle(fontSize: 16, color: Colors.red),
//               ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: _buildDeviceList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPowerIndicator(double totalConsumption) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         _buildCircularIndicator(1.0, Colors.grey.shade300, 12),
//         _buildCircularIndicator(totalConsumption / maxPower, Colors.red, 12),
//         _buildCircularIndicator(availablePower / maxPower, Colors.green, 8),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Icon(Icons.flash_on, size: 30, color: Colors.yellow),
//             const SizedBox(height: 5),
//             Text(
//               '${availablePower.toStringAsFixed(0)} W',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '${totalConsumption.toStringAsFixed(0)} W Consumed',
//               style: const TextStyle(fontSize: 12, color: Colors.black),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _buildCircularIndicator(
//       double value, Color color, double strokeWidth) {
//     return SizedBox(
//       width: 150,
//       height: 150,
//       child: CircularProgressIndicator(
//         value: value.clamp(0.0, 1.0),
//         strokeWidth: strokeWidth,
//         backgroundColor: Colors.transparent,
//         valueColor: AlwaysStoppedAnimation<Color>(color),
//       ),
//     );
//   }
//
//   Widget _buildColorLegend() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _buildLegendItem(color: Colors.green, label: 'Available'),
//         const SizedBox(width: 20),
//         _buildLegendItem(color: Colors.red, label: 'Consumed'),
//         const SizedBox(width: 20),
//         _buildLegendItem(color: Colors.grey.shade300, label: 'Max'),
//       ],
//     );
//   }
//
//   Widget _buildLegendItem({required Color color, required String label}) {
//     return Row(
//       children: [
//         Icon(Icons.circle, color: color, size: 16),
//         const SizedBox(width: 4),
//         Text(label),
//       ],
//     );
//   }
//
//   Widget _buildDeviceList() {
//     return ListView.builder(
//       itemCount: devices.length,
//       itemBuilder: (context, index) {
//         final device = devices[index];
//         return Card(
//           child: ListTile(
//             leading: Icon(
//               device["name"] == "Servo Motor"
//                   ? Icons.settings_remote
//                   : Icons.electrical_services,
//               size: 40,
//             ),
//             title: Text(device["name"]),
//             subtitle: Text('${device["power"]} W'),
//             trailing: Switch(
//               value: device["isOn"],
//               onChanged: (value) => _toggleDevice(index),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
