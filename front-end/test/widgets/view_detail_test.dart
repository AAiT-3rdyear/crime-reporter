import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('welcome Screen   Page', () {
    testWidgets("finds a Text ", (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('description'),
        ),
      ));

      expect(find.text('description'), findsOneWidget);
    });

    testWidgets("finds a Text ", (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('Location'),
        ),
      ));

      expect(find.text('Location'), findsOneWidget);
    });
  });
}
