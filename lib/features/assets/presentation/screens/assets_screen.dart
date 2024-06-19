import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/app_bar/default_app_bar.dart';
import '../../../../components/buttons/toggle_button.dart';
import '../../../../components/screens/error_screen.dart';
import '../../../../components/screens/loading_screen.dart';
import '../../../../components/text_fields/search_text_field.dart';
import '../../../../l10n/generated/l10n.dart';
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
            appBar: DefaultAppBar(
              title: S.of(context).assets,
            ),
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        SearchTextField(
                          hintText: S.of(context).searchAssetOrLocal,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ToggleButton(
                              text: S.of(context).energySensor,
                              leadingIcon: Icons.bolt_outlined,
                              onTap: () => context
                                  .read<AssetsCubit>()
                                  .toggleEnergySensorFilter(),
                            ),
                            const SizedBox(width: 8),
                            ToggleButton(
                              text: S.of(context).critic,
                              leadingIcon: Icons.error_outline,
                              onTap: () => context
                                  .read<AssetsCubit>()
                                  .toggleCriticStatusFilter(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: AssetsTree(nodes: state.nodes),
                  ),
                ],
              ),
            ),
          );

        default:
          return const ErrorScreen();
      }
    });
  }

  loadAssets() => context.read<AssetsCubit>().loadAssets(widget.companyId);
}
