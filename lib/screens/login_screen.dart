import 'package:flutter/material.dart';
import 'package:puntos_empleados/screens/dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Simulación de credenciales válidas (¡NO USAR EN PRODUCCIÓN!)
  final String _validMatricula = '12345'; // Cambiado a matrícula
  final String _validPassword = 'password'; // Contraseña de prueba

  void _login() {
    String matricula = _matriculaController.text;
    String password = _passwordController.text;

    if (matricula == _validMatricula && password == _validPassword) {
      // ¡Login exitoso! Por ahora, solo mostramos un mensaje.
      // En el futuro, aquí navegaríamos a la pantalla del ranking.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('¡Inicio de sesión exitoso!')),
      );
      _onLoginSuccess();
    } else {
      // Credenciales inválidas
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Matrícula o contraseña incorrectas.')),
      );
    }
  }

  void _onLoginSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const DashboardScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0), // Aumentamos el padding general
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Iniciar Sesión',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40.0),
              TextField(
                controller: _matriculaController,
                decoration: const InputDecoration(
                  labelText: 'Matrícula',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)), // Bordes redondeados
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)), // Bordes redondeados
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              SizedBox( // Para darle un ancho específico al botón
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.limeAccent[400], // Verde brillante
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
                    ),
                  ),
                  child: const Text(
                    'Continuar',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black, // Texto negro para mejor contraste
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}