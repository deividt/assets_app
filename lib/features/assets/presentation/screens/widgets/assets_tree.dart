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
      children: nodes.values
          .map(
            (node) => AssetTile(
              node: node,
              isRoot: true,
            ),
          )
          .toList(),
    );
  }
}

class AssetTile extends StatefulWidget {
  const AssetTile({
    super.key,
    required this.node,
    required this.isRoot,
  });

  final TreeNode node;
  final bool isRoot;

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
        visualDensity: const VisualDensity(vertical: -4),
        contentPadding: EdgeInsets.only(left: widget.isRoot ? 0 : 40),
      );
    }

    return Theme(
      data: defaultTheme.copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        initiallyExpanded: true,
        controlAffinity: ListTileControlAffinity.leading,
        childrenPadding: const EdgeInsets.only(left: 20),
        tilePadding: const EdgeInsets.only(),
        dense: true,
        visualDensity: const VisualDensity(vertical: -4),
        title: _buildTileRow(widget.node),
        leading: Icon(
          _isExpanded ? Icons.expand_more : Icons.expand_less,
        ),
        children: widget.node.children
            .map(
              (child) => AssetTile(
                node: child,
                isRoot: false,
              ),
            )
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getAssetTypeIcon(node.assetType),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Text(
              node.name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
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
          size: 14,
          Icons.bolt_outlined,
          color: _getIconColorBySensorStatus(sensorStatus),
        );
      case SensorType.vibration:
        return Icon(
          size: 12,
          Icons.circle,
          color: _getIconColorBySensorStatus(sensorStatus),
        );
      default:
        return Icon(
          size: 12,
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
