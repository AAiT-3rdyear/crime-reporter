import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../application/user/bloc/userbloc_bloc.dart';


class CrimeCard extends StatelessWidget {
  CrimeCard({Key? key, this.image, this.name, this.user}) : super(key: key);
  dynamic image;
  dynamic name;
  dynamic user;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.green,
      margin: const EdgeInsets.all(20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Expanded(
          flex: 1,
          child: Image(
            image: AssetImage(image),
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
            flex: 1,
            child: Column(
              children: [
                Text(name),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  BlocConsumer<UserblocBloc, UserblocState>(
                      listener: (context, state) {
                        List<String> stations = [];
                        dynamic response2;

                        if (state is StationFound) {
                          response2 = state.stations[1];
                          stations = state.stations[0];
                          Map<String, dynamic> foundStations = {
                            'response2': response2,
                            'stations': stations,
                          };

                          context.go('/crimeDetail', extra: foundStations);
                        }
                      },
                      builder: (_, UserblocState state) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.yellow[800],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              minimumSize: const Size(120, 40),
                            ),
                            onPressed: () {
                              final userBloc =
                                  BlocProvider.of<UserblocBloc>(context);
                              userBloc.add(GetStations());
                            },
                            child: const Text('report'));
                      },
                    ),
                  ],
                )
              ],
            )),
      ]),
    );
  }
}
