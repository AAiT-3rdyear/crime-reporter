import 'package:flutter/material.dart';

import '../components/myReportsCard.dart';

class MyReports extends StatelessWidget {
  MyReports({
    Key? key,
    this.myreports,
    this.user,
  }) : super(key: key);
  dynamic myreports;
  dynamic user;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: myreports.length,
                itemBuilder: (BuildContext context, int index) {
                  return CrimeCard2(myreports: myreports, index: index);
                }),
          ),
        ]),
      ),
    );
  }
}
