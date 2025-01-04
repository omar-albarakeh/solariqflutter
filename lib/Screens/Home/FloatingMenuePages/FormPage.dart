import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppText.dart';
import '../../../Config/AppColor.dart';
import '../../../Widgets/Common/CustomTextField.dart';
import 'ChatwithBot.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _powerConsumptionController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _roofSpaceController = TextEditingController();
  final TextEditingController _batteryCountController = TextEditingController();
  final TextEditingController _panelCountController = TextEditingController();
  final TextEditingController _inverterSizeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _powerConsumptionController.dispose();
    _budgetController.dispose();
    _roofSpaceController.dispose();
    _batteryCountController.dispose();
    _panelCountController.dispose();
    _inverterSizeController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final data = {
        'Power Consumption': _powerConsumptionController.text,
        'Budget': _budgetController.text,
        'Roof Space': _roofSpaceController.text,
        'Battery Count': _batteryCountController.text,
        'Panel Count': _panelCountController.text,
        'Inverter Size': _inverterSizeController.text,
      };

      final formattedData = data.entries.map((entry) => '${entry.key}: ${entry.value}').join('\n');

      final message =
          "I want to get solar energy. Here are my requirements:\n\n"
          "$formattedData\n\n"
          "Can you recommend the best fit for me?";

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatWithBot(
            initialMessage: {'message': message},
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: const Text('Form', style: AppTextStyles.appBarTitle),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColor.linearGradient,
        ),
        padding: const EdgeInsets.all(30.0),
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Recommendation form",
                style: AppTextStyles.title,
              ),
              const SizedBox(height: 30),
              CustomTextField(
                label: 'Power Consumption (kWh)',
                controller: _powerConsumptionController,
                icon: Icons.bolt,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your power consumption needs';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Budget (USD)',
                controller: _budgetController,
                icon: Icons.monetization_on,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your budget';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Roof Space (sqm)',
                controller: _roofSpaceController,
                icon: Icons.roofing,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your roof space';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Recommended Battery Count',
                controller: _batteryCountController,
                keyboardType: TextInputType.number,
                icon: Icons.battery_4_bar,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recommended number of batteries';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Recommended Panel Count',
                controller: _panelCountController,
                icon: Icons.solar_power,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the recommended number of panels';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Inverter Size (kW)',
                controller: _inverterSizeController,
                keyboardType: TextInputType.number,
                icon: Icons.gif_box,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the inverter size';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _submitForm,
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
