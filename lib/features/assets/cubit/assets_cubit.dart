import 'package:flutter_bloc/flutter_bloc.dart';

import '../../companies/data/entities/companies_assets.dart';
import '../../companies/data/entities/companies_locations.dart';
import '../../companies/repositories/i_companies_repository.dart';
import '../data/entities/tree_node.dart';
import '../data/enums/asset_type.dart';
import '../data/enums/sensor_status.dart';
import '../data/enums/sensor_type.dart';
import 'assets_state.dart';

class AssetsCubit extends Cubit<AssetsState> {
  AssetsCubit(this._repository) : super(const AssetsState.loading());

  final ICompaniesRepository _repository;
  late Map<String, TreeNode> _allNodes;
  bool _isEnergySensorFilterActive = false;
  bool _isCriticStatusFilterActive = false;
  String _searchQuery = '';

  Future<void> loadAssets(String companyId) async {
    emit(const AssetsState.loading());

    List<CompaniesLocations> locations = [];
    List<CompaniesAssets> assets = [];

    final resultLocations = await _repository.getCompaniesLocations(companyId);
    final resultAssets = await _repository.getCompaniesAssets(companyId);

    resultLocations.fold((failure) {
      emit(const AssetsState.error());
      return;
    }, (successLocations) {
      locations = successLocations;
    });

    resultAssets.fold((failure) => emit(const AssetsState.error()),
        (successAssets) {
      assets = successAssets;
      return;
    });

    _allNodes = buildTree(locations, assets);
    emit(AssetsState.success(_allNodes));
  }

  void toggleEnergySensorFilter() {
    _isEnergySensorFilterActive = !_isEnergySensorFilterActive;
    _applyFilters();
  }

  void toggleCriticStatusFilter() {
    _isCriticStatusFilterActive = !_isCriticStatusFilterActive;
    _applyFilters();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    if (!_isEnergySensorFilterActive &&
        !_isCriticStatusFilterActive &&
        _searchQuery.isEmpty) {
      emit(AssetsState.success(_allNodes));
      return;
    }

    final List<String> filteredIds = [];
    _allNodes.forEach((key, node) {
      _addNodeAndParentIfMatchesFilter(filteredIds, node);
    });

    final filteredNodes = _copyAllNodes();
    _removeNodesNotInKeys(filteredNodes, filteredIds);

    emit(AssetsState.success(filteredNodes));
  }

  bool _nodeMatchesFilter(TreeNode node) {
    bool matches = true;

    if (_isEnergySensorFilterActive) {
      matches &= (node.assetType == AssetType.component &&
          node.sensorType == SensorType.energy);
    }

    if (_isCriticStatusFilterActive) {
      matches &= (node.sensorStatus == SensorStatus.alert);
    }

    if (_searchQuery.isNotEmpty) {
      matches &= node.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }

    return matches;
  }

  void _addNodeAndParentIfMatchesFilter(
    List<String> filteredIds,
    TreeNode node,
  ) {
    if (_nodeMatchesFilter(node)) {
      _addNodeWithParents(filteredIds, node);
      return;
    }

    for (final child in node.children) {
      _addNodeAndParentIfMatchesFilter(filteredIds, child);
    }
  }

  void _addNodeWithParents(List<String> filteredIds, TreeNode node) {
    if (filteredIds.contains(node.id)) {
      return;
    }

    filteredIds.add(node.id);

    if (node.parentId != null) {
      TreeNode? parentNode = getNodeById(_allNodes.values, node.parentId!);
      if (parentNode != null) {
        _addNodeWithParents(filteredIds, parentNode);
      }
    }
  }

  Map<String, TreeNode> _copyAllNodes() {
    final copiedNodes = <String, TreeNode>{};
    _allNodes.forEach((key, node) {
      copiedNodes[key] = node.copyWith();
    });
    return copiedNodes;
  }

  void _removeNodesNotInKeys(Map<String, TreeNode> nodes, List<String> keys) {
    nodes.removeWhere((key, node) => !_isNodeInKeys(node, keys));
  }

  bool _isNodeInKeys(TreeNode node, List<String> keys) {
    if (!keys.contains(node.id)) {
      return false;
    }

    node.children.removeWhere((child) => !_isNodeInKeys(child, keys));
    return true;
  }
}
