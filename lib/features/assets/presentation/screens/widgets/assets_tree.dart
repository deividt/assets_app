import 'package:flutter/material.dart';

import '../../../data/entities/tree_node.dart';

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
          .expand((rootNode) => rootNode.children.map(_buildNode))
          .toList(),
    );
  }

  Widget _buildNode(TreeNode node) {
    return ExpansionTile(
      controlAffinity: ListTileControlAffinity.leading,
      childrenPadding: const EdgeInsets.only(left: 12),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getIconForType(node.type),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              node.name,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      children: node.children.map(_buildNode).toList(),
    );
  }

  Widget _getIconForType(String type) {
    switch (type) {
      case 'location':
        return const Icon(Icons.location_on);
      case 'asset':
        return const Icon(Icons.build);
      case 'component':
        return const Icon(Icons.settings);
      default:
        return const Icon(Icons.device_unknown);
    }
  }
}
