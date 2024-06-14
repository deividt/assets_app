import 'package:flutter/material.dart';

import '../../../../components/app_bar/default_app_bar.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: DefaultAppBar(
        title: 'Assets',
      ),
      body: Center(
        child: Text('Center'),
      ),
    );
  }
}
