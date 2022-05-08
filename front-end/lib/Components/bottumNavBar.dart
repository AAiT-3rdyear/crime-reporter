import 'package:flutter/material.dart';



class BottomNavBar extends StatefulWidget {
  BottomNavBar({ Key? key ,required this.image}) : super(key: key);
   String image;
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(

      onTap: ((index) {
        if (index==0) { Navigator.pushNamed(context, '/login');} 
        else if(index ==1 ){ Navigator.pushNamed(context,'/login');}
        else if(index ==2 ){ Navigator.pushNamed(context, '/login');}
      }),

      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home,size: 30,color: Colors.amber,),
                                label: 'home'),

        BottomNavigationBarItem( icon: Container(
                        child: CircleAvatar(backgroundImage: AssetImage('assets/images/${widget.image}'),radius: 25,)),
                        label: 'Me',
              ),
        const BottomNavigationBarItem(icon: Icon(Icons.message),label: 'messages'),

      ]);
  }
}