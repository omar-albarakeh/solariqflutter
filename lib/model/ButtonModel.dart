import 'package:flutter/material.dart';

class ButtonModel {
  final String buttonText;
  final bool hasBorder;
  final Color? backgroundColor;
  final Widget? navigateTo;
  final bool showDialogOnTap;
  final String? dialogTitle;
  final String? dialogContent;

  const ButtonModel({
    required this.buttonText,
    this.hasBorder = true,
    this.backgroundColor,
    this.navigateTo,
    this.showDialogOnTap = false,
    this.dialogTitle,
    this.dialogContent,
  });
}