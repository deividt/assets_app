import 'package:freezed_annotation/freezed_annotation.dart';

import '../data/entities/companies.dart';

part 'companies_state.freezed.dart';

@freezed
class CompaniesState with _$CompaniesState {
  const factory CompaniesState.loading() = LoadingState;

  const factory CompaniesState.error() = ErrorState;

  const factory CompaniesState.success(List<Companies> companies) =
      SuccessState;
}
