import 'package:flutter/material.dart';
import 'package:puntos_empleados/screens/inicio_screen.dart';
import 'package:puntos_empleados/screens/login_screen.dart';
import 'package:puntos_empleados/screens/tareas_screen.dart';
import 'package:puntos_empleados/screens/puntos_screen.dart';
import 'package:puntos_empleados/screens/perfil_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  // Removemos LoginScreen de las páginas y comenzamos con InicioScreen
  final List<Widget> _pages = [
    const InicioScreen(), // índice 0
    const TareasScreen(), // índice 1 
    const PuntosScreen(), // índice 2
    const PerfilScreen(), // índice 3
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false, // Para que no aparezca botón de "atrás"
      ),
      body: _pages[_currentIndex], // Muestra la pantalla activa
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed, // Importante para mostrar 4 o más items
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Puntos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}