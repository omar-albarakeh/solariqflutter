import 'package:flutter/material.dart';

import '../../Services/AuthServices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      final response = await _authService.getUserInfo();
      if (response['status'] == 'success' && response.containsKey('data')) {
        setState(() {
          userInfo = response['data'];
        });
      } else {
        throw Exception(response['message'] ?? 'Failed to fetch user info');
      }
    } catch (e) {
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
        title: const Text('Home Screen'),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${userInfo['name']}!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${userInfo['email']}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            if (userInfo.containsKey('phone'))
              Text(
                'Phone: ${userInfo['phone']}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            const SizedBox(height: 10),
            if (userInfo.containsKey('address') &&
                userInfo['address'] != null &&
                userInfo['address'].isNotEmpty)
              Text(
                'Address: ${userInfo['address']}',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
          ],
        ),
      ),
    );
  }
}
