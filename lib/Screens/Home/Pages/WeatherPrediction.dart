import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Config/AppText.dart';
import '../../../Widgets/Home/ThemeNotifier.dart';

class Weatherprediction extends StatefulWidget {
  const Weatherprediction({super.key});

  @override
  State<Weatherprediction> createState() => _WeatherpredictionState();
}

class _WeatherpredictionState extends State<Weatherprediction> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
      backgroundColor: theme.primaryColor,
      title: const Text(
        'Weather Prediction',
        style: AppTextStyles.appBarTitle,
      ),
      actions: [
        IconButton(
          icon: Icon(
            theme.brightness == Brightness.dark
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
          onPressed: () {
            Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
          },
        ),
      ],
    ));
  }
}
