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

  void filterByEnergySensor() {
    _applyFilter((node) =>
        node.assetType == AssetType.component &&
        node.sensorType == SensorType.energy);
  }

  void filterByCriticStatus() {
    _applyFilter((node) => node.sensorStatus == SensorStatus.alert);
  }

  void _applyFilter(bool Function(TreeNode) filter) {
    final filteredNodes = <String, TreeNode>{};

    _allNodes.forEach((key, node) {
      if (_nodeMatchesFilter(node, filter)) {
        _addNodeWithParents(filteredNodes, node);
      }
    });

    emit(AssetsState.success(filteredNodes));
  }

  bool _nodeMatchesFilter(TreeNode node, bool Function(TreeNode) filter) {
    if (filter(node)) {
      return true;
    }
    for (final child in node.children) {
      if (_nodeMatchesFilter(child, filter)) {
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
