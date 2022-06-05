import 'dart:html';

import 'package:crime_reporter/models/models.dart';
import 'package:flutter/cupertino.dart';
import '../../../lib/bloc/userBloc/userbloc_bloc.dart';
import '../../../lib/repositories/user_repositories.dart';
import 'package:bloc_test/bloc_test.dart';
import '../../../lib/bloc/authBloc/auth_bloc.dart';
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

    // blocTest<UserblocBloc, UserblocState>(
    //   'select station',
    //   setUp: () {
    //     when(
    //       () => authenticationRepository.reportCrime(

    //       ),
    //     ).thenAnswer((_) async{});
    //   },
    //   build: () => UserblocBloc(

    //   ),
    //   act: (bloc) {
    //     bloc
    //       ..add(PostImage(Path()));
    //   },
    //   expect: () =>  ImagePosted(),
    // );

    // blocTest<UserblocBloc, UserblocState>(
    //   'select station',
    //   setUp: () {
    //     when(
    //       () => authenticationRepository.getMyReport(
    //         ()
    //       ),
    //     ).thenAnswer((_) async{});
    //   },
    //   build: () => UserblocBloc(

    //   ),
    //   act: (bloc) {
    //     bloc
    //       ..add(PostImage(Path()));
    //   },
    //   expect: () =>  ImagePosted(),
    // );
  });
}
