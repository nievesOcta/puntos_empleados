import 'package:puntos_empleados/models/assignment.dart';
import 'package:puntos_empleados/services/assignment_service.dart';

class Employee {
  final String id;
  final String name;
  final String? imageUrl;
  List<Assignment> assignments = [];

  Employee({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  int get points => assignments.where((a) => a.isCompleted).fold(0, (sum, a) => sum + a.points);

  // Método para obtener todas las asignaciones del empleado
  List<Assignment> getAssignments() {
    return AssignmentService.getAssignmentsByEmployeeId(id);
  }

  // Método para obtener solo las asignaciones completadas
  List<Assignment> getCompletedAssignments() {
    return getAssignments().where((assignment) => assignment.isCompleted).toList();
  }

  // Método para calcular los puntos totales (solo de asignaciones completadas)
  int getPoints() {
    return getCompletedAssignments().fold(0, (sum, assignment) => sum + assignment.points);
  }

  // Método para agregar una nueva asignación al empleado
  void addAssignment({
    required String title,
    required String description,
    required int points,
    bool isCompleted = false,
  }) {
    final assignment = Assignment(
      title: title,
      description: description,
      points: points,
      employeeId: id,
      isCompleted: isCompleted,
    );
    assignments.add(assignment);
    AssignmentService.addAssignment(assignment);
  }
}
