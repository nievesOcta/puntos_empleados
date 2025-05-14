import 'package:flutter/material.dart';
import 'package:puntos_empleados/models/employee.dart';
import 'package:puntos_empleados/screens/employee_detail_screen.dart';
import 'package:puntos_empleados/widgets/employee_list_item.dart';
import 'package:puntos_empleados/services/employee_service.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List<Employee> employees = [];

  @override
  void initState() {
    super.initState();
    _loadEmployees();
  }

  Future<void> _loadEmployees() async {
    final loadedEmployees = EmployeeService.getAllEmployees();
    setState(() {
      employees = loadedEmployees;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ranking de Empleados'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadEmployees,
        child: employees.isEmpty
            ? const Center(
                child: Text('No hay empleados registrados'),
              )
            : ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) {
                  final employee = employees[index];
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => 
                              EmployeeDetailScreen(employee: employee),
                        ),
                      );
                      // Recargar la lista después de volver
                      _loadEmployees();
                    },
                    child: EmployeeListItem(employee: employee, onTap: () {  },),
                  );
                },
              ),
      ),
    );
  }
}