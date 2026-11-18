import 'package:flutter/material.dart';

import '../models/subject.dart';
import '../utils/grade_calculator.dart';
import '../widgets/subject_tile.dart';
import 'add_subject_screen.dart';

/// Ekran główny: lista przedmiotów, średnia ważona i suma ECTS.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Subject> _subjects = [];

  Future<void> _addSubject() async {
    final result = await Navigator.of(context).push<Subject>(
      MaterialPageRoute(builder: (_) => const AddSubjectScreen()),
    );

    if (result != null) {
      setState(() => _subjects.add(result));
    }
  }

  void _removeSubject(int index) {
    setState(() => _subjects.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final average = GradeCalculator.weightedAverage(_subjects);
    final ectsSum = GradeCalculator.totalEcts(_subjects);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Grade Calculator'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _SummaryHeader(
            averageLabel: GradeCalculator.formatAverage(average),
            ectsSum: ectsSum,
            subjectCount: _subjects.length,
            color: scheme.primaryContainer,
            onColor: scheme.onPrimaryContainer,
          ),
          Expanded(
            child: _subjects.isEmpty
                ? const _EmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8, bottom: 88),
                    itemCount: _subjects.length,
                    itemBuilder: (context, index) {
                      final subject = _subjects[index];
                      return SubjectTile(
                        subject: subject,
                        onDelete: () => _removeSubject(index),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addSubject,
        icon: const Icon(Icons.add),
        label: const Text('Dodaj przedmiot'),
      ),
    );
  }
}

class _SummaryHeader extends StatelessWidget {
  final String averageLabel;
  final int ectsSum;
  final int subjectCount;
  final Color color;
  final Color onColor;

  const _SummaryHeader({
    required this.averageLabel,
    required this.ectsSum,
    required this.subjectCount,
    required this.color,
    required this.onColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
        child: Row(
          children: [
            Expanded(
              child: _StatBlock(
                label: 'Średnia ważona',
                value: averageLabel,
                onColor: onColor,
              ),
            ),
            Expanded(
              child: _StatBlock(
                label: 'Suma ECTS',
                value: '$ectsSum',
                onColor: onColor,
              ),
            ),
            Expanded(
              child: _StatBlock(
                label: 'Przedmioty',
                value: '$subjectCount',
                onColor: onColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatBlock extends StatelessWidget {
  final String label;
  final String value;
  final Color onColor;

  const _StatBlock({
    required this.label,
    required this.value,
    required this.onColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: onColor.withValues(alpha: 0.8),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: onColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'Brak przedmiotów',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Dodaj pierwszy przedmiot, aby obliczyć średnią ważoną ECTS.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
