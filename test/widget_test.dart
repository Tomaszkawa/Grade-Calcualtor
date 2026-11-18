import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grade_calculator/main.dart';

void main() {
  testWidgets('ekran główny pokazuje pustą listę i pozwala dodać przedmiot',
      (tester) async {
    await tester.pumpWidget(const GradeCalculatorApp());

    expect(find.text('Brak przedmiotów'), findsOneWidget);
    expect(find.text('—'), findsOneWidget);
    expect(find.text('Dodaj przedmiot'), findsOneWidget);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.text('Nowy przedmiot'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Nazwa przedmiotu'),
      'Matematyka',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Punkty ECTS'),
      '6',
    );

    // Domyślna ocena w formularzu to 4.0 — zmieniamy na 4.5
    await tester.tap(find.byType(DropdownButtonFormField<double>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('4.5').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Dodaj przedmiot'));
    await tester.pumpAndSettle();

    expect(find.text('Matematyka'), findsOneWidget);
    expect(find.textContaining('Ocena: 4.5'), findsOneWidget);
    expect(find.text('4.50'), findsOneWidget); // średnia
    expect(find.text('6'), findsWidgets); // suma ECTS
  });

  testWidgets('walidacja blokuje pustą nazwę', (tester) async {
    await tester.pumpWidget(const GradeCalculatorApp());
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Punkty ECTS'),
      '5',
    );
    await tester.tap(find.text('Dodaj przedmiot'));
    await tester.pumpAndSettle();

    expect(find.text('Nazwa nie może być pusta'), findsOneWidget);
    expect(find.text('Nowy przedmiot'), findsOneWidget);
  });
}
