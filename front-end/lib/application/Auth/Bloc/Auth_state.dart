part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}
class LogingIn extends AuthState {}
class LoginSuccessful extends AuthState {
  final response;   final sampleCrimes;
  LoginSuccessful(this.response,this.sampleCrimes,);
}
class LoginFailed extends AuthState {}
class SignUpInitial extends AuthState {}
class SigningIn extends AuthState {}
class SignUpSuccessful extends AuthState {}
class SignUpFailed extends AuthState {}
class LoggingOut extends AuthState {}
class LogedOut extends AuthState {}

