import 'package:flutter/material.dart';
import 'package:puntos_empleados/models/employee.dart';
import 'package:puntos_empleados/widgets/assignment_form.dart';

class EmployeeDetailScreen extends StatefulWidget {
  final Employee employee;

  const EmployeeDetailScreen({Key? key, required this.employee}) : super(key: key);

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Puntos: ${widget.employee.points}'),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: widget.employee.assignments.length,
                itemBuilder: (context, index) {
                  final assignment = widget.employee.assignments[index];
                  return ListTile(
                    title: Text(assignment.description),
                    trailing: Text('Puntos: ${assignment.points}'),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            AssignmentForm(
              onAssignmentAdded: (title, description, points) {
                setState(() {
                  widget.employee.addAssignment(
                    title: title,
                    description: description,
                    points: points,
                  );
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}