import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weekly1/main.dart';

void main() {
  testWidgets('UI Testing', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ContactUsApp()));

    expect(find.text('XRamadhannForm'), findsOneWidget);
    expect(find.text('Welcome to'), findsOneWidget);
    expect(find.text('XRamadhannForm'), findsOneWidget);

    await tester.tap(find.text('Submit'));
    await tester.pump();

    expect(find.text('Confirmation'), findsOneWidget);
    expect(
        find.text('Are you sure you want to submit the form?'), findsOneWidget);

    // Additional test cases can be added here
  });
}
