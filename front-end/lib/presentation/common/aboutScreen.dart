import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {context.go('/welcomeScreen',);},
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title:const Text('About Page'),
          centerTitle: true,
          elevation: 12.0,
        ),

        body: Container(child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
          SizedBox(
            height: 300,
            child: Expanded(child: 
              Container(  
              width: 700, 

               
              padding: const  EdgeInsets.all(10.0),  
              child: Card(  
                    
                    shape: RoundedRectangleBorder(  
                    borderRadius: BorderRadius.circular(15.0),  
                    ),  
                    color: const Color.fromARGB(229, 197, 215, 218),  
                    elevation: 5,  
                    child: Column(  
                        
                      children: const <Widget>[  
                        ListTile(  
                          leading: Image(image: AssetImage('assets/images/c.png'),),  
                          title: Text(  
                            'Crime Reporter',  
                            style: TextStyle(fontSize: 30.0)  
                          ),  
                          
                          subtitle: Text( 
                             
                            'Crime-reporter application help people to report crimes to the nearby police station by using their android phone . Crime activities can be theft, fighting, corruption acts and the like. The user can send his file in the form of photo, audio or video to the nearby police station.',  
                            style: TextStyle(fontSize: 18.0)  
                          ),  
                        ),  
                        
                      ],  
                    ),  
                  ),  
                )  
              ),
          ),
          SizedBox(
            height: 300,
            child: Expanded(child: Container(
              width: 700,
              
              padding:const EdgeInsets.all(10),
              child: Card(
                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: const Color.fromARGB(255, 238, 232, 231),
                    elevation: 5, 
                    child: ListView(
                       children: const <Widget>[
                         ListTile(  
                             
                            title: Text(  
                              'Developers',  
                              style: TextStyle(fontSize: 40.0)  
                            ),),
                         
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:(AssetImage('assets/images/abinet.png')) ,
                                ),
                                title: Text('Abinet Anamo'),
                                subtitle: Text('abianamo282@gmail.com'),
                                
                              ),
          
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:(AssetImage('assets/images/biruk.png')) ,
                                ),
                                title: Text('Biruk Anley'),
                                subtitle: Text('birukanley1991@gmail.com'),
                                
                              ),
          
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:(AssetImage('assets/images/gizaw.png')) ,
                                ),
                                title: Text('Gizaw Agodo'),
                                subtitle: Text('gizawag123@gmail.com'),
                                
                              ),
                              
                            ],
                          )
                      ),
                    ),),
          )] )),
          
        
    );
  }
}


