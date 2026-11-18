import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/subject.dart';
import '../utils/grade_calculator.dart';

/// Formularz dodawania nowego przedmiotu.
class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ectsController = TextEditingController();
  double _selectedGrade = GradeCalculator.allowedGrades[3]; // 4.0

  @override
  void dispose() {
    _nameController.dispose();
    _ectsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final ects = int.parse(_ectsController.text.trim());
    final subject = Subject(
      name: _nameController.text.trim(),
      grade: _selectedGrade,
      ects: ects,
    );
    Navigator.of(context).pop(subject);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nowy przedmiot'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nazwa przedmiotu',
                  hintText: 'np. Matematyka',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nazwa nie może być pusta';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<double>(
                initialValue: _selectedGrade,
                decoration: const InputDecoration(
                  labelText: 'Ocena',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.grade_outlined),
                ),
                items: GradeCalculator.allowedGrades
                    .map(
                      (g) => DropdownMenuItem(
                        value: g,
                        child: Text(g.toStringAsFixed(1)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    _selectedGrade = value;
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _ectsController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Punkty ECTS',
                  hintText: 'np. 6',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Podaj liczbę punktów ECTS';
                  }
                  final ects = int.tryParse(value.trim());
                  if (ects == null || ects <= 0) {
                    return 'ECTS musi być dodatnią liczbą całkowitą';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.add),
                label: const Text('Dodaj przedmiot'),
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(48),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
