import 'package:dartz/dartz.dart';

import '../data/dto/companies_dto.dart';
import '../data/entities/companies.dart';
import '../rest_clients/companies_rest_client.dart';
import 'i_companies_repository.dart';

class CompaniesRepository implements ICompaniesRepository {
  CompaniesRepository(this._restClient);

  final CompaniesRestClient _restClient;

  @override
  Future<Either<Exception, List<Companies>>> getCompanies() async {
    try {
      List<CompaniesDto>? companiesDto = await _restClient.getCompanies();
      return Right(companiesDto.map((e) => e.dtoToEntity()).toList());
    } catch (error) {
      // Create a class do manage all exceptions properly
      if (error is Exception) {
        return Left(error);
      }

      return Left(Exception(error));
    }
  }
}
