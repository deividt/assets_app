import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    required this.hintText,
    this.icon = Icons.search,
    this.onChanged,
  });

  final String hintText;
  final IconData? icon;
  final double height = 36;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        cursorColor: ThemeColors.secondaryTextColor,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: ThemeColors.secondaryTextColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ThemeColors.secondaryTextColor,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: (height - 20) / 2),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          fillColor: ThemeColors.secondarySurfaceColor,
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(),
          prefixIcon: Icon(
            icon,
            size: 14,
            color: ThemeColors.secondaryTextColor,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.0),
      borderSide: BorderSide.none,
    );
  }
}
