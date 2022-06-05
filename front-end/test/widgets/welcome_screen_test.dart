import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  group('welcome Screen   Page', () {
    testWidgets("finds a Text ", (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Text('Report A Crime'),
        ),
      ));

      expect(find.text('Report A Crime'), findsOneWidget);
    });

    testWidgets("finds an image ", (tester) async {
      await tester.pumpWidget(MaterialApp(
          home: Scaffold(
        body: Container(
            child: const Image(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/speaker.jpg'))),
      )));

      expect(find.byType(Image), findsWidgets);
    });
  });
}
