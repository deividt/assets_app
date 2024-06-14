import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/screens/error_screen.dart';
import '../../../../components/screens/loading_screen.dart';
import '../../cubit/companies_cubit.dart';
import '../../cubit/companies_state.dart';

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

class _CompaniesScreenState extends State<CompaniesScreen> {
  @override
  void initState() {
    loadCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesCubit, CompaniesState>(
        builder: (context, state) {
      switch (state) {
        case ErrorState():
          return const ErrorScreen();

        case LoadingState():
          return const LoadingScreen();

        case SuccessState():
          return Scaffold(
            appBar: AppBar(title: const Text('Home Screen')),
            body: Center(
              child: ListView(
                children: state.companies
                    .map(
                      (company) => Text(company.name ?? ''),
                    )
                    .toList(),
              ),
            ),
          );

        default:
          return const ErrorScreen();
      }
    });
  }

  loadCompanies() => context.read<CompaniesCubit>().loadCompanies();
}
