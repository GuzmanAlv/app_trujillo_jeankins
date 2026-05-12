import 'package:flutter/material.dart';
import 'package:app_trujillo/features/eventos/screens/home_screen.dart';
import 'package:app_trujillo/features/eventos/screens/detalle_evento_screen.dart';
import 'package:app_trujillo/features/eventos/screens/mapa_screen.dart';
import 'package:app_trujillo/features/eventos/screens/login_screen.dart';
import 'package:app_trujillo/features/eventos/screens/registro_screen.dart';
import 'package:app_trujillo/features/eventos/screens/turismo_screen.dart';

class AppRouter {
  // Nombres de las rutas
  static const String home = '/';
  static const String detalle = '/detalle';
  static const String mapa = '/mapa';
  static const String login = '/login';
  static const String registro = '/registro';
  static const String turismo = '/turismo';

  static Route<dynamic> generarRuta(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case detalle:
        return MaterialPageRoute(
          builder: (_) => DetalleEventoScreen(
            eventoId: settings.arguments as int,
          ),
        );
      case mapa:
        return MaterialPageRoute(
          builder: (_) => const MapaScreen(),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case registro:
        return MaterialPageRoute(
          builder: (_) => const RegistroScreen(),
        );
      case turismo:
        return MaterialPageRoute(
          builder: (_) => const TurismoScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
    }
  }
}