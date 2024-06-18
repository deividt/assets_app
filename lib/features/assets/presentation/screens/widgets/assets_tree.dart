import 'package:flutter/material.dart';

import '../../../../../components/icons/default_icon.dart';
import '../../../../../components/icons/icon_tokens.dart';
import '../../../../../theme/default_theme.dart';
import '../../../../../theme/theme_colors.dart';
import '../../../data/entities/tree_node.dart';
import '../../../data/enums/asset_type.dart';
import '../../../data/enums/sensor_status.dart';
import '../../../data/enums/sensor_type.dart';

class AssetsTree extends StatelessWidget {
  const AssetsTree({
    super.key,
    required this.nodes,
  });

  final Map<String, TreeNode> nodes;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: nodes.values.map((node) => AssetTile(node: node)).toList(),
    );
  }
}

class AssetTile extends StatefulWidget {
  const AssetTile({
    super.key,
    required this.node,
  });

  final TreeNode node;

  @override
  State<AssetTile> createState() => _AssetTileState();
}

class _AssetTileState extends State<AssetTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.node.children.isEmpty) {
      return ListTile(
        title: _buildTileRow(widget.node),
      );
    }

    return Theme(
      data: defaultTheme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        controlAffinity: ListTileControlAffinity.leading,
        childrenPadding: const EdgeInsets.only(left: 12),
        title: _buildTileRow(widget.node),
        leading: Icon(_isExpanded ? Icons.expand_more : Icons.expand_less),
        children: widget.node.children
            .map((child) => AssetTile(node: child))
            .toList(),
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
      ),
    );
  }

  Widget _buildTileRow(TreeNode node) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getAssetTypeIcon(node.assetType),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              node.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        if (node.sensorType != null && node.sensorStatus != null) ...[
          _getSensorTypeIcon(node.sensorType!, node.sensorStatus!),
        ]
      ],
    );
  }

  Widget _getAssetTypeIcon(AssetType type) {
    switch (type) {
      case AssetType.location:
        return const DefaultIcon(name: IconTokens.location);
      case AssetType.asset:
        return const DefaultIcon(name: IconTokens.asset);
      case AssetType.component:
        return const DefaultIcon(name: IconTokens.component);
      default:
        return const Icon(Icons.question_mark);
    }
  }

  Widget _getSensorTypeIcon(SensorType sensorType, SensorStatus sensorStatus) {
    switch (sensorType) {
      case SensorType.energy:
        return Icon(
          Icons.electric_bolt_outlined,
          color: _getIconColorBySensorStatus(sensorStatus),
        );
      case SensorType.vibration:
        return Icon(
          Icons.circle,
          color: _getIconColorBySensorStatus(sensorStatus),
        );
      default:
        return Icon(
          Icons.question_mark,
          color: _getIconColorBySensorStatus(sensorStatus),
        );
    }
  }

  Color _getIconColorBySensorStatus(SensorStatus sensorStatus) {
    switch (sensorStatus) {
      case SensorStatus.alert:
        return ThemeColors.errorColor;
      case SensorStatus.operating:
        return ThemeColors.okColor;
      case SensorStatus.na:
        return ThemeColors.primarySurfaceColor;
    }
  }
}
