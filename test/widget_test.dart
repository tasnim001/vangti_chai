import 'package:flutter_test/flutter_test.dart';

import 'package:vangti_chai/main.dart';

void main() {
  testWidgets('VangtiChai loads and displays Taka label', (WidgetTester tester) async {
    // Build the VangtiChai app
    await tester.pumpWidget(const VangtiChaiApp());

    // Verify the "Taka:" label is displayed
    expect(find.textContaining('Taka:'), findsOneWidget);
  });

  testWidgets('Numeric keypad button tap updates input', (WidgetTester tester) async {
    await tester.pumpWidget(const VangtiChaiApp());

    // Tap on button "1"
    await tester.tap(find.text('1'));
    await tester.pump();

    // Verify "Taka: 1" is shown
    expect(find.text('Taka: 1'), findsOneWidget);
  });

  testWidgets('Clear button resets the input', (WidgetTester tester) async {
    await tester.pumpWidget(const VangtiChaiApp());

    // Tap some digits
    await tester.tap(find.text('2'));
    await tester.pump();
    await tester.tap(find.text('3'));
    await tester.pump();

    // Now clear the input
    await tester.tap(find.text('C'));
    await tester.pump();

    // Should show "Taka: "
    expect(find.text('Taka: '), findsOneWidget);
  });
}