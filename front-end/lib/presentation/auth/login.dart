import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../application/Auth/Bloc/Auth_event.dart';
import '../../application/Auth/Bloc/Auth_state.dart';
import '../../application/Auth/Bloc/Auth_bloc.dart';
import '../../application/Auth/auth.dart';
import '../components/cliper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: SafeArea(
          child: Stack(children: <Widget>[
            ClipPath(
              clipper: TopLeftClipper(),
              child: Container(
                color: const Color(0xFFFFC100),
              ),
            ),

            Container(
              margin: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.home,
                    color: Color(0xFFFFC600),
                    size: 40.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: const Text(
                          'NO',
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 243, 242),
                              fontSize: 19.0),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(15, 5, 0, 2),
                        child: const Text(
                          'Crime',
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 243, 242),
                              fontSize: 19.0),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 20, 10),
                      child: const Text(
                        'Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 10),
                      child: const Text(
                        'CRIME',
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 28.0,
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),

            // the 3 images down below
            const Positioned(
                top: 135.0,
                left: 25.0,
                child: Padding(
                  padding: EdgeInsets.all(45),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/thief.jpg'),
                    radius: 50,
                  ),
                )),
            const Positioned(
                top: 215.0,
                left: 35.0,
                child: Padding(
                  padding: EdgeInsets.all(45),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/holded.jpg'),
                    radius: 60,
                  ),
                )),
            const Positioned(
                top: 155.0,
                left: 105.0,
                child: Padding(
                  padding: EdgeInsets.all(45),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/hit.png'),
                    radius: 50,
                  ),
                )),

            // form field
            Positioned(
                bottom: 7.0,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        topLeft: Radius.circular(25.0)),
                    color: Color(0xFFF6F5F5),
                  ),
                  width: 500,
                  height: 350,
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        Padding(
                            padding: const EdgeInsets.fromLTRB(20, 25, 100, 0),
                            child: TextFormField(
                              controller: emailcontroler,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  hintText: 'Enter Email',
                                  suffixIcon: const Icon(
                                    Icons.email,
                                    size: 30,
                                    color: Colors.black,
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'email is required ';
                                }
                              },
                            )),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 25, 100, 0),
                          child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (_, AuthState state) {
                            bool erorr = false;
                            if (state is LoginFailed) {
                              erorr = true;
                            }
                            return TextFormField(
                              controller: passwordcontroler,
                              obscureText: true,
                              decoration: InputDecoration(
                                  errorText: erorr
                                      ? 'invalid usrname or password'
                                      : null,
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  hintText: 'Enter password',
                                  suffixIcon: const Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                    size: 27,
                                  )),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password is required';
                                }
                              },
                            );
                          }),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // Login button
                        BlocConsumer<AuthBloc, AuthState>(
                            listener: (_, AuthState state) {
                          if (state is LoginSuccessful) {
                            if (state.response.role == "Police") {
                              context.go(
                                '/policeScreen',
                              );
                            } else if (state.response.role == "User") {
                              context.go(
                                '/welcomeScreen',
                              );
                            }
                          }
                        }, builder: (_, AuthState state) {
                          Widget buttonChild = const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          );

                          if (state is LogingIn) {
                            buttonChild = const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is LoginSuccessful) {
                            buttonChild = const Text("Login Successful");
                          }

                          if (state is LoginFailed) {
                            buttonChild = const Text("Login failed");
                          }
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 100, 5),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: const Color(0xFFFFC600),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                minimumSize: const Size(280, 50),
                              ),
                              onPressed: state is LogingIn
                                  ? null
                                  : () {
                                      if (!_formKey.currentState!.validate()) {
                                        return;
                                      }
                                      final authBloc =
                                          BlocProvider.of<AuthBloc>(context);
                                      authBloc.add(
                                        Login(
                                            username: emailcontroler.text,
                                            password: passwordcontroler.text),
                                      );
                                    },
                              child: buttonChild,
                            ),
                          );
                        }),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 120, vertical: 10),
                          child: Row(
                            children: [
                              const Text(' Not registerd yet ? '),
                              InkWell(
                                onTap: () => context.go('/signUp'),
                                child: const Text(
                                  'Create Account ',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 59, 118, 118),
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        )
                      ])),
                ))
          ]),
        ));
  }
}
