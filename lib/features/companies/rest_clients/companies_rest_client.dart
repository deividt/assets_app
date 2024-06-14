import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../data/dto/companies_assets_dto.dart';
import '../data/dto/companies_dto.dart';
import '../data/dto/companies_locations_dto.dart';

part 'companies_rest_client.g.dart';

@RestApi()
abstract class CompaniesRestClient {
  factory CompaniesRestClient(Dio dio) = _CompaniesRestClient;

  @GET('/companies')
  Future<List<CompaniesDto>> getCompanies();

  @GET('/companies/{companyId}/locations')
  Future<List<CompaniesLocationsDto>> getCompaniesLocations(
    @Path('companyId') String companyId,
  );

  @GET('/companies/{companyId}/assets')
  Future<List<CompaniesAssetsDto>> getCompaniesAssets(
    @Path('companyId') String companyId,
  );
}
