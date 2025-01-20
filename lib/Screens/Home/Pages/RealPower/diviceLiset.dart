import 'package:flutter/material.dart';
import 'devices.dart';

class DeviceList extends StatelessWidget {
  final List<Device> devices;
  final Function(int) onToggleDevice;

  const DeviceList({Key? key, required this.devices, required this.onToggleDevice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: devices.length,
      itemBuilder: (context, index) {
        final device = devices[index];
        return Card(
          child: ListTile(
            leading: Icon(
              device.name == "Servo Motor"
                  ? Icons.settings_remote
                  : Icons.electrical_services,
              size: 40,
            ),
            title: Text(device.name),
            subtitle: Text('${device.power} W'),
            trailing: Switch(
              value: device.isOn,
              onChanged: (value) => onToggleDevice(index),
            ),
          ),
        );
      },
    );
  }
}