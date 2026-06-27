import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_trujillo/core/theme/app_theme.dart';
import 'package:app_trujillo/core/router/app_router.dart';

// Maneja notificaciones cuando la app está cerrada
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AppTrujillo());
}

class AppTrujillo extends StatefulWidget {
  const AppTrujillo({super.key});

  @override
  State<AppTrujillo> createState() => _AppTrujilloState();
}

class _AppTrujilloState extends State<AppTrujillo> {
  @override
  void initState() {
    super.initState();
    _configurarNotificaciones();
  }

  void _configurarNotificaciones() async {
    final messaging = FirebaseMessaging.instance;

    // Pedir permisos
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // Obtener token del dispositivo
    final token = await messaging.getToken();
    debugPrint('Token FCM: $token');

    // Notificación cuando app está abierta
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Notificación recibida: ${message.notification?.title}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trujillo Cultural',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.tema,
      initialRoute: AppRouter.login,
      onGenerateRoute: AppRouter.generarRuta,
    );
  }
}