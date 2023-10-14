import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weekly1/main.dart';

void main() {
  testWidgets('UI Testing', (WidgetTester tester) async {
    // Build our widget
    await tester.pumpWidget(MaterialApp(
      home: ContactUsApp(),
    ));

    // Find and verify the title
    expect(find.text('XRamadhannApps'), findsOneWidget);

    // Find and verify some specific elements
    expect(find.text('Welcome to'), findsOneWidget);
    expect(find.text('XRamadhannApps'), findsOneWidget);
    expect(find.text('Touch Me to More'), findsOneWidget);

    // Tap on the 'Submit' button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
    await tester.pump();

    // Verify if the confirmation dialog is displayed
    expect(find.text('Confirmation'), findsOneWidget);
    expect(
        find.text('Are you sure you want to submit the form?'), findsOneWidget);

    // You can add more test cases for other elements as needed
  });
}
