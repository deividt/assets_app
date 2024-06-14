import 'package:equatable/equatable.dart';

import '../dto/companies_locations_dto.dart';

class CompaniesLocations extends Equatable {
  const CompaniesLocations({
    required this.id,
    required this.name,
    required this.parentId,
  });

  final String? id;
  final String? name;
  final String? parentId;

  @override
  List<Object?> get props => [
        id,
        name,
        parentId,
      ];
}

extension CompaniesLocationsExtensions on CompaniesLocationsDto {
  CompaniesLocations dtoToEntity() => CompaniesLocations(
        id: id,
        name: name,
        parentId: parentId,
      );
}
