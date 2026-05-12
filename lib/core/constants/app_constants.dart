class AppConstants {
  // URL base del backend Spring Boot
  // Cuando tengas el backend listo, cambia esta URL
  static const String baseUrl = 'http://10.0.2.2:8080/api';

  // Endpoints de la API
  static const String eventosUrl = '$baseUrl/eventos';
  static const String turisticoUrl = '$baseUrl/turistico';
  static const String authUrl = '$baseUrl/auth';
  static const String usuariosUrl = '$baseUrl/usuarios';

  // Nombre de la app
  static const String appNombre = 'Trujillo Cultural';
  static const String appVersion = '1.0.0';

  // Google Maps API Key (la agregas cuando tengas la key)
  static const String mapsApiKey = 'TU_API_KEY_AQUI';

  // Coordenadas del centro de Trujillo
  static const double trujilloLat = -8.1116;
  static const double trujilloLng = -79.0287;
  static const double radioKm = 10.0;

  // Paginación
  static const int itemsPorPagina = 10;

  // Duración de animaciones
  static const int animDuracion = 300;

  // Categorías con sus íconos
  static const Map<String, String> categoriaIconos = {
    'cultural':     '🎭',
    'turistico':    '🗺️',
    'danza':        '💃',
    'musica':       '🎶',
    'teatro':       '🎬',
    'gastronomia':  '🍽️',
    'deportivo':    '⚽',
    'arte':         '🎨',
    'taller':       '🛠️',
  };

  // Colores por categoría (hex)
  static const Map<String, int> categoriaColores = {
    'cultural':     0xFF8B1A1A,
    'turistico':    0xFF1565C0,
    'danza':        0xFFAD1457,
    'musica':       0xFF6A1B9A,
    'teatro':       0xFF4527A0,
    'gastronomia':  0xFFE65100,
    'deportivo':    0xFF2E7D32,
    'arte':         0xFF00838F,
    'taller':       0xFF558B2F,
  };

  // Eventos destacados de Trujillo (datos reales)
  static const List<Map<String, dynamic>> eventosPrincipales = [
    {
      'titulo': 'Concurso Nacional de Marinera',
      'mes': 'Enero',
      'lugar': 'Coliseo Gran Chimú',
      'categoria': 'danza',
      'esGratuito': false,
    },
    {
      'titulo': 'Festival Internacional de la Primavera',
      'mes': 'Septiembre',
      'lugar': 'Toda la ciudad',
      'categoria': 'cultural',
      'esGratuito': true,
    },
    {
      'titulo': 'Aniversario Independencia de Trujillo',
      'mes': 'Diciembre',
      'lugar': 'Plaza de Armas',
      'categoria': 'cultural',
      'esGratuito': true,
    },
    {
      'titulo': 'Trujillo: Juventud y Raíces',
      'mes': 'Febrero',
      'lugar': 'Coliseo Inca',
      'categoria': 'cultural',
      'esGratuito': true,
    },
  ];
}