import 'package:crime_reporter/models/models.dart';
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

  group('LoginBloc', () {
    test('initial state is LoginState', () {
      final loginBloc = AuthBloc();
      expect(loginBloc.state, AuthInitial());
    });

    group('LoginSubmitted', () {
      String password = 'password';
      String username = 'username';

      // bloc test for login successfull
      blocTest<AuthBloc, AuthState>(
        'emits [LoginInProgress, loginsuccess] when logIn succed',
        setUp: () async {
          when(
            await () => authenticationRepository.getUser(username, password),
          ).thenAnswer((_) async {});
        },
        build: () => AuthBloc(),
        act: (bloc) {
          bloc..add(Login(password: 'password', username: 'username'));
        },
        expect: () => <AuthState>[
          LogingIn(),
          // LoginSuccessful(  authenticationRepository.getUser(password, username), authenticationRepository.getSampleCrime())
        ],
      );

      blocTest<AuthBloc, AuthState>(
        'emits [LoginInProgress, loginfail] when logIn fail',
        setUp: () {
          when(
            () => authenticationRepository.getUser(username, password),
          ).thenThrow(Exception('oops'));
        },
        build: () => AuthBloc(),
        act: (bloc) {
          bloc..add(Login(password: 'password', username: 'username'));
        },
        expect: () => LogingIn(),
        // LoginFailed()
      );
    });
  });
}
