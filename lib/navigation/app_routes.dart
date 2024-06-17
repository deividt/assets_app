import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/companies/presentation/routes/companies_routes.dart';

class AppRoutes {
  static String initialLocationPath() => CompaniesRoutes.companies;

  static final GoRouter routes = GoRouter(
    initialLocation: initialLocationPath(),
    routes: <RouteBase>[
      CompaniesRoutes.routes,
    ],
  );

  void goTo(BuildContext context, String screenName,
          {Map<String, String> pathParameters = const <String, String>{}}) =>
      context.goNamed(screenName, pathParameters: pathParameters);
}
