import 'dart:async';
import 'package:flutter/material.dart';

class BatteryLifeTracker extends StatefulWidget {
  @override
  _BatteryLifeTrackerState createState() => _BatteryLifeTrackerState();
}

class _BatteryLifeTrackerState extends State<BatteryLifeTracker> {
  double electricitySaved = 0.75; // Initial value for electricity saved (75%)
  List<Map<String, dynamic>> devices = [
    {"name": "AC", "power": 400},
    {"name": "Fan", "power": 100},
  ]; 

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      updateData();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void updateData() {
    setState(() {
      electricitySaved = (electricitySaved + 0.05) % 1.0;
      devices.add({"name": "Device ${devices.length + 1}", "power": 100 + devices.length * 50}); // Add a new device dynamically
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Life Tracker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Text(
              'Electricity Saved',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Circular Chart
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: CircularProgressIndicator(
                    value: electricitySaved,
                    strokeWidth: 12,
                    backgroundColor: Colors.red.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.flash_on, size: 30, color: Colors.black),
                    SizedBox(height: 5),
                    Text(
                      '${(electricitySaved * 100).toStringAsFixed(0)}%', // Convert to percentage
                      style: TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Electricity',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(Icons.square, color: Colors.red, size: 16),
                    SizedBox(width: 4),
                    Text('Consumed'),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Icon(Icons.square, color: Colors.green, size: 16),
                    SizedBox(width: 4),
                    Text('Max'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            // Device List
            Expanded(
              child: ListView.builder(
                itemCount: devices.length,
                itemBuilder: (context, index) {
                  final device = devices[index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.electrical_services, size: 40),
                      title: Text(device["name"]),
                      trailing: Text('${device["power"]} W',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}