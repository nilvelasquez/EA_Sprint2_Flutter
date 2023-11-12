// Agrega la importación del paquete http
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();

  // La URL de tu backend
  final String apiUrl = 'http://localhost:9090/users';

  // Método para realizar la solicitud de registro al backend
  Future<void> _registerUser() async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'name': _nameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      // Verifica si la solicitud fue exitosa (código 200)
      if (response.statusCode == 200) {
        // Registro exitoso, redirige a la pantalla de inicio de sesión
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else {
        // Muestra un mensaje de error si la solicitud no fue exitosa
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al registrar al usuario'),
          ),
        );
      }
    } catch (e) {
      // Maneja errores de conexión o cualquier otra excepción
      print('Error: $e');
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al conectar con el servidor'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _verifyPasswordController,
              obscureText: true,
              decoration:
                  const InputDecoration(labelText: 'Verificar Contraseña'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _registerUser,
              child: const Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }
}
