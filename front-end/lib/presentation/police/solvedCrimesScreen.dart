import 'package:flutter/material.dart';
import '../components/reportedCard.dart';

class SolvedCrime extends StatefulWidget {
  SolvedCrime({Key? key, this.solved}) : super(key: key);
  dynamic solved;
  @override
  State<SolvedCrime> createState() => _SolvedCrimeState();
}

class _SolvedCrimeState extends State<SolvedCrime> {
  @override
  Widget build(BuildContext context) {
    return widget.solved.length == 0
        ? Container(
            padding: const EdgeInsets.all(20),
            child: const Text(
              "no solved crimes list",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ))
        : Expanded(
            flex: 4,
            child: ListView.builder(
                itemCount: (widget.solved).length,
                itemBuilder: (BuildContext context, int index) {
                  return ReportedCard(
                    crimeId: widget.solved[index]['_id'],
                    title: widget.solved[index]['status'],
                    discription: widget.solved[index]["description"],
                    location: widget.solved[index]["location"],
                    time: widget.solved[index]["time"],
                    path: widget.solved[index]["imageURL"],
                    reportto: widget.solved[index]['report_to'],
                  );
                }),
          );
  }
}
