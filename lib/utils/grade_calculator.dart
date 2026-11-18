import '../models/subject.dart';

/// Obliczenia średniej ważonej ECTS.
class GradeCalculator {
  /// Dozwolone oceny w skali polskiej (ujętej w formularzu).
  static const List<double> allowedGrades = [2.0, 3.0, 3.5, 4.0, 4.5, 5.0];

  /// Średnia ważona = suma(ocena × ECTS) / suma(ECTS).
  /// Dla pustej listy lub zerowej sumy ECTS zwraca `null` (UI pokazuje „—”).
  static double? weightedAverage(List<Subject> subjects) {
    if (subjects.isEmpty) return null;

    var weightedSum = 0.0;
    var ectsSum = 0;

    for (final subject in subjects) {
      weightedSum += subject.grade * subject.ects;
      ectsSum += subject.ects;
    }

    if (ectsSum == 0) return null;
    return weightedSum / ectsSum;
  }

  /// Suma punktów ECTS.
  static int totalEcts(List<Subject> subjects) {
    return subjects.fold(0, (sum, s) => sum + s.ects);
  }

  /// Formatuje średnią do dwóch miejsc albo „—” gdy brak wyniku.
  static String formatAverage(double? average) {
    if (average == null) return '—';
    return average.toStringAsFixed(2);
  }
}
