import 'package:flutter/material.dart';

class DefaultIcon extends StatelessWidget {
  const DefaultIcon({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      name,
      height: 22,
      width: 22,
    );
  }
}
