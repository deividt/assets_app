import 'package:dartz/dartz.dart';

import '../data/entities/companies.dart';

abstract class ICompaniesRepository {
  Future<Either<Exception, List<Companies>>> getCompanies();
}
