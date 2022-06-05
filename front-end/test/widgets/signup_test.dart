import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('SignUP  Page', () {
    testWidgets("finds a Text ", (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('Sign Up'),
        ),
      ));

      expect(find.text('Sign Up'), findsOneWidget);
    });

    testWidgets("finds a Text ", (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('CRIME'),
        ),
      ));

      // Find a widget that displays the text 'CRIME'.
      expect(find.text('CRIME'), findsOneWidget);
    });
  });

  testWidgets("finds textfield", (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: TextFormField(
        decoration: InputDecoration(hintText: 'Enter Full name'),
      ),
    )));

    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets("finds an Icon ", (tester) async {
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
      body: TextFormField(
        decoration: InputDecoration(suffixIcon: Icon(Icons.email)),
      ),
    )));

    expect(find.byIcon(Icons.email), findsOneWidget);
  });
}
