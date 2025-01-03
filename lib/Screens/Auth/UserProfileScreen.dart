import 'package:flutter/material.dart';
import '../../Services/AuthServices.dart';

class UserProfileScreen extends StatefulWidget {
  final String token;

  UserProfileScreen({required this.token});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<Map<String, dynamic>> userInfo;

  @override
  void initState() {
    super.initState();
    // Call getUserInfo with token only, no need for userName now
    userInfo = AuthService().getUserInfo(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Profile')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            if (user.containsKey('error')) {
              return Center(child: Text(user['error']));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user['name'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Email: ${user['email'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Phone: ${user['phone'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                  SizedBox(height: 10),
                  Text('Address: ${user['address'] ?? 'N/A'}', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
          return Center(child: Text('No data found'));
        },
      ),
    );
  }
}
