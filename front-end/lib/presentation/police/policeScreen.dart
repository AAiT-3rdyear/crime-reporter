import 'package:crime_reporter/bloc/authBloc/auth_bloc.dart';
import 'package:crime_reporter/components/componenets.dart';
import 'package:crime_reporter/domain/models.dart';
import 'package:crime_reporter/presentation/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../bloc/policeBloc/policebloc_bloc.dart';
import 'dart:convert';

class PoliceScreen extends StatefulWidget {
  PoliceScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<PoliceScreen> createState() => _ReportCrimeState();
}

class _ReportCrimeState extends State<PoliceScreen> {
  late IO.Socket socket;
  List<Report> reported = [];
  dynamic message;
  dynamic user;

  @override
  void initState() {
    super.initState();
    connect();
  }

  dynamic connect() async {
    try {
      socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.connect();
      socket.emit("login", user.userId);
      socket.onConnect((data) {
        socket.on("report", (msg) async {
          message = msg;
          final policeBloc = BlocProvider.of<PoliceblocBloc>(context);
          policeBloc.add(
            GetReported(msg),
          );
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
          children: [
            SafeArea(
              child: Container(
                child: Stack(clipBehavior: Clip.none, children: [
                  const Card(
                    child: ListTile(
                      leading: Image(
                          width: 120,
                          image: AssetImage('assets/images/logo.jpg')),
                      title: Text(
                        'Reported',
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
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Reported Crimes',
              style: TextStyle(
                  fontFamily: 'times',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<PoliceblocBloc, PoliceblocState>(
                builder: (_, PoliceblocState policeState) {
              bool selected1 = true;
              bool selected2 = false;
              bool selected3 = false;
              if (policeState is GetSolvedSucessful) {
                selected1 = false;
                selected2 = false;
                selected3 = true;
              }
              if (policeState is GetOngoingSucessful) {
                selected1 = false;
                selected2 = true;
                selected3 = false;
              }
              if (policeState is GetReportedSucessful) {
                selected1 = true;
                selected2 = false;
                selected3 = false;
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 4.0,
                              color: selected1 ? Colors.orange : Colors.black),
                        ),
                      ),
                      width: 100,
                      height: 40,
                      child: const Text(
                        'Reported',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                    onTap: () {
                      final policeBloc =
                          BlocProvider.of<PoliceblocBloc>(context);
                      policeBloc.add(
                        GetReported(message),
                      );
                    },
                  ),
                  InkWell(
                    hoverColor: Colors.orange,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 4.0,
                              color: selected2 ? Colors.orange : Colors.black),
                        ),
                      ),
                      width: 100,
                      height: 40,
                      child: const Text(
                        'OnGoing',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                    onTap: () async {
                      final policeBloc =
                          BlocProvider.of<PoliceblocBloc>(context);
                      policeBloc.add(
                        GetOngoing(user.fullname),
                      );
                    },
                  ),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 4.0,
                              color: selected3 ? Colors.orange : Colors.black),
                        ),
                      ),
                      width: 100,
                      height: 40,
                      child: const Text(
                        'Solved',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      alignment: Alignment.center,
                    ),
                    onTap: () async {
                      final policeBloc =
                          BlocProvider.of<PoliceblocBloc>(context);
                      policeBloc.add(
                        GetSolved(user.fullname),
                      );
                    },
                  ),
                ],
              );
            }),
            BlocBuilder<PoliceblocBloc, PoliceblocState>(
                builder: (_, PoliceblocState policeState) {
              if (policeState is PoliceblocInitial) {
                return BlocBuilder<AuthBloc, AuthState>(
                    builder: (_, AuthState state) {
                  if (state is LoginSuccessful) {
                    user = state.response;
                    return Container(
                        padding: const EdgeInsets.all(70),
                        child: Column(children: const [
                          Text(
                            'no new reported data ',
                            style: TextStyle(
                                fontFamily: "italic",
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ),
                          Text('tap ongoing for previously recived',
                              style: TextStyle(
                                  fontFamily: "italic",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17))
                        ]));
                  }
                  return const Text('');
                });
              } else if (policeState is GetReportedSucessful) {
                reported.insert(0, policeState.crimeList);
                return Expanded(
                  child: ListView.builder(
                      itemCount: (reported).length,
                      itemBuilder: (BuildContext context, int index) {
                        return ReportedCard(
                          title: (reported)[index].title,
                          discription: reported[index].description,
                          location: reported[index].location,
                          time: reported[index].time,
                          path: reported[index].imageURL,
                        );
                      }),
                );
              } else if (policeState is GetOngoingSucessful) {
                return OngoingCrime(
                    ongoing: json.decode(policeState.crimeList.body));
              } else if (policeState is GetSolvedSucessful) {
                return SolvedCrime(
                    solved: json.decode(policeState.crimeList.body));
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
            return BottomNavBar(image: user.imgUrl, user: user);
          }
          return const Text('');
        }));
  }
}
