import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../data/dto/companies_dto.dart';

part 'companies_rest_client.g.dart';

@RestApi()
abstract class CompaniesRestClient {
  factory CompaniesRestClient(Dio dio) = _CompaniesRestClient;

  @GET('/companies')
  Future<List<CompaniesDto>> getCompanies();
}
