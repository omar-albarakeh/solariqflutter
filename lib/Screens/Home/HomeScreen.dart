import 'package:flutter/material.dart';
import '../../Config/SharedPreferences.dart';
import '../../Controllers/AuthController.dart';
import '../Auth/UserProfileScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String token = '';
  Map<String, dynamic> userInfo = {};
  bool isLoading = true; // For managing loading state
  final AuthController _authController = AuthController();

  @override
  void initState() {
    super.initState();
    _loadTokenAndUserInfo();
  }

  // Load token from shared preferences and fetch user info
  Future<void> _loadTokenAndUserInfo() async {
    try {
      final storedToken = await getToken();
      if (storedToken != null) {
        token = storedToken;
        await _fetchUserInfo(storedToken);
      } else {
        _showErrorSnackBar('Token not found. Please login again.');
      }
    } catch (e) {
      _showErrorSnackBar('Error loading token: ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Fetch user info using the token
  Future<void> _fetchUserInfo(String token) async {
    try {
      final response = await _authController.getUserInfoController(token);
      if (response['status'] == 'success') {
        setState(() {
          userInfo = response['data'];
        });
      } else {
        throw Exception(response['message'] ?? 'Failed to load user info');
      }
    } catch (e) {
      _showErrorSnackBar('Error: ${e.toString()}');
    }
  }

  // Show error message as a SnackBar
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Screen")),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : token.isEmpty
            ? const Text(
          "No token found. Please login.",
          style: TextStyle(fontSize: 16),
        )
            : userInfo.isEmpty
            ? const Text(
          "Failed to load user info.",
          style: TextStyle(fontSize: 16),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hello, ${userInfo['name'] ?? 'User'}",
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfileScreen(token: token),
                  ),
                );
              },
              child: const Text("Go to Profile"),
            ),
          ],
        ),
      ),
    );
  }}