import 'dart:convert';

import 'package:crime_reporter/api/api.dart';
import 'package:crime_reporter/components/cliper.dart';
import 'package:crime_reporter/models/welcomeScreenArguments.dart';
import 'package:crime_reporter/services/network.dart';
import 'package:crime_reporter/services/socket.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();
    NetworkHandler networkHandler = NetworkHandler();
    TextEditingController emailcontroler = TextEditingController();
    TextEditingController passwordcontroler = TextEditingController();
    dynamic response;
    dynamic response2;
    Api api = Api();
    dynamic user;
    dynamic crimes;
    dynamic authorized = true;
    var circular = false;



     loginHandler() async {
      response = await networkHandler.post('/login',{
                            'username':emailcontroler.text,
                            'password':passwordcontroler.text
                             });}


     sampleCrime() async {
      response2 = await networkHandler.get('/user/crimeSample');
          crimes = api.getSampleCrime(response2.body);
          }

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        body: SafeArea(
          child: Container(
              child: Stack(children: <Widget>[
            ClipPath(
              clipper: TopLeftClipper(),
              child: Container(
                color: Color(0xFFFFC100),
              ),
            ),
            
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    Icons.home,
                    color: Color(0xFFFFC600),
                    size: 40.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: const Text(
                          'NO',
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 243, 242), fontSize: 19.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(15, 5, 0, 2),
                        child: const Text(
                          'Crime',
                          style: TextStyle(
                              color: Color.fromARGB(255, 243, 243, 242), fontSize: 19.0),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: 75.0,
              left: 385.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 550, 10),
                      child: const Text(
                        'Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold),
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 25),
                      child: const Text(
                        'CRIME',
                        style: TextStyle(
                            color: Colors.amber,
                            fontSize: 28.0,
                            fontFamily: 'RobotoMono',
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
         // the 3 images down below
            const Positioned(
                   top:135.0,
                   left: 25.0,
                   child: Padding(
                    padding: EdgeInsets.all(45),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/thief.jpg'),
                      radius: 50,
                    ),
                  )),
                // the second image
                const Positioned(
                  top: 215.0,
                left: 35.0,
                child: Padding(
              padding: EdgeInsets.all(45),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/holded.jpg'),
                radius: 60,
              ),
            )),
            // last image
            const Positioned(
              top: 155.0,
                left: 105.0,
                child: Padding(
              padding: EdgeInsets.all(45),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/hit.png'),
                radius: 50,
              ),
            )),
        
        
            // form field
            Positioned(
                bottom: 5.0,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25.0),
                        topLeft: Radius.circular(25.0)),
                    color: Color(0xFFF6F5F5),
                  ),
                  width: 500,
                  height: 400,
                  child: Form( 
                    key: _formKey,
                      child: Column(children: [
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 25, 100, 0),
                        child: TextFormField(
                          controller: emailcontroler,
                          decoration: InputDecoration(
                              fillColor: Colors.grey[300],
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: 'Enter Email',
                              suffixIcon: const Icon(
                                Icons.email,
                                size: 30,
                                color: Colors.black,
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'email is required ';
                            }
                          },
                        )),
                    Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20, 25, 100, 0),
                      child: TextFormField(
                        controller: passwordcontroler,
                        obscureText: true,
                        decoration: InputDecoration(
                            errorText: authorized ? null:'invalid username or password',

                            fillColor: Colors.grey[300],
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Enter password',
                            suffixIcon: const Icon(
                              Icons.lock,
                              color: Colors.black,
                              size: 27,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'password is required';
                          } 
                        },
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(20, 5, 5, 3),
                    child: Text('Forgot Password?'),
                    ),
        
                    // Login button
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 100, 5),
                      child: circular?CircularProgressIndicator(): ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          
                           primary: const Color(0xFFFFC600),
                           shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        minimumSize: Size(280, 50),
                      ),
                      onPressed: ()async {
                          setState(() {circular = true;});
                          if (_formKey.currentState!.validate()) {
                                 
                                  await loginHandler();

                                  if(response.statusCode == 401){
                                    setState(() { authorized = false; circular= false; });
                                    }
                                  else {
                                     user =  api.getUser(response.body);
                                     await sampleCrime();
                                     setState(() {circular= false;});

                                     Navigator.pushNamed( 
                                       context, 
                                       '/welcomeScreen',
                                       arguments: WelcomeScreenArgs(user: user, sampleCrimes:crimes )); 
                                       }
                                }
                                else{setState(() {circular=false;});}
                                },

                      child: const Text('Login',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.w500),),
                      ),
                      
                      
                      ),
        
                    
                    
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
                      child: Row(
                        children: [
                          const Text(' Not registerd yet ? '),
                          InkWell(
                            onTap: () => Navigator.pushNamed(context, '/signup'),
                            child: const Text(
                              'Create Account ',
                              style: TextStyle(fontSize: 15, color: Color.fromARGB(255, 59, 118, 118), fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ])),
                ))
          ])),
        ));
  }
}