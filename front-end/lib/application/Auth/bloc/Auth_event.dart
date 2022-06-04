part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];

}

class Login extends AuthEvent {
      String password;
      String username;
  Login({ required this.username,required this.password});
}

class SignUp extends AuthEvent{ 
  Map<String,dynamic>body;
  dynamic password;
  dynamic username;
  SignUp({this.username, this.password,required this.body,});

}
class LogOut extends AuthEvent {}

