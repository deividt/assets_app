import '../../../../util/extensions/string_extensions.dart';
import '../../../companies/data/entities/companies_assets.dart';
import '../../../companies/data/entities/companies_locations.dart';
import '../enums/asset_type.dart';
import '../enums/sensor_status.dart';
import '../enums/sensor_type.dart';

class TreeNode {
  TreeNode({
    required this.id,
    required this.name,
    required this.assetType,
    required this.children,
    this.sensorType,
    this.sensorStatus,
    this.parentId,
  });

  final String id;
  final String name;
  final AssetType assetType;
  final SensorType? sensorType;
  final SensorStatus? sensorStatus;
  final List<TreeNode> children;
  String? parentId;

  TreeNode copyWith({
    String? id,
    String? name,
    AssetType? assetType,
    SensorType? sensorType,
    SensorStatus? sensorStatus,
    List<TreeNode>? children,
  }) {
    return TreeNode(
      id: id ?? this.id,
      name: name ?? this.name,
      assetType: assetType ?? this.assetType,
      sensorType: sensorType ?? this.sensorType,
      sensorStatus: sensorStatus ?? this.sensorStatus,
      children:
          children ?? this.children.map((child) => child.copyWith()).toList(),
    );
  }
}

Map<String, TreeNode> buildTree(
    List<CompaniesLocations> locations, List<CompaniesAssets> assets) {
  Map<String, TreeNode> nodes = {};
  Set<String> childNodeIds = {};

  for (var location in locations) {
    if (location.id == null || location.name == null) {
      continue;
    }

    nodes[location.id!] = TreeNode(
      id: location.id!,
      name: location.name!,
      assetType: AssetType.location,
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
      assetType:
          asset.sensorType == null ? AssetType.asset : AssetType.component,
      sensorType: asset.sensorType?.enumFromString(SensorType.values),
      sensorStatus: asset.status?.enumFromString(SensorStatus.values),
      children: [],
    );
  }

  for (var asset in assets) {
    if (asset.parentId != null) {
      TreeNode tempNode = nodes[asset.id]!;
      tempNode.parentId = asset.parentId;

      nodes[asset.parentId!]!.children.add(nodes[asset.id]!);
      childNodeIds.add(asset.id!);
    } else if (asset.locationId != null) {
      TreeNode tempNode = nodes[asset.id]!;
      tempNode.parentId = asset.locationId;

      nodes[asset.locationId!]!.children.add(nodes[asset.id]!);
      childNodeIds.add(asset.id!);
    }
  }

  for (var location in locations) {
    if (location.parentId != null) {
      TreeNode tempNode = nodes[location.id]!;
      tempNode.parentId = location.parentId;

      nodes[location.parentId!]!.children.add(nodes[location.id]!);
      childNodeIds.add(location.id!);
    }
  }

  for (var childNodeId in childNodeIds) {
    nodes.remove(childNodeId);
  }

  return nodes;
}

TreeNode? getNodeById(Iterable<TreeNode> nodes, String id) {
  TreeNode? result;

  for (final node in nodes) {
    result = _getNodeByIdRecursive(node, id);
    if (result != null) {
      return result;
    }
  }

  return null;
}

TreeNode? _getNodeByIdRecursive(TreeNode node, String id) {
  if (node.id == id) {
    return node;
  }

  TreeNode? childNode;
  for (final child in node.children) {
    childNode = _getNodeByIdRecursive(child, id);
    if (childNode != null) {
      return childNode;
    }
  }

  return null;
}
