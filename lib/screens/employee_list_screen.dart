import 'package:flutter/material.dart';
import 'package:puntos_empleados/models/employee.dart';
import 'package:puntos_empleados/screens/employee_detail_screen.dart';
import 'package:puntos_empleados/widgets/employee_list_item.dart';
import 'package:puntos_empleados/services/employee_service.dart';

class EmployeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ranking de Empleados'),
      ),
      body: ListView.builder(
        itemCount: EmployeeService.employees.length,
        itemBuilder: (context, index) {
          final employee = EmployeeService.employees[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EmployeeDetailScreen(employee: employee),
                ),
              );
            },
            child: EmployeeListItem(employee: employee),
          );
        },
      ),
    );
  }
}