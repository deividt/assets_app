import 'package:dartz/dartz.dart';

import '../data/dto/companies_assets_dto.dart';
import '../data/dto/companies_dto.dart';
import '../data/dto/companies_locations_dto.dart';
import '../data/entities/companies.dart';
import '../data/entities/companies_assets.dart';
import '../data/entities/companies_locations.dart';
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

  @override
  Future<Either<Exception, List<CompaniesLocations>>> getCompaniesLocations(
      String companyId) async {
    try {
      List<CompaniesLocationsDto>? companiesLocationsDto =
          await _restClient.getCompaniesLocations(companyId);
      return Right(companiesLocationsDto.map((e) => e.dtoToEntity()).toList());
    } catch (error) {
      // Create a class do manage all exceptions properly
      if (error is Exception) {
        return Left(error);
      }

      return Left(Exception(error));
    }
  }

  @override
  Future<Either<Exception, List<CompaniesAssets>>> getCompaniesAssets(
      String companyId) async {
    try {
      List<CompaniesAssetsDto>? companiesAssetsDto =
          await _restClient.getCompaniesAssets(companyId);
      return Right(companiesAssetsDto.map((e) => e.dtoToEntity()).toList());
    } catch (error) {
      // Create a class do manage all exceptions properly
      if (error is Exception) {
        return Left(error);
      }

      return Left(Exception(error));
    }
  }
}
