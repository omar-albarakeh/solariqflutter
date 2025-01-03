import 'package:flutter/material.dart';
import '../../Services/AuthServices.dart';
import '../../Config/SharedPreferences.dart'; // For TokenStorage

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<Map<String, dynamic>> userInfo;

  @override
  void initState() {
    super.initState();
    _initializeUserInfo();
  }

  Future<void> _initializeUserInfo() async {
    final token = await TokenStorage.getToken();
    if (token == null || token.isEmpty) {
      setState(() {
        userInfo = Future.error('No valid token found. Please log in again.');
      });
    } else {
      setState(() {
        userInfo = AuthService().getUserInfo();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userInfo,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
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
                  Text('Name: ${user['name'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Email: ${user['email'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Phone: ${user['phone'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  Text('Address: ${user['address'] ?? 'N/A'}', style: const TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
          return const Center(child: Text('No data found'));
        },
      ),
    );
  }
}
