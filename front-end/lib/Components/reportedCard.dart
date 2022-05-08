
import 'package:flutter/material.dart';

class ReportedCard extends StatelessWidget {
  const ReportedCard({ Key? key,}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 8,
            shadowColor: Colors.green,
            margin: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              
                  Expanded(
                    flex: 1,
                    child: Image(
                      image: AssetImage('assets/crimeImages/theft.jpg'),
                      fit: BoxFit.cover,),
                  ),
            
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                    Text('Theft',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text('I have seen man stealing bag in the bus while i am standing '),
                    SizedBox(height: 10,),
                    Text('Reporter :Gizaw',textAlign: TextAlign.start,),
                    Text('Location :Addis Ababa',textAlign: TextAlign.start,),


                    const SizedBox(height: 10,),
                     ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                    primary: Colors.yellow[800],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)),
                                    minimumSize: const Size(70, 40),),
                        onPressed: (){}, child: const Text('See More',style: TextStyle(color: Colors.black),)),
                        const SizedBox(width: 1,),

                  
                              
                    ],),
                ),
              

            ]),
          
        );
  }
}