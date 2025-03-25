import 'package:puntos_empleados/models/assignment.dart';

class Employee {
  final String name;
  int points;
  final List<Assignment> assignments;

  Employee({
    required this.name,
    this.points = 0,
    this.assignments = const [],
  });

  void addAssignment(Assignment assignment) {
    assignments.add(assignment);
    points += assignment.points;
  }
}