import 'package:crime_reporter/screens/reportCrime.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  SearchBar({ Key? key, required this.crimes}) : super(key: key);
  List crimes;

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  List filteredCrimes = [];
  final searchcontroler = TextEditingController();

  searchCrime(String query){
    setState(() {
      filteredCrimes = widget.crimes.where((crime){
       final crimeName = crime.name.toLowerCase();
       final input = query.toLowerCase();
       return crimeName.contains(input);
     }).toList();
      
    });
          
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:const  EdgeInsets.fromLTRB(20, 30, 50, 10),
       child: TextField(
         controller: searchcontroler,
         decoration: InputDecoration(
           hintText: 'what is the crime ?',
           prefixIcon: const Icon(Icons.search,size: 25,),
           border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(50)
           ),
           contentPadding: EdgeInsets.symmetric(vertical: 8 ,horizontal: 120)
         ),
         onChanged: (query){
                 setState(() {
                    filteredCrimes = widget.crimes.where((crime){
                    final crimeName = crime.name.toLowerCase();
                    final input = query.toLowerCase();
                    return crimeName.contains(input);
                  }).toList();
      
                  });
                  },

       ),
    );
  }
}