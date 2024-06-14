import 'package:json_annotation/json_annotation.dart';

part 'companies_locations_dto.g.dart';

@JsonSerializable()
class CompaniesLocationsDto {
  factory CompaniesLocationsDto.fromJson(Map<String, dynamic> json) =>
      _$CompaniesLocationsDtoFromJson(json);

  CompaniesLocationsDto(
    this.id,
    this.name,
    this.parentId,
  );

  final String? id;
  final String? name;
  final String? parentId;
}
