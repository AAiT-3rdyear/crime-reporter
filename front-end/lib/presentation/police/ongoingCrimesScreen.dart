import 'package:flutter/material.dart';

import '../components/reportedCard.dart';

class OngoingCrime extends StatefulWidget {
  OngoingCrime({Key? key, this.ongoing}) : super(key: key);
  dynamic ongoing;
  @override
  State<OngoingCrime> createState() => _OngoingCrimeState();
}

class _OngoingCrimeState extends State<OngoingCrime> {
  @override
  Widget build(BuildContext context) {
    return widget.ongoing.length == 0
        ? Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "no ongoing crimes ",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ))
        : Expanded(
            flex: 4,
            child: ListView.builder(
                itemCount: (widget.ongoing).length,
                itemBuilder: (BuildContext context, int index) {
                  return ReportedCard(
                    crimeId: widget.ongoing[index]['_id'],
                    title: widget.ongoing[index]['status'],
                    discription: widget.ongoing[index]["description"],
                    location: widget.ongoing[index]["location"],
                    time: widget.ongoing[index]["time"],
                    path: widget.ongoing[index]["imageURL"],
                    reportto: widget.ongoing[index]['report_to'],
                  );
                }),
          );
  }
}
