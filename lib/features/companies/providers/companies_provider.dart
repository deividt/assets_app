import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/companies_cubit.dart';
import '../repositories/companies_repository.dart';
import '../repositories/i_companies_repository.dart';
import '../rest_clients/companies_rest_client.dart';

class CompaniesProvider extends StatelessWidget {
  const CompaniesProvider({
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
        BlocProvider<CompaniesCubit>(
          create: (context) => CompaniesCubit(
            context.read<ICompaniesRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
