import 'package:equatable/equatable.dart';

import '../dto/companies_assets_dto.dart';

class CompaniesAssets extends Equatable {
  const CompaniesAssets({
    required this.id,
    required this.locationId,
    required this.name,
    required this.parentId,
    required this.sensorType,
    required this.status,
  });

  final String? id;
  final String? locationId;
  final String? name;
  final String? parentId;
  final String? sensorType;
  final String? status;

  @override
  List<Object?> get props => [
        id,
        locationId,
        name,
        parentId,
        sensorType,
        status,
      ];
}

extension CompaniesAssetsExtensions on CompaniesAssetsDto {
  CompaniesAssets dtoToEntity() => CompaniesAssets(
        id: id,
        locationId: locationId,
        name: name,
        parentId: parentId,
        sensorType: sensorType,
        status: status,
      );
}
