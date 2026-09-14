import 'package:squat_counter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('configures and opens a workout', (tester) async {
    await tester.pumpWidget(const SquatCounterApp());

    expect(find.text('Configure your\nworkout'), findsOneWidget);
    expect(find.text('30 squats'), findsOneWidget);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.add_rounded).first);
    await tester.pump();
    expect(find.text('33 squats'), findsOneWidget);

    await tester.tap(find.text('Start workout'));
    await tester.pumpAndSettle();

    expect(find.text('Squat Counter'), findsOneWidget);
    expect(find.text('Start counting'), findsOneWidget);
  });
}
