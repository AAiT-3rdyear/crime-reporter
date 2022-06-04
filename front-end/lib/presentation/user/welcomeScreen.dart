import 'dart:convert';
import 'package:crime_reporter/presentation/user/myReportsScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/Auth/auth.dart';
import '../../application/user/bloc/userbloc_bloc.dart';
import '../components/bottumNavBar.dart';
import '../components/crimeCard.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<WelcomeScreen> createState() => _ReportCrimeState();
}

class _ReportCrimeState extends State<WelcomeScreen> {
  dynamic sampleCrimes;
  dynamic myreports;
  dynamic user;

  @override
  void initState() {
    super.initState();
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
          children: [
            SafeArea(
              child: Stack(clipBehavior: Clip.none, children: [
                const Card(
                  child: ListTile(
                    leading: Image(
                        width: 60, image: AssetImage('assets/images/logo.jpg')),
                    title: Text(
                      'Welcome to crime reporter',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                    top: 5,
                    right: 15,
                    child: Container(
                        color: Colors.white,
                        width: 60,
                        height: 60,
                        child: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/speaker.jpg'))))
              ]),
            ),
            const SizedBox(height: 15),
            BlocBuilder<UserblocBloc, UserblocState>(
                builder: (_, UserblocState userState) {
              bool selected1 = true;
              bool selected2 = false;
              if (userState is SampleFound) {
                selected1 = true;
                selected2 = false;
              }
              if (userState is ReportFound) {
                selected1 = false;
                selected2 = true;
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 4.0,
                              color: selected1 ? Colors.orange : Colors.black),
                        ),
                      ),
                      width: 150,
                      height: 40,
                      child: const Text(
                        'Report A Crime',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      alignment: Alignment.center,
                    ),
                    onTap: () {
                      final userBloc = BlocProvider.of<UserblocBloc>(context);
                      userBloc.add(
                        GetSample(),
                      );
                    },
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 4.0,
                              color: selected2 ? Colors.orange : Colors.black),
                        ),
                      ),
                      width: 150,
                      height: 40,
                      child: const Text(
                        'My Reports',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      alignment: Alignment.center,
                    ),
                    onTap: () async {
                      final userBloc = BlocProvider.of<UserblocBloc>(context);
                      userBloc.add(
                        GetMyReport(user.userId),
                      );
                      if (userState is ReportFound) {
                        myreports = userState.myreports;
                      }
                    },
                  ),
                ],
              );
            }),
            BlocBuilder<UserblocBloc, UserblocState>(
                builder: (_, UserblocState userState) {
              if (userState is SampleFound || userState is UserblocInitial) {
                return BlocBuilder<AuthBloc, AuthState>(
                    builder: (_, AuthState state) {
                  if (state is LoginSuccessful) {
                    user = state.response;
                    sampleCrimes = state.sampleCrimes;
                    return Expanded(
                      child: ListView.builder(
                          itemCount: sampleCrimes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CrimeCard(
                                image: sampleCrimes[index].image,
                                name: sampleCrimes[index].name,
                                user: user);
                          }),
                    );
                  }
                  return const Text('');
                });
              } else if (userState is ReportFound) {
                return MyReports(
                    user: user,
                    myreports: json.decode((userState.myreports.body)));
              } else {
                return const Text('');
              }
            })
          ],
        )),
        bottomNavigationBar:
            BlocBuilder<AuthBloc, AuthState>(builder: (_, AuthState state) {
          if (state is LoginSuccessful) {
            user = state.response;
            sampleCrimes = state.sampleCrimes;
            return BottomNavBar(image: user.imgUrl, user: user);
          }
          return const Text('');
        }));
  }
}
