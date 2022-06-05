import 'package:crime_reporter/presentation/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import '../lib/main.dart' as app;

void main() {
  group("crime-reporter app test", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    testWidgets("Authentication feature integration test", (tester) async {
      app.main();
      await tester.pumpAndSettle();

      final emailformfield = find.byType(TextFormField).first;
      final passwordformfield = find.byType(TextFormField).last;
      final loginbutton = find.byType(ElevatedButton);
      final createAccount = find.byType(InkWell);

      await tester.enterText(emailformfield, "abi@gmail.com");
      await tester.enterText(passwordformfield, "123456");
      await tester.pumpAndSettle();

      await tester.tap(loginbutton);
      await tester.pumpAndSettle();

      expect(find.byType(WelcomeScreen), findsOneWidget);
      expect(find.byType(TextFormField), findsNothing);
      expect(find.text("enter email"), findsNothing);

      await tester.tap(createAccount);
      await tester.pumpAndSettle();

      expect(find.byType(SignUpPage), findsOneWidget);
      expect(find.byType(TextFormField), findsWidgets);
      expect(find.byIcon(Icons.remove), findsNothing);

      
    });
  });
}
