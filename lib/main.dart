import 'package:flutter/material.dart';
//import 'screens/login_screen.dart'; // Importa la nueva pantalla de login
import 'screens/dashboard_screen.dart'; // Importa la nueva pantalla de login


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
      home: const DashboardScreen(),
    );
  }
}
