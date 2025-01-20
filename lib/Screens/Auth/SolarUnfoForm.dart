import 'package:flutter/material.dart';
import '../../Config/AppColor.dart';
import '../../Config/SharedPreferences.dart';
import '../../Controllers/AuthController.dart';
import '../../Widgets/Common/CustomTextField.dart';

class SolarInfoForm extends StatefulWidget {
  const SolarInfoForm({super.key});

  @override
  State<SolarInfoForm> createState() => _SolarInfoFormState();
}

class _SolarInfoFormState extends State<SolarInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final _panelAreaController = TextEditingController();
  final _panelWattController = TextEditingController();
  final _panelEfficiencyController = TextEditingController();
  final _panelsNbController = TextEditingController();
  final AuthController _authController = AuthController();

  String? _userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    try {
      final tokenValid = await TokenStorage.isTokenValid();
      if (!tokenValid) {
        throw Exception('Token is invalid or expired.');
      }

      final userId = await TokenStorage.getUserIdFromToken();
      if (userId == null) {
        throw Exception('Failed to extract user ID.');
      }

      setState(() => _userId = userId);
    } catch (e) {
      _showSnackBar('Error fetching user ID: ${e.toString()}');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (_userId == null || _userId!.isEmpty) {
      _showSnackBar("User ID is not available.");
      return;
    }

    final formData = {
      'panelArea': double.tryParse(_panelAreaController.text.trim()) ?? 0,
      'panelWatt': int.tryParse(_panelWattController.text.trim()) ?? 0,
      'panelEfficiency':
      double.tryParse(_panelEfficiencyController.text.trim()) ?? 0,
      'panelsNb': int.tryParse(_panelsNbController.text.trim()) ?? 0,
      'userId': int.tryParse(_userId!) ?? 0,
    };

    try {
      final response = await _authController.submitSolarInfo(formData);

      if (response['status'] == 'success') {
        _showSnackBar('Solar info submitted successfully!');
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        throw Exception(response['message'] ?? 'Failed to submit solar info.');
      }
    } catch (e) {
      _showSnackBar('Error: ${e.toString()}');
    }
  }

  @override
  void dispose() {
    _panelAreaController.dispose();
    _panelWattController.dispose();
    _panelEfficiencyController.dispose();
    _panelsNbController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solar Information')),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: AppColor.background,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(
                    label: 'Panel Area (m²)',
                    controller: _panelAreaController,
                    validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Please enter the panel area'
                        : null,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Panel Watt (W)',
                    controller: _panelWattController,
                    validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Please enter the panel watt'
                        : null,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Panel Efficiency (%)',
                    controller: _panelEfficiencyController,
                    validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Please enter the panel efficiency'
                        : null,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    label: 'Number of Panels',
                    controller: _panelsNbController,
                    validator: (value) =>
                    value == null || value.trim().isEmpty
                        ? 'Please enter the number of panels'
                        : null,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Submit' ,style:TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}