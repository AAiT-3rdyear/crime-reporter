import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

// ignore: use_function_type_syntax_for_parameters
void main() {
  group('SignUP  Page', () {
    testWidgets("finds a Text ", (tester) async {
      // Build an App with a Text widget that displays the letter 'H'.
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('Sign Up'),
        ),
      ));

      // Find a widget that displays the letter 'H'.
      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets("finds a Text ", (tester) async {
      // Build an App with a Text widget that displays the letter 'H'.
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('CRIME'),
        ),
      ));

      // Find a widget that displays the letter 'H'.
      expect(find.text('CRIME'), findsOneWidget);
    });
  });

  testWidgets("finds hint text ", (tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
     await tester.pumpWidget(MaterialApp(
       home: Scaffold(
         body:TextFormField(
           decoration: InputDecoration(hintText: 'Enter Full name'),
         ),
       )
     ));
     
     expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets("finds hint text ", (tester) async {
    // Build an App with a Text widget that displays the letter 'H'.
     await tester.pumpWidget(MaterialApp(
       home: Scaffold(
         body:TextFormField(
           decoration: InputDecoration(suffixIcon: Icon(Icons.email)),
         ),
       )
     ));
     
     expect(find.byIcon(Icons.email), findsOneWidget);
  });

  


 
}

