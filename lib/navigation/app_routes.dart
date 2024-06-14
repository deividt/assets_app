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
}
