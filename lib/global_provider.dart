import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation/app_routes.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({
    required this.child,
    required this.dio,
    super.key,
  });

  final Widget child;
  final Dio dio;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<Dio>.value(value: dio),
        RepositoryProvider(
          create: (_) => AppRoutes(),
        ),
      ],
      child: child,
    );
  }
}
