import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../application/Auth/Bloc/Auth_event.dart';
import '../../application/Auth/Bloc/Auth_state.dart';
import '../../application/Auth/Bloc/auth_bloc.dart';
import '../../application/Auth/auth.dart';

class Profilepage extends StatefulWidget {
  @override
  State<Profilepage> createState() => _ProfilepageState();
  Profilepage({Key? key, this.user}) : super(key: key);
  dynamic user;
}

class _ProfilepageState extends State<Profilepage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          "Your Profile",
          style: TextStyle(color: Colors.black),
        )),
        leading: IconButton(
            onPressed: () {
              if (widget.user.role == "User") {
                context.go(
                  '/welcomeScreen',
                );
              } else {
                context.go(
                  '/policeScreen',
                );
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black45.withOpacity(0.7)),
                        ],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'http://10.0.2.2:3000/uploads/${widget.user.imgUrl}'),
                            fit: BoxFit.cover)),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: ElevatedButton(
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {
                      context.go('/editprofile', extra: widget.user);
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.yellow),
                  ),
                ),
                Center(
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is LogedOut) {
                        context.go('/login');
                      }
                    },
                    builder: (_, AuthState state) {
                      return ElevatedButton(
                        child: const Text(
                          "LogOut",
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: () {
                          final authBloc = BlocProvider.of<AuthBloc>(context);
                          authBloc.add(LogOut());
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.yellow),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      color: Colors.grey[300],
                      shadowColor: Colors.green[900],
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Name",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(widget.user.fullname),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey[300],
                      shadowColor: Colors.green[900],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Email",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.user.email),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey[300],
                      shadowColor: Colors.green[900],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("password",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.user.fullname),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      margin: const EdgeInsets.all(10),
                      color: Colors.grey[300],
                      shadowColor: Colors.green[900],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Phone Number",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(widget.user.phoneNo),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
