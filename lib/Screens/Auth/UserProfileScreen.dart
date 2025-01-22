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
            Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'User Information',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildUserInfoRow('Name', userInfo['name']),
                    _buildUserInfoRow('Email', userInfo['email']),
                    _buildUserInfoRow('Phone', userInfo['phone']),
                    _buildUserInfoRow('Address', userInfo['address']),
                  ],
                ),
              ),
            ),

            if (userInfo.containsKey('solarInfo'))
              Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Solar Information',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ..._getFilteredSolarInfo().entries.map((entry) {
                        return _buildUserInfoRow(entry.key, entry.value.toString());
                      }).toList(),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value ?? 'Not provided',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getFilteredSolarInfo() {
    final solarInfo = userInfo['solarInfo'] as Map<String, dynamic>;
    return Map.from(solarInfo)..remove('_id');
  }
}