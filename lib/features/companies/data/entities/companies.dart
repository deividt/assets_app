import 'package:equatable/equatable.dart';

import '../dto/companies_dto.dart';

class Companies extends Equatable {
  const Companies({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

extension CompaniesExtensions on CompaniesDto {
  Companies dtoToEntity() => Companies(
        id: id,
        name: name,
      );
}
