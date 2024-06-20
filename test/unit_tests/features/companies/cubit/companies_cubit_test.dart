import 'package:assets_app/features/companies/cubit/companies_cubit.dart';
import 'package:assets_app/features/companies/cubit/companies_state.dart';
import 'package:assets_app/features/companies/data/entities/companies.dart';
import 'package:assets_app/features/companies/repositories/companies_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'companies_cubit_test.mocks.dart';

@GenerateMocks([CompaniesRepository])
void main() {
  late CompaniesCubit companiesCubit;
  late MockCompaniesRepository mockCompaniesRepository;

  setUp(() {
    mockCompaniesRepository = MockCompaniesRepository();
    companiesCubit = CompaniesCubit(mockCompaniesRepository);
  });

  tearDown(() {
    companiesCubit.close();
  });

  group('CompaniesCubit', () {
    final List<Companies> companiesList = [
      const Companies(id: '1', name: 'Test Company')
    ];

    test('initial state is CompaniesState.loading()', () {
      expect(companiesCubit.state, equals(const CompaniesState.loading()));
    });

    blocTest<CompaniesCubit, CompaniesState>(
      'emits [CompaniesState.loading(), CompaniesState.success(companiesList)] when loadCompanies is successful',
      build: () {
        when(mockCompaniesRepository.getCompanies())
            .thenAnswer((_) async => Right(companiesList));
        return companiesCubit;
      },
      act: (cubit) => cubit.loadCompanies(),
      expect: () => [
        const CompaniesState.loading(),
        CompaniesState.success(companiesList),
      ],
      verify: (_) {
        verify(mockCompaniesRepository.getCompanies()).called(1);
      },
    );

    blocTest<CompaniesCubit, CompaniesState>(
      'emits [CompaniesState.loading(), CompaniesState.error()] when loadCompanies fails',
      build: () {
        when(mockCompaniesRepository.getCompanies())
            .thenAnswer((_) async => Left(Exception('Error')));
        return companiesCubit;
      },
      act: (cubit) => cubit.loadCompanies(),
      expect: () => [
        const CompaniesState.loading(),
        const CompaniesState.error(),
      ],
      verify: (_) {
        verify(mockCompaniesRepository.getCompanies()).called(1);
      },
    );
  });
}
