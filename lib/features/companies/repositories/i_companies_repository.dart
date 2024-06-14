import 'package:dartz/dartz.dart';

import '../data/entities/companies.dart';
import '../data/entities/companies_assets.dart';
import '../data/entities/companies_locations.dart';

abstract class ICompaniesRepository {
  Future<Either<Exception, List<Companies>>> getCompanies();

  Future<Either<Exception, List<CompaniesLocations>>> getCompaniesLocations(
    String companyId,
  );

  Future<Either<Exception, List<CompaniesAssets>>> getCompaniesAssets(
    String companyId,
  );
}
