import 'package:flutter/material.dart';

import '../models/subject.dart';

/// Karta pojedynczego przedmiotu na liście.
class SubjectTile extends StatelessWidget {
  final Subject subject;
  final VoidCallback onDelete;

  const SubjectTile({
    super.key,
    required this.subject,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(
          subject.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            'Ocena: ${subject.grade.toStringAsFixed(1)}  ·  ECTS: ${subject.ects}',
          ),
        ),
        trailing: IconButton(
          tooltip: 'Usuń przedmiot',
          icon: Icon(Icons.delete_outline, color: scheme.error),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
