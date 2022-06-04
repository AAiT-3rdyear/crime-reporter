
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/policeBloc/policebloc_bloc.dart';

class ReportedCard extends StatelessWidget {
 ReportedCard({ Key? key,this.title,this.discription ,this.location,
 this.reporter,this.time ,this.path, this.reportto,this.crimeId}) : super(key: key);
  
  dynamic title;  dynamic discription ;
  dynamic location; dynamic time;
  dynamic reportto; dynamic reporter;
  dynamic path; dynamic crimeId;

  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 8,
            shadowColor: Colors.green,
            margin: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              
              Container(
                height: 170,width: 190,
                child: Expanded(
                flex: 1,
                child: Image(
                  image: NetworkImage('http://10.0.2.2:3000/uploads/$path'),
                  fit: BoxFit.cover,),
                                ),
              ),
            
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text(title,style:const  TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Text(discription),
                    const  SizedBox(height: 10,),
                    Text('Location : $location',textAlign: TextAlign.start,),
                    const SizedBox(height: 10,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                       
                    BlocConsumer<PoliceblocBloc, PoliceblocState>(
                      listener: (context, state) {
                        if (state is DeleteSucessfull){
                          
                      showDialog(
                           context: context,
                            builder: (context) {
                         Future.delayed(const Duration(seconds: 8), () {
                              context.go('/policeScreen',);
                               });
                           return const AlertDialog(
                            title: Text('sucessfully Deleted'),
                         );
                       });
                          
                          }},
                      builder:(_, PoliceblocState state){
                            return ElevatedButton(
                           style: ElevatedButton.styleFrom(
                                primary: Colors.yellow[800],
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                                minimumSize: const Size(60, 30),),
  
                        onPressed: (){
                          final policeBloc =BlocProvider.of<PoliceblocBloc>(context);
                           policeBloc.add(DeleteCrime(crimeId),); 
                        }, 
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.black),
                          ));

                          },
                          ),

                       ElevatedButton(
                        style: ElevatedButton.styleFrom(
                                primary: Colors.yellow[800],
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                                minimumSize: const Size(60, 30),),
                        
                        onPressed: (){
                           Map<String, dynamic> detail = 
                           {'imageURL': path, 'name': title, 'status': title,
                           'reportto':reportto,'discription' :discription,'crimeId':crimeId};
                             context.go('/policeviewdetail',extra:detail);
                             }, 
                          child: const Text(
                            'See More',
                            style: TextStyle(color: Colors.black),)),

                    ],),

                    
                        
                        const SizedBox(width: 1,),

                           
                    ],),
                ),
              
            ]),
          
        );

        
  }
}