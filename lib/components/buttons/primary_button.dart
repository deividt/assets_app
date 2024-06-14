import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final VoidCallback? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () {},
      style: ButtonStyle(
        padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
        elevation: WidgetStateProperty.all<double>(0.0),
        shape: WidgetStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.disabled)) {
              return ThemeColors.primarySurfaceDisabledColor;
            }
            return ThemeColors.primarySurfaceColor;
          },
        ),
      ),
      icon: const Icon(Icons.account_tree_outlined), // Set your desired icon
      label: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Text(
          text,
          style: const TextStyle(
            color: ThemeColors.primaryTextColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
