import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppText.dart';
import '../../../Config/AppColor.dart';


class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

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
              'Solar Reccomendation Form', style: AppTextStyles.appBarTitle),
          elevation: 0,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: AppColor.linearGradient,
          ),
        )
    );
  }
}