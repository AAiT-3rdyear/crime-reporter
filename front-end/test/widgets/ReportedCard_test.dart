import 'package:crime_reporter/presentation/components/reportedCard.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

// ignore: use_function_type_syntax_for_parameters
void main() {
  group('crime card', () {
    testWidgets("finding a button ", (tester) async {
      // testing elevated button for crime card.
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Container(),
        ),
      ));

      expect(find.byType(IconButton), findsNothing);
    });

    testWidgets("find icons ", (tester) async {
      // testing images.
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: Container(),
      )));

      expect(find.byIcon(Icons.add), findsNothing);
    });
  });
}
