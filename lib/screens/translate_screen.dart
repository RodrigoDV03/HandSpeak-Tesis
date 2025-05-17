import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:handspeak/data/colors.dart';
import 'package:handspeak/data/routes.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({Key? key}) : super(key: key);

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      body: SafeArea(
        child: Column(
          children: [
            // Parte superior con fondo blanco
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // Acción para historial
                    },
                    child: Image.asset(
                      'assets/images/history_icon.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(AppRoutes.dashboard.camera.name);
                    },
                    child: Image.asset(
                      'assets/images/camera_icon.png',
                      width: 60,
                      height: 60,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Texto con estilo y color similar al diseño
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Empieza a explorar todas las\nfuncionalidades que “Handspeak”\ntiene para ti',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF044056),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Imagen
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Image.asset(
                  'assets/images/translate_girl.png',
                  width: 220,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}