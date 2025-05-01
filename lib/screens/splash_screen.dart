import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:handspeak/data/routes.dart'; // Asegúrate que AppRoutes.login esté definido.

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5DB9D6), // Celeste de fondo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HANDSPEAK',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
                fontFamily: 'Poppins', // cambia si tienes otra fuente
              ),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: const Icon(Icons.power_settings_new, size: 40, color: Colors.white),
              onPressed: () {
                context.go(AppRoutes.welcome.path); // o cualquier otra ruta
              },
            ),
          ],
        ),
      ),
    );
  }
}
