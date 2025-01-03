import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'SolarIQ.dart';
import 'Widgets/Home/ThemeNotifier.dart';


Future<void> main() async {
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: const SolarIQ(),
    ),
  );
}
