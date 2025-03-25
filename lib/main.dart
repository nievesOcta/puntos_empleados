import 'package:flutter/material.dart';
import 'package:puntos_empleados/screens/employee_list_screen.dart';

void main() {
  runApp(EmployeePointRankingApp());
}

class EmployeePointRankingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ranking de Empleados por Puntos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EmployeeListScreen(),
    );
  }
}
