import 'package:flutter/material.dart';
import '../../Config/SharedPreferences.dart';
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
      // Retrieve token from storage
      final token = await TokenStorage.getToken();
      print('Token Retrieved: $token');

      if (token == null || token.isEmpty) {
        throw Exception('No token found. Please log in again.');
      }

      // Fetch user info using the token
      final response = await _authService.getUserInfo();
      print('User Info Response: $response');

      // Handle response structure
      if (response.containsKey('status') &&
          response['status'] == 'success' &&
          response.containsKey('data')) {
        setState(() {
          userInfo = response['data'];
        });
      } else {
        throw Exception(response['message'] ?? 'Unexpected response structure');
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
