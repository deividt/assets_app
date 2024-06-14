import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/i_companies_repository.dart';
import 'companies_state.dart';

class CompaniesCubit extends Cubit<CompaniesState> {
  CompaniesCubit(
    this._repository,
  ) : super(const CompaniesState.loading());

  final ICompaniesRepository _repository;

  Future<void> loadCompanies() async {
    emit(const CompaniesState.loading());

    final result = await _repository.getCompanies();

    result.fold((failure) => emit(const CompaniesState.error()), (success) {
      emit(CompaniesState.success(success));
    });
  }
}
