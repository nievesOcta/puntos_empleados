import 'package:flutter/material.dart';
import 'package:puntos_empleados/models/employee.dart';
import 'package:puntos_empleados/models/assignment.dart';
import 'package:puntos_empleados/widgets/assignment_form.dart';

class EmployeeDetailScreen extends StatelessWidget {
  final Employee employee;

  EmployeeDetailScreen({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(employee.name),
        ),
        body: Padding(
        padding: EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Text('Puntos: ${employee.points}'),
    SizedBox(height: 16.0),
      Expanded(
        child: ListView.builder(
          itemCount: employee.assignments.length,
          itemBuilder: (context, index) {
            final assignment = employee.assignments[index];
            return ListTile(
              title: Text(assignment.description),
              trailing: Text('Puntos: ${assignment.points}'),
            );
          },
        ),
      ),
      SizedBox(height: 16.0),
      AssignmentForm(
        onAssignmentAdded: (title, description, points) {
          employee.addAssignment(Assignment(
            title: title,
            description: description,
            points: points,
          ));
          Navigator.pop(context);
        },
      ),
    ],
    ),
        ),
    );
  }
}