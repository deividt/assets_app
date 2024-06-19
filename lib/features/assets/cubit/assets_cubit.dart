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
  AssetsCubit(
    this._repository,
  ) : super(const AssetsState.loading());

  final ICompaniesRepository _repository;
  late Map<String, TreeNode> _allNodes;
  bool _isEnergySensorFilterActive = false;
  bool _isCriticStatusFilterActive = false;

  Future<void> loadCompanies(String companyId) async {
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

  void _applyFilters() {
    if (!_isEnergySensorFilterActive && !_isCriticStatusFilterActive) {
      emit(AssetsState.success(_allNodes));
      return;
    }

    final filteredNodes = <String, TreeNode>{};

    _allNodes.forEach((key, node) {
      if (_nodeMatchesAnyFilter(node)) {
        _addNodeWithParents(filteredNodes, node);
      }
    });

    emit(AssetsState.success(filteredNodes));
  }

  bool _nodeMatchesAnyFilter(TreeNode node) {
    bool matches = true;
    if (_isEnergySensorFilterActive) {
      matches &= (node.assetType == AssetType.component &&
          node.sensorType == SensorType.energy);
    }
    if (_isCriticStatusFilterActive) {
      matches &= (node.sensorStatus == SensorStatus.alert);
    }
    if (matches) {
      return true;
    }
    for (final child in node.children) {
      if (_nodeMatchesAnyFilter(child)) {
        return true;
      }
    }
    return false;
  }

  void _addNodeWithParents(Map<String, TreeNode> map, TreeNode node) {
    if (!map.containsKey(node.id)) {
      map[node.id] = node;
      _allNodes.forEach((key, parentNode) {
        if (parentNode.children.contains(node)) {
          _addNodeWithParents(map, parentNode);
        }
      });
    }
  }
}
