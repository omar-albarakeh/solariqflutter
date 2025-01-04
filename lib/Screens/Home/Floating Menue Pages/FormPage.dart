import 'package:flutter/material.dart';

import '../../../Config/AppColor.dart';
import '../../../Config/AppText.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primary,
          title: const Text(
            'SOLARIQ-Form',
            style: AppTextStyles.appBarTitle,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.linearGradient,
          ),
        ));
  }
}
