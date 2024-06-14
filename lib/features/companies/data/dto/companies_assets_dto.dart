import 'package:json_annotation/json_annotation.dart';

part 'companies_assets_dto.g.dart';

@JsonSerializable()
class CompaniesAssetsDto {
  factory CompaniesAssetsDto.fromJson(Map<String, dynamic> json) =>
      _$CompaniesAssetsDtoFromJson(json);

  CompaniesAssetsDto(
    this.id,
    this.locationId,
    this.name,
    this.parentId,
    this.sensorType,
    this.status,
  );

  final String? id;
  final String? locationId;
  final String? name;
  final String? parentId;
  final String? sensorType;
  final String? status;
}
