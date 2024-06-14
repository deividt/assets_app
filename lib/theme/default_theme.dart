import 'package:flutter/material.dart';

import 'theme_colors.dart';

var _defaultPageTransitionBuilder = const FadeUpwardsPageTransitionsBuilder();

var defaultTheme = ThemeData(
  pageTransitionsTheme: PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.iOS: _defaultPageTransitionBuilder,
      TargetPlatform.android: _defaultPageTransitionBuilder,
      TargetPlatform.linux: _defaultPageTransitionBuilder,
      TargetPlatform.macOS: _defaultPageTransitionBuilder,
      TargetPlatform.windows: _defaultPageTransitionBuilder,
    },
  ),
  primaryColor: ThemeColors.primaryColor,
  useMaterial3: true,
);
