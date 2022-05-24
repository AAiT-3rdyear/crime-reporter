
// import 'dart:convert';
// import 'package:crime_reporter/network/resToModel.dart';
// import 'package:crime_reporter/components/bottumNavBar.dart';
// import 'package:crime_reporter/components/reportedCard.dart';
// import 'package:crime_reporter/models/report.dart';
// import 'package:crime_reporter/screens/ongoingCrimesScreen.dart';
// import 'package:crime_reporter/screens/solvedCrimesScreen.dart';
// import 'package:crime_reporter/network/network.dart';
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class PoliceScreen extends StatefulWidget {
//   PoliceScreen({ Key? key,this.user,this.reportedList }) : super(key: key);
//   final user;
//   dynamic reportedList;
//   @override
//   State<PoliceScreen> createState() => _ReportCrimeState();
// }

// class _ReportCrimeState extends State<PoliceScreen> {
//   var selected1 = true;
//   var selected2 = false;
//   var selected3 =false;

// NetworkHandler networkHandler = NetworkHandler();
//  late IO.Socket socket;
//   Api api = Api();
//   dynamic report;
//   dynamic response;
//   dynamic response2;
//   dynamic solvedList;
//   List <Report>reported = [];
//   List <String> responses = [];



//   @override
//   void initState() {
//     super.initState();
//     connect();
//     solvedCrimes();
//   }
  
//    dynamic connect()async{
//      try {
//         socket = IO.io('http://10.0.2.2:3000', <String, dynamic>
//         {'transports': ['websocket'], 'autoConnect': false,});
//               socket.connect();
//               socket.emit("login",widget.user.userId);
//               socket.onConnect((data) {
//                   socket.on("report", (msg) async{
//                   report = await api.getReportedCrime(msg);
//                   setState(()  { reported.insert(0, report);});
//                   print(reported);});});
//         } catch (e) {print(e.toString());}}

 
//  solvedCrimes() async {
//       solvedList = await networkHandler.post('/police/reportedCrimes/${widget.user.fullname}',{
//                      'status':"solved",});}


//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       body: Container(child: Column(children: [
              
//                  SafeArea(
//                   child: Container(
//                     child: Stack(
//                       overflow: Overflow.visible,
//                       children:  [const Card(
//                         child: ListTile(
//                           leading: Image(width:120,image: AssetImage('assets/images/logo.jpg')),
//                           title: Text( 'Reported',
//                                 style: TextStyle(fontSize: 20,color: Colors.green,fontWeight: FontWeight.bold),),
//                         ),
//                       ),
//                       Positioned(top: 5,right: 15,
//                         child: Container(
//                           color: Colors.white,width: 60,height: 60,
//                           child: const Image(
//                             fit: BoxFit.cover,
//                             image: AssetImage('assets/images/speaker.jpg'))))
//                       ]),
//                   ),
//                 ),
              

//                   const SizedBox(height: 20,),
//                   Text(
//                     selected1? 'Reported Crimes':(selected2?'OnGoing Crimes':'Solved Crimes'),
//                     style: const TextStyle(fontFamily:'times',fontWeight: FontWeight.bold ,fontSize: 20),),
//                     const SizedBox(height: 10,),

//                Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     SizedBox(height: 50,),
//                     InkWell(
//                       hoverColor: Colors.orange,
//                       highlightColor:  Colors.orange,
//                       child: Container(
//                           decoration: BoxDecoration(
//                                     border: Border(
//                                     bottom: BorderSide(width: 4.0, color: selected1?Colors.orange:Colors.black),),),
//                           width: 100,
//                           height: 40,
//                           child: const Text('Reported',style: TextStyle(fontWeight: FontWeight.bold),),
//                           alignment: Alignment.center,
//                             ),
//                       onTap: () {
//                              setState(() {selected1= true;selected2=false;selected3= false;
//                               });
//                             },),
              
//                      InkWell(
//                       hoverColor: Colors.orange,
//                       splashColor: Colors.red,
//                       highlightColor:  Colors.orange,
//                       child: Container(
//                           decoration: BoxDecoration(
//                                     border: Border(
//                                     bottom: BorderSide(
//                                       width: 4.0, 
//                                       color:selected2?Colors.orange:Colors.black),),),
//                           width: 100,
//                           height: 40,
//                           child: const Text('OnGoing',style: TextStyle(fontWeight: FontWeight.bold),),
//                           alignment: Alignment.center,
//                             ),
//                       onTap: () {
//                          setState(() {
//                           selected1= false;
//                           selected2 = true;
//                           selected3= false;
//                         });
//                       },
//                     ),
              
//                      InkWell(
//                       hoverColor: Colors.orange,
//                       splashColor: Colors.red,
//                       highlightColor:  Colors.orange,
//                       child: Container(
//                           decoration: BoxDecoration(
//                                     border: Border(
//                                     bottom: BorderSide(
//                                       width: 4.0, 
//                                       color:selected3?Colors.orange:Colors.black),),),
//                           width: 100,
//                           height: 40,
//                           child: const Text('Solved',style: TextStyle(fontWeight: FontWeight.bold),),
//                           alignment: Alignment.center,
//                             ),
//                       onTap: ()async {
//                           await solvedCrimes();
//                           setState(() {
//                           selected1= false;
//                           selected2=false;
//                           selected3 = true;
//                         });
//                       },
//                     ),
//                 ],),
              
              
//                selected1? (reported.isEmpty?
//                Container(
//                  padding: const EdgeInsets.all(70),
//                  child: Column(children: const [Text('no new reported data ',style: TextStyle(fontFamily: "italic",fontWeight: FontWeight.bold,fontSize: 17),),
//                                        Text('tap ongoing for previously recived',style: TextStyle(fontFamily: "italic",fontWeight: FontWeight.bold,fontSize: 17))
//                            ]))
//                :Expanded(
//                  child: ListView.builder(
                                
//                                 itemCount:(reported).length,
//                                 itemBuilder: (BuildContext context ,int index){
//                                 return 
//                                 ReportedCard(title:(reported)[index].title,
//                                              discription: reported[index].description,
//                                              location: reported[index].location,
//                                              time: reported[index].time,
//                                             path: reported[index].imageURL, 

//                                              );}),))
               
//                :(selected2? OngoingCrime(reported: widget.reportedList,):SolvedCrime(solved:json.decode((solvedList).body),))
            
//         ],)
//     ),

//     bottomNavigationBar:BottomNavBar(image:'default.jpg')
    
//     );
    
//   }
// }