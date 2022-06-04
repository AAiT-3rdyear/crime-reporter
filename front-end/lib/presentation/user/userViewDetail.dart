import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserViewDetail extends StatefulWidget {
  UserViewDetail({Key? key, this.detail}) : super(key: key);
  dynamic detail;

  @override
  State<UserViewDetail> createState() => _ReportDetailState();
}

class _ReportDetailState extends State<UserViewDetail> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                context.go(
                  '/welcomeScreen',
                );
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: const Center(
              child: Text(
            "Report Detail",
            style: TextStyle(color: Color.fromARGB(255, 54, 49, 109)),
          )),
          backgroundColor: Colors.white,
        ),
        body: Card(
          color: Colors.grey[300],
          shadowColor: Colors.green[900],
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                Container(
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'http://10.0.2.2:3000/uploads/${widget.detail['imageURL']}'),
                    height: 300,
                    width: double.infinity,
                  ),
                ),
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          width: double.infinity,
                          child: const Text("Incident Details",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25,
                              ))),
                      Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          color: const Color.fromARGB(255, 219, 219, 218),
                          width: double.infinity,
                          height: 70,
                          child: Text(
                              "description: ${widget.detail['description']}")),
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        color: const Color.fromARGB(255, 219, 219, 218),
                        height: 40,
                        width: double.infinity,
                        child: Text("Location :${widget.detail['location']}"),
                      ),
                      Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          color: const Color.fromARGB(255, 219, 219, 218),
                          height: 30,
                          width: double.infinity,
                          child: Text("Time: ${widget.detail["time"]}")),
                      Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(5),
                        color: const Color.fromARGB(255, 219, 219, 218),
                        height: 30,
                        width: double.infinity,
                        child: Text(
                          "Status: ${widget.detail["status"]}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
