import 'package:flutter/material.dart';
import 'package:puntos_empleados/services/employee_service.dart';
import 'package:fl_chart/fl_chart.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  @override
  Widget build(BuildContext context) {
    final employees = EmployeeService.getAllEmployees();
    final sortedEmployees = [...employees]
      ..sort((a, b) => b.getPoints().compareTo(a.getPoints()));
    final topEmployees = sortedEmployees.take(3).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tarjetas de resumen
          Row(
            children: [
              _buildSummaryCard(
                'Total Empleados',
                employees.length.toString(),
                Icons.people,
                Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildSummaryCard(
                'Tareas Activas',
                employees
                    .expand((e) => e.getAssignments())
                    .where((a) => !a.isCompleted)
                    .length
                    .toString(),
                Icons.pending_actions,
                Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Gráfico de puntos
          Container(
            height: 200,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 6,
                ),
              ],
            ),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: sortedEmployees.first.getPoints().toDouble() * 1.2,
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= employees.length) return const Text('');
                        return Text(
                          employees[value.toInt()].name.split(' ')[0],
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barGroups: employees.asMap().entries.map((entry) {
                  return BarChartGroupData(
                    x: entry.key,
                    barRods: [
                      BarChartRodData(
                        toY: entry.value.getPoints().toDouble(),
                        color: Colors.blue.shade300,
                        width: 16,
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Top 3 empleados
          const Text(
            'Top Empleados',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ...topEmployees.asMap().entries.map((entry) {
            final employee = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: _getPositionColor(entry.key),
                  child: Text(
                    '${entry.key + 1}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(employee.name),
                subtitle: Text('${employee.getPoints()} puntos'),
                trailing: _buildMedalIcon(entry.key),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: color.withOpacity(0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                color: color.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPositionColor(int position) {
    switch (position) {
      case 0:
        return Colors.amber;
      case 1:
        return Colors.grey.shade400;
      case 2:
        return Colors.brown.shade300;
      default:
        return Colors.grey;
    }
  }

  Widget _buildMedalIcon(int position) {
    IconData icon;
    Color color;
    switch (position) {
      case 0:
        icon = Icons.emoji_events;
        color = Colors.amber;
        break;
      case 1:
        icon = Icons.emoji_events;
        color = Colors.grey.shade400;
        break;
      case 2:
        icon = Icons.emoji_events;
        color = Colors.brown.shade300;
        break;
      default:
        icon = Icons.emoji_events;
        color = Colors.grey;
    }
    return Icon(icon, color: color, size: 30);
  }
}