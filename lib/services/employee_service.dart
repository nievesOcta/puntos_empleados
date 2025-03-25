import 'package:puntos_empleados/models/employee.dart';
import 'package:puntos_empleados/models/assignment.dart';

class EmployeeService {
  static final List<Employee> employees = [
    Employee(name: 'Juan ', points: 10, assignments: [
      Assignment(title: 'Tarea 1', description: 'Terminó el proyecto A', points: 5),
      Assignment(title: 'Tarea 2', description: 'Terminó el deber B', points: 3),
    ]),
    Employee(name: 'Juana Suárez', points: 15, assignments: [
      Assignment(title: 'Tarea 3', description: 'Entregó el reporte X', points: 7),
      Assignment(title: 'Tarea 4', description: 'Resolvió el problema Y', points: 4),
    ]),
    Employee(name: 'Miguel Juárez', points: 8, assignments: [
      Assignment(title: 'Tarea 5', description: 'Implemento la función Z', points: 4),
      Assignment(title: 'Tarea 6', description: 'Optimizó el proceso W', points: 2),
    ]),
    Employee(name: 'Emilia Rodriguéz', points: 12, assignments: [
      Assignment(title: 'Tarea 7', description: 'Escribió documentación', points: 3),
      Assignment(title: 'Tarea 8', description: 'Probó nuevas funcionalidades', points: 5),
    ]),
  ];
}