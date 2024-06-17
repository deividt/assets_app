import 'package:flutter/material.dart';

import '../../../../../components/icons/default_icon.dart';
import '../../../../../components/icons/icon_tokens.dart';
import '../../../data/entities/tree_node.dart';
import '../../../data/enums/node_type.dart';

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

  Widget _getIconForType(NodeType type) {
    switch (type) {
      case NodeType.location:
        return const DefaultIcon(name: IconTokens.location);
      case NodeType.asset:
        return const DefaultIcon(name: IconTokens.asset);
      case NodeType.component:
        return const DefaultIcon(name: IconTokens.component);
      default:
        return const Icon(Icons.question_mark);
    }
  }
}
