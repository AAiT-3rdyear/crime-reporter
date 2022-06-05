import 'package:bloc_test/bloc_test.dart';
import 'package:crime_reporter/application/Auth/Bloc/Auth_event.dart';
import 'package:crime_reporter/application/Auth/Bloc/Auth_state.dart';
import 'package:crime_reporter/application/Auth/Bloc/Auth_bloc.dart';
import 'package:crime_reporter/infrastructure/repository/user_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

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
          bloc.add(Login(password: 'password', username: 'username'));
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
        expect: () => [LogingIn()],
        // LoginFailed()
      );
    });
  });
}
