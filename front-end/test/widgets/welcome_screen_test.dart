
import '../../lib/screens/welcomeScreen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

// ignore: use_function_type_syntax_for_parameters
void main() {
  group('welcome Screen   Page', () {
    

    testWidgets("finds a Text ", (tester) async {
      // Build an App with a Text widget that displays the letter 'H'.
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('Report A Crime'),
        ),
      ));

      // Find a widget that displays the letter 'H'.
      expect(find.text('Report A Crime'), findsOneWidget);
    });

    testWidgets("finds hint text ", (tester) async {
    // testing text form fild.
     await tester.pumpWidget(MaterialApp(
       home: Scaffold(
         body:Container(
           child: const Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/speaker.jpg'))
         ),
       )
     ));
     
     expect(find.byType(Image), findsWidgets);
  });


  });

  

  

 
}

