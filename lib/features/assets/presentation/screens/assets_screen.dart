import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/app_bar/default_app_bar.dart';
import '../../../../components/screens/error_screen.dart';
import '../../../../components/screens/loading_screen.dart';
import '../../cubit/assets_cubit.dart';
import '../../cubit/assets_state.dart';
import 'widgets/assets_tree.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key, required this.companyId});

  final String companyId;

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  @override
  void initState() {
    loadAssets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetsCubit, AssetsState>(builder: (context, state) {
      switch (state) {
        case ErrorState():
          return const ErrorScreen();

        case LoadingState():
          return const LoadingScreen();

        case SuccessState():
          return Scaffold(
            appBar: const DefaultAppBar(
              title: 'Assets',
            ),
            body: AssetsTree(nodes: state.nodes),
          );

        default:
          return const ErrorScreen();
      }
    });
  }

  loadAssets() => context.read<AssetsCubit>().loadCompanies(widget.companyId);
}
