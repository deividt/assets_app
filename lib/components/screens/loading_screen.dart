import 'package:flutter/material.dart';

import '../../theme/theme_colors.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: SizedBox(
          width: 56,
          height: 56,
          child: CircularProgressIndicator(
            color: ThemeColors.appBarBackgroundColor,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}
