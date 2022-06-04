import 'package:bloc/bloc.dart';
import 'package:crime_reporter/infrastructure/repository/police_repositories.dart';
import 'package:crime_reporter/infrastructure/repository/user_repositories.dart';
import 'package:equatable/equatable.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final userRepository = UserRepository();
  final policeRepository = PoliceRepository();

  AuthBloc() : super(AuthInitial()) {
    on<Login>(_onLogin);
    on<SignUp>(_onSignUp);
    on<LogOut>(_onLogOut);
  }
  

  void _onLogin(Login event, Emitter emit) async {
    emit(LogingIn());
    final response =
        await userRepository.getUser(event.username, event.password);
    final sampleCrimes = await userRepository.getSampleCrime();
    if (response == 401) {
      emit(LoginFailed());
    } else {
      emit(LoginSuccessful(response, sampleCrimes));
    }
  }


  void _onSignUp(SignUp event, Emitter emit) async {
    emit(SigningIn());
    final response =
        await userRepository.getUser(event.username, event.password);
    if (response == 400 || response == 401) {
      await userRepository.signUpUser(event.body);
      emit(SignUpSuccessful());
    } else {
      emit(SignUpFailed());
    }
  }

  void _onLogOut(LogOut event, Emitter emit) async {
    emit(LoggingOut());
    await userRepository.deleteToken();
    emit(LogedOut());
  }
}
