import 'package:flutter_test/flutter_test.dart';
import 'package:grade_calculator/models/subject.dart';
import 'package:grade_calculator/utils/grade_calculator.dart';

void main() {
  group('GradeCalculator.weightedAverage', () {
    test('zwraca null dla pustej listy', () {
      expect(GradeCalculator.weightedAverage(const []), isNull);
      expect(GradeCalculator.formatAverage(null), '—');
    });

    test('zwraca null gdy suma ECTS wynosi 0', () {
      const subjects = [
        Subject(name: 'X', grade: 5.0, ects: 0),
      ];
      expect(GradeCalculator.weightedAverage(subjects), isNull);
    });

    test('przykład z polecenia: 4.40', () {
      const subjects = [
        Subject(name: 'Matematyka', grade: 4.5, ects: 6),
        Subject(name: 'Programowanie', grade: 5.0, ects: 5),
        Subject(name: 'Fizyka', grade: 3.5, ects: 4),
      ];

      final average = GradeCalculator.weightedAverage(subjects);
      expect(average, isNotNull);
      expect(average!, closeTo(4.40, 0.001));
      expect(GradeCalculator.formatAverage(average), '4.40');
      expect(GradeCalculator.totalEcts(subjects), 15);
    });
  });
}
