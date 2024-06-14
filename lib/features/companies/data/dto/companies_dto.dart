import 'package:json_annotation/json_annotation.dart';

part 'companies_dto.g.dart';

@JsonSerializable()
class CompaniesDto {
  factory CompaniesDto.fromJson(Map<String, dynamic> json) =>
      _$CompaniesDtoFromJson(json);

  CompaniesDto(
    this.id,
    this.name,
  );

  final String? id;
  final String? name;
}
