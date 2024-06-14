import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../navigation/screen_names.dart';
import '../../providers/companies_provider.dart';
import '../screens/companies_screen.dart';

class CompaniesRoutes {
  static const String companies = '/companies';

  static final GoRoute routes = GoRoute(
    name: ScreenNames.companies,
    path: companies,
    builder: (BuildContext context, GoRouterState state) =>
        const CompaniesProvider(
      child: CompaniesScreen(),
    ),
  );
}
