import 'package:flutter/material.dart';
import 'package:puntos_empleados/models/employee.dart';

class EmployeeListItem extends StatelessWidget {
  final Employee employee;

  EmployeeListItem({required this.employee});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(employee.name),
      trailing: Text('Puntos: ${employee.points}'),
    );
  }
}