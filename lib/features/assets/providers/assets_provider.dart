import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../companies/repositories/companies_repository.dart';
import '../../companies/repositories/i_companies_repository.dart';
import '../../companies/rest_clients/companies_rest_client.dart';
import '../cubit/assets_cubit.dart';

class AssetsProvider extends StatelessWidget {
  const AssetsProvider({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        RepositoryProvider<CompaniesRestClient>(
          create: (context) => CompaniesRestClient(
            context.read<Dio>(),
          ),
        ),
        RepositoryProvider<ICompaniesRepository>(
          create: (context) => CompaniesRepository(
            context.read<CompaniesRestClient>(),
          ),
        ),
        BlocProvider<AssetsCubit>(
          create: (context) => AssetsCubit(
            context.read<ICompaniesRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
