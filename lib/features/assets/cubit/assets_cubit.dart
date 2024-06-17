import 'package:flutter_bloc/flutter_bloc.dart';

import '../../companies/data/entities/companies_assets.dart';
import '../../companies/data/entities/companies_locations.dart';
import '../../companies/repositories/i_companies_repository.dart';
import '../data/entities/tree_node.dart';
import 'assets_state.dart';

class AssetsCubit extends Cubit<AssetsState> {
  AssetsCubit(
    this._repository,
  ) : super(const AssetsState.loading());

  final ICompaniesRepository _repository;

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

    Map<String, TreeNode> nodes = buildTree(locations, assets);
    emit(AssetsState.success(nodes));
  }
}
