import 'package:flutter/material.dart';
import '../../Config/SharedPreferences.dart';
import '../../Services/AuthServices.dart';

class Userprofilescreen extends StatefulWidget {
  const Userprofilescreen({Key? key}) : super(key: key);

  @override
  State<Userprofilescreen> createState() => _UserprofilescreenState();
}

class _UserprofilescreenState extends State<Userprofilescreen> {
  Map<String, dynamic> userInfo = {};
  bool isLoading = true;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _fetchUserInfo();
  }

  Future<void> _fetchUserInfo() async {
    try {
      final token = await TokenStorage.getToken();
      print('Token Retrieved: $token');

      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in again.');
      }

      final isTokenValid = await TokenStorage.isTokenValid();
      if (!isTokenValid) {
        throw Exception('Token is invalid or expired. Please log in again.');
      }

      final response = await _authService.getUserInfo();
      print('User Info Response:');
      response.forEach((key, value) {
        print('$key: $value');
      });

      if (response.containsKey('name') && response.containsKey('email')) {
        setState(() {
          userInfo = response;
        });
      } else {
        throw Exception('Unexpected response structure');
      }
    } catch (e) {
      print('Error fetching user info: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await _authService.logout();
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userInfo.isEmpty
          ? const Center(child: Text('Failed to load user info'))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'User Information',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            ...userInfo.entries
                .where((entry) => entry.key != 'solarInfo')
                .map((entry) {
              return ListTile(
                title: Text('${entry.key}: ${entry.value}'),
              );
            }).toList(),

            const SizedBox(height: 20),

            if (userInfo.containsKey('solarInfo'))
              Text(
                'Solar Information',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            if (userInfo.containsKey('solarInfo'))
              const SizedBox(height: 10),
            if (userInfo.containsKey('solarInfo'))
              ...userInfo['solarInfo'].entries.map((entry) {
                return ListTile(
                  title: Text('${entry.key}: ${entry.value}'),
                );
              }).toList(),
          ],
        ),
      ),
    );
  }
}
