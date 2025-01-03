import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final List<Widget> subButtons;
  final Widget mainButton;
  final bool isExpanded;

  const FloatingActionButtonWidget({
    Key? key,
    required this.subButtons,
    required this.mainButton,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...subButtons.asMap().entries.map((entry) {
                  int index = entry.key;
                  Widget button = entry.value;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    height: isExpanded ? 56.0 : 0.0,
                    margin: EdgeInsets.only(
                      bottom: isExpanded ? (index + 1) * 10.0 : 0.0,
                    ),
                    child: Opacity(
                      opacity: isExpanded ? 1.0 : 0.0,
                      child: button,
                    ),
                  );
                }).toList(),
                mainButton,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
