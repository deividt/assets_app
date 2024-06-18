import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({
    super.key,
    required this.text,
    this.leadingIcon,
  });

  final String text;
  final IconData? leadingIcon;

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool _isClicked = false;

  void _toggleButton() {
    setState(() {
      _isClicked = !_isClicked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleButton,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              _isClicked ? ThemeColors.primarySurfaceColor : Colors.transparent,
          border:
              _isClicked ? null : Border.all(color: ThemeColors.primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.leadingIcon != null) ...[
              Icon(
                widget.leadingIcon,
                size: 14,
                color: _isClicked
                    ? ThemeColors.primaryTextColor
                    : ThemeColors.primaryColor,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _isClicked
                    ? ThemeColors.primaryTextColor
                    : ThemeColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
