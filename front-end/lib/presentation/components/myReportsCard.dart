import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../application/user/bloc/userbloc_bloc.dart';

class CrimeCard2 extends StatelessWidget {
  CrimeCard2({ Key? key,this.myreports,this.index}) : super(key: key);
  dynamic myreports;
  dynamic index;
 
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 8,
        shadowColor: Colors.green,
        margin: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            Expanded( flex: 1,
              child: Container(
                height: 160,
                width: 50,
                child: Image(
                image: NetworkImage('http://10.0.2.2:3000/uploads/${myreports[index]['imageURL']}',),
                fit: BoxFit.cover,),
              ),),
                    
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                  Text("Location: ${myreports[index]['location']}"),
                  Text(myreports[index]['description']),
                  Text("status :${myreports[index]["status"]}"),
                  const SizedBox(height: 10,),
                             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                 BlocConsumer<UserblocBloc, UserblocState>(
                      listener: (context, state) {
                        if (state is DeleteSucessfull){
                          
                      showDialog(
                           context: context,
                            builder: (context) {
                         Future.delayed(const Duration(seconds: 8), () {
                              context.go('/welcomeScreen',);
                               });
                           return const AlertDialog(
                            title: Text('sucessfully Deleted'),
                         );
                       });
                          
                          }},
                      builder:(_, UserblocState state){
                            return ElevatedButton(
                           style: ElevatedButton.styleFrom(
                                primary: Colors.yellow[800],
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                                minimumSize: const Size(60, 30),),
  
                        onPressed: (){
                          final userBloc =BlocProvider.of<UserblocBloc>(context);
                           userBloc.add(DeleteReported(myreports[index]['_id']),); 
                           }, 
                        child: const Text('Delete',
                          style: TextStyle(color: Colors.black),
                          
                          ));
                          },
                          ),

                  
                  const SizedBox(width: 1,),
          
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                              primary: Colors.yellow[800],
                              shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                              minimumSize:const  Size(60, 40),),
                
                onPressed:(){context.go('/userviewdetail',extra:myreports[index]);},
                child: const Text('view Detail')),
          ],)
                                        
       ])),
    ]),  
   );
 }
}