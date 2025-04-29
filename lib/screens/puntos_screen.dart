import 'package:flutter/material.dart';
import 'package:puntos_empleados/models/employee.dart';
import 'package:puntos_empleados/models/assignment.dart';
import 'package:puntos_empleados/services/employee_service.dart';

class PuntosScreen extends StatefulWidget {
  const PuntosScreen({super.key});

  @override
  State<PuntosScreen> createState() => _PuntosScreenState();
}

class _PuntosScreenState extends State<PuntosScreen> {
  Employee? _selectedEmployee;

  @override
  Widget build(BuildContext context) {
    return _selectedEmployee == null
        ? _buildEmployeeList()
        : _buildEmployeeDetail(_selectedEmployee!);
  }

  // Lista de empleados
  Widget _buildEmployeeList() {
    final employees = EmployeeService.getAllEmployees();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Empleados',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Nuevo botón para agregar empleado
              ElevatedButton.icon(
                onPressed: () {
                  _showAddEmployeeDialog();
                },
                icon: const Icon(Icons.add),
                label: const Text('Agregar Empleado'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.limeAccent[400],
                  foregroundColor: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: employee.imageUrl != null
                          ? AssetImage(employee.imageUrl!)
                          : null,
                      child: employee.imageUrl == null
                          ? Text(employee.name[0]) // Primera letra del nombre
                          : null,
                    ),
                    title: Text(employee.name),
                    subtitle: Text('Puntos: ${employee.getPoints()}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        _selectedEmployee = employee;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Detalle del empleado seleccionado
  Widget _buildEmployeeDetail(Employee employee) {
    final completedAssignments = employee.getCompletedAssignments();
    final allAssignments = employee.getAssignments();

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              // Imagen con manejo de errores y placeholder
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey.shade300, // Color de fondo por defecto
                child: employee.imageUrl != null
                    ? Image.asset(
                  employee.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Muestra un icono en caso de error en la imagen
                    return const Center(
                      child: Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.grey,
                      ),
                    );
                  },
                )
                    : const Center(
                  child: Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre del empleado con botón de edición
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          employee.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Nuevo botón para editar empleado
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditEmployeeDialog(employee);
                          },
                          tooltip: 'Editar empleado',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Sección de puntos
                    const Text(
                      'PUNTOS',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${employee.getPoints()} puntos',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Sección de tareas
                    const Text(
                      'TAREAS',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: allAssignments.isEmpty
                          ? const Text('No hay tareas asignadas')
                          : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: allAssignments.map((assignment) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: [
                                Icon(
                                  assignment.isCompleted
                                      ? Icons.check_circle
                                      : Icons.radio_button_unchecked,
                                  color: assignment.isCompleted
                                      ? Colors.green
                                      : Colors.grey,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        assignment.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: assignment.isCompleted
                                              ? TextDecoration.lineThrough
                                              : null,
                                        ),
                                      ),
                                      Text(assignment.description),
                                    ],
                                  ),
                                ),
                                Text(
                                  '${assignment.points} pts',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Botones de acción
                    _buildActionButtons(employee),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Botón para volver a la lista de empleados
        Positioned(
          top: 16,
          left: 16,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  _selectedEmployee = null;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(Employee employee) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildButton('Ver Perfil', Colors.blue, Colors.white, () {
          // Acción para ver perfil completo
        }),
        _buildButton('Asignar', Colors.cyan, Colors.white, () {
          // Acción para asignar nuevas tareas
          _showAssignmentDialog(employee);
        }),
        _buildButton('Completar', Colors.limeAccent[400]!, Colors.black, () {
          // Acción para marcar tareas como completadas
          _showCompleteTaskDialog(employee);
        }),
        _buildButton('Historial', Colors.grey, Colors.white, () {
          // Acción para ver historial completo de tareas
        }),
      ],
    );
  }

  Widget _buildButton(String text, Color backgroundColor, Color textColor, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              padding: EdgeInsets.zero, // Elimina el padding interno
            ),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 12, // Texto más pequeño para que quepa
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  // Diálogo para asignar nuevas tareas
  void _showAssignmentDialog(Employee employee) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final pointsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Asignar Nueva Tarea'),
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
              // Validar y guardar la nueva tarea
              if (titleController.text.isNotEmpty &&
                  descriptionController.text.isNotEmpty &&
                  pointsController.text.isNotEmpty) {

                employee.addAssignment(
                  title: titleController.text,
                  description: descriptionController.text,
                  points: int.tryParse(pointsController.text) ?? 0,
                );

                Navigator.pop(context);
                setState(() {}); // Actualizar la UI
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  // Diálogo para marcar tareas como completadas
  void _showCompleteTaskDialog(Employee employee) {
    final incompleteAssignments = employee.getAssignments()
        .where((assignment) => !assignment.isCompleted)
        .toList();

    if (incompleteAssignments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay tareas pendientes por completar')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Completar Tareas'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: incompleteAssignments.length,
            itemBuilder: (context, index) {
              final assignment = incompleteAssignments[index];
              return CheckboxListTile(
                title: Text(assignment.title),
                subtitle: Text('${assignment.points} puntos'),
                value: false,
                onChanged: (bool? value) {
                  if (value == true) {
                    assignment.toggleCompletion();
                    Navigator.pop(context);
                    setState(() {}); // Actualizar la UI
                  }
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  // NUEVO: Diálogo para editar un empleado existente
  void _showEditEmployeeDialog(Employee employee) {
    final nameController = TextEditingController(text: employee.name);
    final imageUrlController = TextEditingController(text: employee.imageUrl ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar Empleado'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL de imagen (opcional)',
                  border: OutlineInputBorder(),
                  hintText: 'assets/images/employee.jpg',
                ),
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
              // En un escenario real, aquí actualizaríamos el empleado
              // Como no tenemos un método de actualización en EmployeeService,
              // mostramos un mensaje informativo

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Para implementar: Actualizar empleado en el servicio'),
                  duration: Duration(seconds: 2),
                ),
              );

              // La implementación real requeriría actualizar el empleado en el servicio:
              // EmployeeService.updateEmployee(Employee(
              //   id: employee.id,
              //   name: nameController.text,
              //   imageUrl: imageUrlController.text.isEmpty ? null : imageUrlController.text,
              // ));

              setState(() {
                // Actualizar la UI después de editar
              });
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  // NUEVO: Diálogo para agregar un nuevo empleado
  void _showAddEmployeeDialog() {
    final nameController = TextEditingController();
    final imageUrlController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Agregar Empleado'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL de imagen (opcional)',
                  border: OutlineInputBorder(),
                  hintText: 'assets/images/employee.jpg',
                ),
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
              // Validar y guardar el nuevo empleado
              if (nameController.text.isNotEmpty) {
                // En un escenario real, aquí añadiríamos el empleado
                // Como no tenemos un método de adición en EmployeeService,
                // mostramos un mensaje informativo

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Para implementar: Agregar empleado en el servicio'),
                    duration: Duration(seconds: 2),
                  ),
                );

                // La implementación real requeriría:
                // EmployeeService.addEmployee(Employee(
                //   id: (EmployeeService.getAllEmployees().length + 1).toString(),
                //   name: nameController.text,
                //   imageUrl: imageUrlController.text.isEmpty ? null : imageUrlController.text,
                // ));

                setState(() {
                  // Actualizar la UI después de agregar
                });
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}