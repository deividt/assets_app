import '../../../companies/data/entities/companies_assets.dart';
import '../../../companies/data/entities/companies_locations.dart';

class TreeNode {
  TreeNode({
    required this.id,
    required this.name,
    required this.type,
    required this.children,
  });

  final String id;
  final String name;
  final String type; // 'location', 'asset' or 'component'
  final List<TreeNode> children;
}

Map<String, TreeNode> buildTree(
    List<CompaniesLocations> locations, List<CompaniesAssets> assets) {
  Map<String, TreeNode> nodes = {};

  for (var location in locations) {
    if (location.id == null || location.name == null) {
      continue;
    }

    nodes[location.id!] = TreeNode(
      id: location.id!,
      name: location.name!,
      type: 'location',
      children: [],
    );
  }

  for (var asset in assets) {
    if (asset.id == null || asset.name == null) {
      continue;
    }

    nodes[asset.id!] = TreeNode(
      id: asset.id!,
      name: asset.name!,
      type: asset.sensorType == null ? 'asset' : 'component',
      children: [],
    );
  }

  for (var asset in assets) {
    if (asset.parentId != null) {
      nodes[asset.parentId!]!.children.add(nodes[asset.id]!);
    } else if (asset.locationId != null) {
      nodes[asset.locationId!]!.children.add(nodes[asset.id]!);
    }
  }

  for (var location in locations) {
    if (location.parentId != null) {
      nodes[location.parentId!]!.children.add(nodes[location.id]!);
    }
  }

  return nodes;
}
