
import 'package:crime_reporter/presentation/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteGenerator{

  dynamic routes; 

  RouteGenerator(){
     routes = GoRouter(
        initialLocation: '/',
        routes: [ 
        GoRoute(path:'/',
               builder: (BuildContext context, GoRouterState state) => const Splash(),),     
        GoRoute(path: '/welcomeScreen',
                builder: (context, state) =>  WelcomeScreen()),
        GoRoute(path: '/login',
                builder: (context, state) =>  const LoginPage()),
        GoRoute(path:'/policeScreen',
                builder: (context, state) => PoliceScreen()), 
        GoRoute(path: '/signUp',
                builder: (context, state) =>  const SignUpPage()),
        GoRoute(path: '/crimeDetail',
                builder: (context, state) =>  CrimeDetail(foundStations: state.extra)), 
        GoRoute(path: '/myreports',
                builder: (context, state) =>  MyReports()), 
        GoRoute(path: '/myprofile',
                builder: (context, state) => Profilepage(user: state.extra!),),
        GoRoute(path: '/editprofile',
               builder: (context, state) => EditProfile(user: state.extra!),),
        GoRoute(path: '/userviewdetail',
               builder: (context, state) => UserViewDetail(detail: state.extra!),),

        GoRoute(path: '/policeviewdetail',
               builder: (context, state) => PoliceViewDetail(detail: state.extra!),),
      
        GoRoute(path: '/about',
               builder: (context, state) => const About()),
       
      ]);
  }
   

dynamic getRoutes(){
  return routes;
}
}