import 'dart:convert';

import 'package:flutter/services.dart';

class EventosJsonService {
  static const String _rutaEventos = 'assets/data/eventos.json';

  Future<List<Map<String, dynamic>>> obtenerEventos() async {
    final contenido = await rootBundle.loadString(_rutaEventos);
    final data = jsonDecode(contenido);

    if (data is! List) {
      throw Exception('El archivo eventos.json debe contener una lista de eventos.');
    }

    return data.map<Map<String, dynamic>>((evento) {
      if (evento is! Map<String, dynamic>) {
        throw Exception('Cada evento debe ser un objeto JSON.');
      }
      return evento;
    }).toList();
  }
}
