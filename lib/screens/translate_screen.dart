import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  bool _isCameraActive = false;
  String _translatedText = '';

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initializeCameraWithPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      await _initializeCamera();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de cámara denegado')),
      );
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final backCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(
      backCamera,
      ResolutionPreset.medium,
      enableAudio: false,
    );

    await _cameraController!.initialize();

    setState(() {
      _isCameraInitialized = true;
      _isCameraActive = true;
    });
  }

  void _stopCamera() {
    _cameraController?.dispose();
    _cameraController = null;

    setState(() {
      _isCameraInitialized = false;
      _isCameraActive = false;
      _translatedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF67C9E4), // Fondo celeste
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botón "Volver"
            TextButton(
              onPressed: () {
                if (_isCameraActive) {
                  _stopCamera();
                } else {
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'Volver',
                style: TextStyle(color: Colors.black),
              ),
            ),

            // Vista previa de la cámara o botón para iniciar
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _isCameraInitialized
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CameraPreview(_cameraController!),
                      )
                    : Center(
                        child: ElevatedButton.icon(
                          onPressed: _initializeCameraWithPermission,
                          icon: const Icon(Icons.videocam),
                          label: const Text("Iniciar Traducción"),
                        ),
                      ),
              ),
            ),

            // Texto traducido
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _translatedText.isEmpty
                    ? 'Transcripción en texto, transcripción en texto'
                    : _translatedText,
                style: const TextStyle(color: Colors.black, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),

            const Spacer(),

            // Botón para cancelar cámara si está activa
            if (_isCameraActive)
              Center(
                child: ElevatedButton.icon(
                  onPressed: _stopCamera,
                  icon: const Icon(Icons.close),
                  label: const Text('Cancelar Cámara'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}