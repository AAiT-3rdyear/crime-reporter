import 'package:crime_reporter/application/police/bloc/policebloc_bloc.dart';
import 'package:crime_reporter/infrastructure/repository/police_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';

class MockAuthenticationRepository extends Mock implements PoliceRepository {}

void main() {
  late PoliceRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
  });

  test('initial state is userbloc', () {
    final userblocBloc = PoliceblocBloc();
    expect(userblocBloc.state, PoliceblocBloc());
  });

  group('Bloc test', () {
    blocTest<PoliceblocBloc, PoliceblocState>(
      'emits sample found for crime',
      setUp: () {
        when(
          () => authenticationRepository.getReportedCrimes(Path()),
        ).thenAnswer((_) async {});
      },
      build: () => PoliceblocBloc(),
      act: (bloc) {
        bloc..add(GetOngoing(Path()));
      },
      expect: () => GetReportedSucessful(),
    );

    blocTest<PoliceblocBloc, PoliceblocState>(
      'select station',
      setUp: () {
        when(
          () => authenticationRepository.getSolvedCrimes('user'),
        ).thenAnswer((_) async {
        });
      },
      build: () => PoliceblocBloc(),
      act: (bloc) {
        
        PoliceRepository myrepo = PoliceRepository();
        dynamic solved = myrepo.getSolvedCrimes('user');
        bloc.add(GetSolved(solved));
       
      },
      expect: () => GetSolvedSucessful(),
    );

    blocTest<PoliceblocBloc, PoliceblocState>(
      'select station',
      setUp: () {
        when(
          () => authenticationRepository.getOngoingCrimes(Path()),
        ).thenAnswer((_) async {});
      },
      build: () => PoliceblocBloc(),
      act: (bloc) {
        bloc..add(GetOngoing(Path()));
      },
      expect: () => GetOngoingSucessful(),
    );
  });
}
