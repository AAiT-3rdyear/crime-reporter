import 'dart:html';

import 'package:crime_reporter/application/user/bloc/userbloc_bloc.dart';
import 'package:crime_reporter/infrastructure/repository/user_repositories.dart';
import 'package:flutter/cupertino.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart';

class MockAuthenticationRepository extends Mock implements UserRepository {}

void main() {
  late UserRepository authenticationRepository;

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
  });

  test('initial state is userbloc', () {
    final userblocBloc = UserblocBloc();
    expect(userblocBloc.state, UserblocInitial());
  });

  group('Bloc test', () {
    blocTest<UserblocBloc, UserblocState>(
      'emits sample found for crime',
      setUp: () {
        when(
          () => authenticationRepository.getSampleCrime(),
        ).thenAnswer((_) async {});
      },
      build: () => UserblocBloc(),
      act: (bloc) {
        bloc..add(GetSample());
      },
      expect: () => SampleFound(),
    );

    blocTest<UserblocBloc, UserblocState>(
      'select station',
      setUp: () {
        when(
          () => authenticationRepository.getStations(),
        ).thenAnswer((_) async {});
      },
      build: () => UserblocBloc(),
      act: (bloc) {
        bloc..add(GetStations());
      },
      expect: () => StationFound(),
    );

    blocTest<UserblocBloc, UserblocState>(
      'select station',
      setUp: () {
        when(
          () => authenticationRepository.postImage(Path()),
        ).thenAnswer((_) async {});
      },
      build: () => UserblocBloc(),
      act: (bloc) {
        bloc..add(PostImage(Path()));
      },
      expect: () => ImagePosted(),
    );

  
  });
}
