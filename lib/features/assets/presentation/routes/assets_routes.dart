import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../navigation/screen_names.dart';
import '../screens/assets_screen.dart';

class AssetsRoutes {
  static const String assets = 'assets';

  static final GoRoute routes = GoRoute(
    name: ScreenNames.assets,
    path: assets,
    builder: (BuildContext context, GoRouterState state) =>
        const AssetsScreen(),
  );
}
