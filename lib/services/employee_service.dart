import 'package:puntos_empleados/models/employee.dart';

// Servicio para gestionar los empleados
class EmployeeService {
  // Lista estática de empleados (simulando una base de datos)
  static final List<Employee> _employees = [
    Employee(
      id: '1',
      name: 'María González',
      imageUrl: 'assets/images/employee1.jpg',
    ),
    Employee(
      id: '2',
      name: 'Juan Pérez',
      imageUrl: 'assets/images/employee2.jpg',
    ),
    Employee(
      id: '3',
      name: 'Ana Rodríguez',
      imageUrl: 'assets/images/employee3.jpg',
    ),
  ];

  // Método para obtener todos los empleados
  static List<Employee> getAllEmployees() {
    return _employees;
  }

  // Método para obtener un empleado por su ID
  static Employee? getEmployeeById(String id) {
    try {
      return _employees.firstWhere((employee) => employee.id == id);
    } catch (e) {
      return null;
    }
  }
}