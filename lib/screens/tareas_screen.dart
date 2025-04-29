import 'package:flutter/material.dart';
import 'package:puntos_empleados/models/employee.dart';
import 'package:puntos_empleados/models/assignment.dart';
import 'package:puntos_empleados/services/employee_service.dart';
import 'package:puntos_empleados/services/assignment_service.dart';

class TareasScreen extends StatefulWidget {
  const TareasScreen({super.key});

  @override
  State<TareasScreen> createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {
  // Lista de empleados
  late List<Employee> _employees;

  @override
  void initState() {
    super.initState();
    _employees = EmployeeService.getAllEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas'),
        backgroundColor: Colors.limeAccent[400],
        foregroundColor: Colors.black,
      ),
      body: _buildKanbanBoard(),
      resizeToAvoidBottomInset: true,
    );
  }

  Widget _buildKanbanBoard() {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Asignaciones por Empleado',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: _employees.isEmpty
                            ? const Center(child: Text('No hay empleados registrados'))
                            : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _employees
                                .map((employee) => _buildEmployeeColumn(employee))
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24), // 👈 Spacer to avoid cutoff
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget _buildEmployeeColumn(Employee employee) {
    final assignments = employee.getAssignments();

    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade700,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: employee.imageUrl != null
                      ? AssetImage(employee.imageUrl!)
                      : null,
                  child: employee.imageUrl == null
                      ? Text(employee.name[0])
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employee.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${employee.getPoints()} puntos',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Scrollable list of assignments
          SizedBox(
            height: 400, // You can adjust this to fit your layout
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...assignments
                      .map((assignment) => _buildAssignmentCard(assignment, employee)),
                  _buildAddAssignmentCard(employee),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentCard(Assignment assignment, Employee employee) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: assignment.isCompleted ? Colors.green : Colors.grey.shade300,
          width: assignment.isCompleted ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () {
          _showEditAssignmentDialog(assignment, employee);
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      assignment.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: assignment.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${assignment.points} pts',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                assignment.description,
                style: TextStyle(
                  color: Colors.grey.shade700,
                  decoration: assignment.isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Estado de la tarea
                  Row(
                    children: [
                      Icon(
                        assignment.isCompleted
                            ? Icons.check_circle
                            : Icons.pending_actions,
                        color: assignment.isCompleted
                            ? Colors.green
                            : Colors.orange,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        assignment.isCompleted ? 'Completada' : 'Pendiente',
                        style: TextStyle(
                          fontSize: 12,
                          color: assignment.isCompleted
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  // Iconos de acción
                  Row(
                    children: [
                      // Marcar como completada
                      IconButton(
                        icon: Icon(
                          assignment.isCompleted
                              ? Icons.refresh
                              : Icons.check,
                          size: 18,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          setState(() {
                            assignment.toggleCompletion();
                            AssignmentService.updateAssignment(assignment);
                          });
                        },
                        tooltip: assignment.isCompleted
                            ? 'Marcar como pendiente'
                            : 'Marcar como completada',
                      ),
                      const SizedBox(width: 8),
                      // Editar tarea
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          size: 18,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          _showEditAssignmentDialog(assignment, employee);
                        },
                        tooltip: 'Editar tarea',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddAssignmentCard(Employee employee) {
    return Card(
      margin: const EdgeInsets.all(8),
      elevation: 2,
      color: Colors.grey.shade200,
      child: InkWell(
        onTap: () {
          _showAddAssignmentDialog(employee);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 100,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_circle_outline,
                  size: 32,
                  color: Colors.grey,
                ),
                SizedBox(height: 8),
                Text(
                  'Agregar nueva tarea',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Diálogo para añadir una nueva tarea
  void _showAddAssignmentDialog(Employee employee) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final pointsController = TextEditingController();
    bool isCompleted = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Text('Nueva Tarea para ${employee.name}'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: pointsController,
                    decoration: const InputDecoration(
                      labelText: 'Puntos',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Tarea completada'),
                    value: isCompleted,
                    onChanged: (value) {
                      setStateDialog(() {
                        isCompleted = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Validar los campos
                  if (titleController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      pointsController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Por favor complete todos los campos'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // Crear y añadir la nueva tarea
                  employee.addAssignment(
                    title: titleController.text,
                    description: descriptionController.text,
                    points: int.tryParse(pointsController.text) ?? 0,
                    isCompleted: isCompleted,
                  );

                  Navigator.pop(context);
                  setState(() {
                    // Actualizar la UI
                  });
                },
                child: const Text('Guardar'),
              ),
            ],
          );
        },
      ),
    );
  }

  // Diálogo para editar una tarea existente
  void _showEditAssignmentDialog(Assignment assignment, Employee employee) {
    final titleController = TextEditingController(text: assignment.title);
    final descriptionController = TextEditingController(text: assignment.description);
    final pointsController = TextEditingController(text: assignment.points.toString());
    bool isCompleted = assignment.isCompleted;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateDialog) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Editar Tarea'),
                Text(
                  'Empleado: ${employee.name}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Título',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: pointsController,
                    decoration: const InputDecoration(
                      labelText: 'Puntos',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Tarea completada'),
                    value: isCompleted,
                    onChanged: (value) {
                      setStateDialog(() {
                        isCompleted = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  // Confirmar eliminación
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Eliminar Tarea'),
                      content: const Text('¿Estás seguro de que deseas eliminar esta tarea?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Aquí se implementaría la función para eliminar la tarea
                            // AssignmentService.deleteAssignment(assignment);

                            // Como no tenemos esa función, sólo cerramos los diálogos
                            Navigator.pop(context); // Cierra el diálogo de confirmación
                            Navigator.pop(context); // Cierra el diálogo de edición

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Para implementar: Eliminar la tarea'),
                                duration: Duration(seconds: 2),
                              ),
                            );

                            setState(() {
                              // Actualizar la UI
                            });
                          },
                          child: const Text('Eliminar'),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Actualizar la tarea con los nuevos valores
                  final updatedAssignment = Assignment(
                    title: titleController.text,
                    description: descriptionController.text,
                    points: int.tryParse(pointsController.text) ?? assignment.points,
                    employeeId: assignment.employeeId,
                    isCompleted: isCompleted,
                  );

                  // Actualizar la tarea
                  AssignmentService.updateAssignment(updatedAssignment);

                  Navigator.pop(context);
                  setState(() {
                    // Actualizar la UI
                  });
                },
                child: const Text('Guardar'),
              ),
            ],
          );
        },
      ),
    );
  }
}