import 'package:puntos_empleados/models/employee.dart';
import 'package:puntos_empleados/models/assignment.dart';

// Servicio para gestionar las asignaciones
class AssignmentService {
  // Lista estática de asignaciones (simulando una base de datos)
  static final List<Assignment> _assignments = [
    Assignment(
        title: 'Completar informe mensual',
        description: 'Elaborar el informe de ventas del mes de abril',
        points: 30,
        employeeId: '1',
        isCompleted: true
    ),
    Assignment(
        title: 'Reunión con clientes',
        description: 'Presentación de nuevos productos a clientes potenciales',
        points: 50,
        employeeId: '1',
        isCompleted: true
    ),
    Assignment(
        title: 'Organizar inventario',
        description: 'Revisión y organización del inventario de la bodega',
        points: 40,
        employeeId: '1',
        isCompleted: false
    ),
    Assignment(
        title: 'Capacitación de ventas',
        description: 'Asistir a la capacitación de nuevas técnicas de ventas',
        points: 25,
        employeeId: '2',
        isCompleted: true
    ),
    Assignment(
        title: 'Resolver incidencias',
        description: 'Resolver las incidencias reportadas por los clientes',
        points: 35,
        employeeId: '2',
        isCompleted: false
    ),
    Assignment(
        title: 'Actualizar documentación',
        description: 'Actualizar la documentación de los procesos de la empresa',
        points: 20,
        employeeId: '3',
        isCompleted: true
    ),
  ];

  // Método para obtener todas las asignaciones
  static List<Assignment> getAllAssignments() {
    return _assignments;
  }

  // Método para obtener las asignaciones de un empleado específico
  static List<Assignment> getAssignmentsByEmployeeId(String employeeId) {
    return _assignments.where((assignment) => assignment.employeeId == employeeId).toList();
  }

  // Método para agregar una nueva asignación
  static void addAssignment(Assignment assignment) {
    _assignments.add(assignment);
  }

  // Método para actualizar una asignación existente
  static void updateAssignment(Assignment updatedAssignment) {
    final index = _assignments.indexWhere(
            (assignment) =>
        assignment.title == updatedAssignment.title &&
            assignment.employeeId == updatedAssignment.employeeId
    );

    if (index != -1) {
      _assignments[index] = updatedAssignment;
    }
  }
}