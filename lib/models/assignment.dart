class Assignment {
  final String title;
  final String description;
  final int points;
  final String employeeId; // ID del empleado asociado
  bool isCompleted; // Indica si la tarea está completada

  Assignment({
    required this.title,
    required this.description,
    required this.points,
    required this.employeeId,
    this.isCompleted = false, // Por defecto las tareas no están completadas
  });

  // Método para marcar la tarea como completada o no completada
  void toggleCompletion() {
    isCompleted = !isCompleted;
  }
}