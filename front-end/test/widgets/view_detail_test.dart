import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('welcome Screen   Page', () {
    testWidgets("finds a Text ", (tester) async {
      // Build an App with a Text widget that displays the letter 'H'.
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('description'),
        ),
      ));

      // Find a widget that displays the letter 'H'.
      expect(find.text('description'), findsOneWidget);
    });

    testWidgets("finds a Text ", (tester) async {
      // Build an App with a Text widget that displays the letter 'H'.
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('Location'),
        ),
      ));

      // Find a widget that displays the letter 'H'.
      expect(find.text('Location'), findsOneWidget);
    });
  });
}
