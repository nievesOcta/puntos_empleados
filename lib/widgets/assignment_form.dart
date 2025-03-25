import 'package:flutter/material.dart';

typedef AssignmentAddedCallback = void Function(String title, String description, int points);

class AssignmentForm extends StatefulWidget {
  final AssignmentAddedCallback onAssignmentAdded;

  AssignmentForm({required this.onAssignmentAdded});

  @override
  _AssignmentFormState createState() => _AssignmentFormState();
}

class _AssignmentFormState extends State<AssignmentForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pointsController = TextEditingController();

  void _addAssignment() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final points = int.tryParse(_pointsController.text.trim()) ?? 0;

    if (description.isNotEmpty && points > 0) {
      widget.onAssignmentAdded(title, description, points);

      _titleController.clear();
      _descriptionController.clear();
      _pointsController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            hintText: 'Títutlo de la tarea',
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: _descriptionController,
          decoration: InputDecoration(
            hintText: 'Descripción de las tareas',
          ),
        ),
        SizedBox(height: 16.0),
        TextField(
          controller: _pointsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Puntos',
          ),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: _addAssignment,
          child: Text('Agregar Tarea'),
        ),
      ],
    );
  }
}
