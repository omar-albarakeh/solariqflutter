import 'package:flutter/material.dart';
import 'package:solariqflutter/Config/AppColor.dart';

import '../../Config/AppText.dart';


class Buttons extends StatelessWidget {
  final bool hasBorder;
  final Color? backgroundColor;
  final String buttonText;
  final Widget? navigateTo;
  final bool showDialogOnTap;
  final String? dialogTitle;
  final String? dialogContent;
  final VoidCallback? onTap;

  const Buttons({
    Key? key,
    this.hasBorder = true,
    this.backgroundColor,
    required this.buttonText,
    this.navigateTo,
    this.showDialogOnTap = false,
    this.dialogTitle,
    this.dialogContent,
    this.onTap,
  }) : super(key: key);

  void _showInformationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(dialogTitle!),
          content: Text(dialogContent!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else if (showDialogOnTap) {
          _showInformationDialog(context);
        } else if (navigateTo != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => navigateTo!),
          );
        }
      },
      child: Container(
        height: 60,
        width: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: backgroundColor ?? AppColor.buttonPrimary,
          border: hasBorder ? Border.all(color: AppColor.buttonBorder) : null,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: AppTextStyles.buttonText,
          ),
        ),
      ),
    );
  }
}
