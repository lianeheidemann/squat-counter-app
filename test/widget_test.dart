import 'package:aplicativo_squat_counter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('configures and opens a workout', (tester) async {
    await tester.pumpWidget(const SquatCounterApp());

    expect(find.text('Configure seu treino'), findsOneWidget);
    expect(find.text('30 agachamentos'), findsOneWidget);

    await tester.tap(find.widgetWithIcon(IconButton, Icons.add_rounded).first);
    await tester.pump();
    expect(find.text('33 agachamentos'), findsOneWidget);

    await tester.tap(find.text('Começar treino'));
    await tester.pumpAndSettle();

    expect(find.text('Treino em andamento'), findsOneWidget);
    expect(find.text('Iniciar contagem'), findsOneWidget);
  });
}
