class EventoModel {
  final int? id;
  final String titulo;
  final String descripcion;
  final String lugar;
  final double latitud;
  final double longitud;
  final DateTime fechaInicio;
  final DateTime? fechaFin;
  final TipoEvento tipo;
  final CategoriaEvento categoria;
  final bool esGratuito;
  final double? precio;
  final String? imagenUrl;
  final bool esRecurrente;
  final String? organizador;

  EventoModel({
    this.id,
    required this.titulo,
    required this.descripcion,
    required this.lugar,
    required this.latitud,
    required this.longitud,
    required this.fechaInicio,
    this.fechaFin,
    required this.tipo,
    required this.categoria,
    required this.esGratuito,
    this.precio,
    this.imagenUrl,
    this.esRecurrente = false,
    this.organizador,
  });

  // Convierte JSON del backend a objeto Dart
  factory EventoModel.fromJson(Map<String, dynamic> json) {
    return EventoModel(
      id: json['id'],
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      lugar: json['lugar'],
      latitud: json['latitud']?.toDouble() ?? 0.0,
      longitud: json['longitud']?.toDouble() ?? 0.0,
      fechaInicio: DateTime.parse(json['fechaInicio']),
      fechaFin: json['fechaFin'] != null
          ? DateTime.parse(json['fechaFin'])
          : null,
      tipo: TipoEvento.values.firstWhere(
            (e) => e.name == json['tipo'],
        orElse: () => TipoEvento.municipal,
      ),
      categoria: CategoriaEvento.values.firstWhere(
            (e) => e.name == json['categoria'],
        orElse: () => CategoriaEvento.cultural,
      ),
      esGratuito: json['esGratuito'] ?? true,
      precio: json['precio']?.toDouble(),
      imagenUrl: json['imagenUrl'],
      esRecurrente: json['esRecurrente'] ?? false,
      organizador: json['organizador'],
    );
  }

  // Convierte objeto Dart a JSON para enviar al backend
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'lugar': lugar,
      'latitud': latitud,
      'longitud': longitud,
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin': fechaFin?.toIso8601String(),
      'tipo': tipo.name,
      'categoria': categoria.name,
      'esGratuito': esGratuito,
      'precio': precio,
      'imagenUrl': imagenUrl,
      'esRecurrente': esRecurrente,
      'organizador': organizador,
    };
  }
}

// Tipos de evento según tu investigación
enum TipoEvento {
  municipal,    // Eventos de la Municipalidad
  tradicional,  // Marinera, Primavera (anuales)
  artistico,    // Teatro, música, exposiciones
  recurrente,   // Cine semanal, talleres
  especial,     // Festivales internacionales
}

// Categorías para filtrar
enum CategoriaEvento {
  cultural,
  turistico,
  danza,
  musica,
  teatro,
  gastronomia,
  deportivo,
  arte,
  taller,
}