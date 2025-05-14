import 'package:flutter/material.dart';
import 'package:puntos_empleados/screens/login_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  // Datos de perfil ejemplo
  final Map<String, String> _perfilData = {
    'nombre': 'Juan Pérez',
    'matricula': '12345',
    'cargo': 'Analista de Ventas',
    'puntos': '850',
    'nivel': 'Avanzado',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundColor: Colors.blue,
            child: Icon(
              Icons.person,
              size: 80,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _perfilData['nombre'] ?? '',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Matrícula: ${_perfilData['matricula']}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          _buildInfoCard('Cargo', _perfilData['cargo'] ?? ''),
          _buildInfoCard('Puntos Acumulados', _perfilData['puntos'] ?? ''),
          _buildInfoCard('Nivel', _perfilData['nivel'] ?? ''),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Acción para editar perfil
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.limeAccent[400],
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Editar Perfil',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}