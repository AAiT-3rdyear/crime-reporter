import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:crime_reporter/presentation/auth/login.dart';

// ignore: use_function_type_syntax_for_parameters
void main() {
  group('Login Page', () {
    testWidgets("finds a Text ", (tester) async {
      // Build an App with a Text widget that displays the letter 'H'.
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('NO'),
        ),
      ));

      // Find a widget that displays the letter 'H'.
      expect(find.text('NO'), findsOneWidget);
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
}
