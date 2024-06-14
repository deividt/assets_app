import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/app_bar/default_app_bar.dart';
import '../../../../components/buttons/primary_button.dart';
import '../../../../components/screens/error_screen.dart';
import '../../../../components/screens/loading_screen.dart';
import '../../../../navigation/screen_names.dart';
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
            appBar: const DefaultAppBar(
              title: 'TRACTIAN',
            ),
            body: Padding(
              padding: const EdgeInsets.all(21.0),
              child: Center(
                child: ListView(
                  children: state.companies
                      .map(
                        (company) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 21,
                          ),
                          child: PrimaryButton(
                            onPressed: () =>
                                context.goNamed(ScreenNames.assets),
                            text: company.name ?? '',
                          ),
                        ),
                      )
                      .toList(),
                ),
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
