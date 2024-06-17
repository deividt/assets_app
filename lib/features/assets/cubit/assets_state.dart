import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/entities/tree_node.dart';

part 'assets_state.freezed.dart';

@freezed
class AssetsState with _$AssetsState {
  const factory AssetsState.loading() = LoadingState;

  const factory AssetsState.error() = ErrorState;

  const factory AssetsState.success(Map<String, TreeNode> nodes) = SuccessState;
}
