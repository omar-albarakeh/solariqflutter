import 'package:flutter/material.dart';

import '../../../Config/AppText.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
      backgroundColor: theme.primaryColor,
      title: const Text(
        'Community',
        style: AppTextStyles.appBarTitle,
      ),
    ));
  }
}
