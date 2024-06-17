import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../navigation/screen_names.dart';
import '../../providers/assets_provider.dart';
import '../screens/assets_screen.dart';

class AssetsRoutes {
  static const String assets = 'assets/:companyId';

  static final GoRoute routes = GoRoute(
    name: ScreenNames.assets,
    path: assets,
    builder: (BuildContext context, GoRouterState state) => AssetsProvider(
      child: AssetsScreen(
        companyId: state.pathParameters['companyId']!,
      ),
    ),
  );
}
