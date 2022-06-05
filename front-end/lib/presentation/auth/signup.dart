import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';

import '../../application/Auth/Bloc/auth_bloc.dart';
import '../../application/Auth/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController namecontroler = TextEditingController();
  TextEditingController confirmcontroler = TextEditingController();
  TextEditingController phonecontroler = TextEditingController();
  TextEditingController emailcontroler = TextEditingController();
  TextEditingController passwordcontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 33, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Welcome",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ]),
                )),
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextFormField(
                            controller: namecontroler,
                            decoration: InputDecoration(
                                fillColor: Colors.grey[300],
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: 'Enter fullname',
                                suffixIcon: const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Colors.black,
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'fullname is required ';
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextFormField(
                              controller: emailcontroler,
                              decoration: InputDecoration(
                                  // errorText: userExist?'email already exists':null,
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  hintText: 'Enter Email',
                                  suffixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black,
                                    size: 27,
                                  )),
                              keyboardType: TextInputType.emailAddress,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: "Email is Required"),
                                EmailValidator(
                                    errorText: "Enter valid email id"),
                              ]))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Phone Number',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextFormField(
                            controller: phonecontroler,
                            decoration: InputDecoration(
                                fillColor: Colors.grey[300],
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: 'Enter Phone number',
                                suffixIcon: const Icon(
                                  Icons.phone,
                                  size: 27,
                                  color: Colors.black,
                                )),
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'phone number is required';
                              } else if (value.length != 10) {
                                return 'Mobile Number must be 10 digit';
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextFormField(
                            controller: passwordcontroler,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey[300],
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: 'Enter password',
                                suffixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                  size: 27,
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'password is required';
                              } else if (value.length < 6) {
                                return 'password should be atleast 6 characters';
                              } else if (value.length > 15) {
                                return 'password should not be greater than 15 characters';
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'confirm password',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextFormField(
                            controller: confirmcontroler,
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey[300],
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                hintText: 'confirm password',
                                suffixIcon: const Icon(
                                  Icons.lock,
                                  size: 27,
                                  color: Colors.black,
                                )),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'please confirm password';
                              } else if (confirmcontroler.text !=
                                  passwordcontroler.text) {
                                return 'password does not match';
                              }
                            },
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                        listener: (_, AuthState state) {
                      if (state is SignUpSuccessful) {
                        context.go(
                          '/login',
                        );
                      }
                    }, builder: (_, AuthState state) {
                      Widget buttonChild = const Text(
                        'SignUP',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      );

                      if (state is SigningIn) {
                        buttonChild = const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is SignUpSuccessful) {
                        buttonChild = const Text("SignUp Successful");
                      }

                      if (state is SignUpFailed) {
                        buttonChild = const Text("Signup failed");
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFFFFC600),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            minimumSize: const Size(280, 50),
                          ),
                          onPressed: state is SigningIn
                              ? null
                              : () {
                                  if (!_formKey.currentState!.validate())
                                    return;
                                  final authBloc =
                                      BlocProvider.of<AuthBloc>(context);
                                  authBloc.add(
                                    SignUp(
                                        username: emailcontroler.text,
                                        password: passwordcontroler.text,
                                        body: {
                                          'fullname': namecontroler.text,
                                          'email': emailcontroler.text,
                                          'phone_no': phonecontroler.text,
                                          'password': passwordcontroler.text
                                        }),
                                  );
                                },
                          child: buttonChild,
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 5),
                      child: Row(
                        children: [
                          const Text('already have an account ?:'),
                          InkWell(
                            onTap: () => context.go('/login'),
                            child: const Text(
                              'Login ',
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
