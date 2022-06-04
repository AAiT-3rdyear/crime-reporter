import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../infrastructure/repository/user_repositories.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key? key, required this.image, this.user}) : super(key: key);
  String image;
  dynamic user;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (index) async {
          if (index == 0) {
            context.go('/login');
          } else if (index == 1) {
            final userRepository = UserRepository();
            bool authorized = await userRepository.hasToken();
            if (authorized) {
              context.go('/myprofile', extra: widget.user);
            }
          } else if (index == 2) {
            context.go('/about');
          }
        },
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
                color: Colors.amber,
              ),
              label: 'home'),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              backgroundImage:
                  NetworkImage('http://10.0.2.2:3000/uploads/${widget.image}'),
              radius: 25,
            ),
            label: 'Me',
          ),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
                size: 30,
                color: Colors.amber,
              ),
              label: 'AboutUs'),
        ]);
  }
}
