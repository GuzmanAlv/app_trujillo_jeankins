import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:app_trujillo/core/theme/app_theme.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({super.key});

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  final MapController _mapController = MapController();
  String _filtroSeleccionado = 'Todos';

  static const LatLng _trujillo = LatLng(-8.1116, -79.0287);

  final List<String> _filtros = [
    'Todos', 'Gratuitos', 'Cultural', 'Turismo',
  ];

  final List<Map<String, dynamic>> _eventosEnMapa = [
    {
      'nombre': 'Concurso Nacional de Marinera',
      'lugar': 'Coliseo Gran Chimú',
      'fecha': 'Enero 2026',
      'distancia': '1.2 km',
      'categoria': 'Cultural',
      'esGratuito': false,
      'precio': 'S/ 25',
      'emoji': '💃',
      'color': 0xFF8B1A1A,
      'lat': -8.1050,
      'lng': -79.0280,
    },
    {
      'nombre': 'Chan Chan',
      'lugar': 'Av. Mansiche',
      'fecha': 'Todos los días',
      'distancia': '5.0 km',
      'categoria': 'Turismo',
      'esGratuito': false,
      'precio': 'S/ 10',
      'emoji': '🏛️',
      'color': 0xFF1565C0,
      'lat': -8.1027,
      'lng': -79.0739,
    },
    {
      'nombre': 'Festival de la Primavera',
      'lugar': 'Plaza de Armas',
      'fecha': 'Septiembre 2026',
      'distancia': '0.5 km',
      'categoria': 'Cultural',
      'esGratuito': true,
      'precio': 'Gratuito',
      'emoji': '🌸',
      'color': 0xFFAD1457,
      'lat': -8.1116,
      'lng': -79.0287,
    },
    {
      'nombre': 'Huaca del Sol y la Luna',
      'lugar': 'Campiña de Moche',
      'fecha': 'Todos los días',
      'distancia': '6.5 km',
      'categoria': 'Turismo',
      'esGratuito': false,
      'precio': 'S/ 15',
      'emoji': '🌞',
      'color': 0xFFD4A017,
      'lat': -8.1620,
      'lng': -78.9997,
    },
    {
      'nombre': 'Huanchaco',
      'lugar': 'Distrito Huanchaco',
      'fecha': 'Todo el año',
      'distancia': '12 km',
      'categoria': 'Turismo',
      'esGratuito': true,
      'precio': 'Gratuito',
      'emoji': '🏄',
      'color': 0xFF0277BD,
      'lat': -8.0808,
      'lng': -79.1200,
    },
    {
      'nombre': 'Temporada Cultural CEPROCUT',
      'lugar': 'Centro Cultural',
      'fecha': 'Todo 2026',
      'distancia': '0.8 km',
      'categoria': 'Cultural',
      'esGratuito': true,
      'precio': 'Gratuito',
      'emoji': '🎭',
      'color': 0xFF4527A0,
      'lat': -8.1100,
      'lng': -79.0300,
    },
  ];

  List<Map<String, dynamic>> get _eventosFiltrados {
    if (_filtroSeleccionado == 'Todos') return _eventosEnMapa;
    if (_filtroSeleccionado == 'Gratuitos') {
      return _eventosEnMapa.where((e) => e['esGratuito'] == true).toList();
    }
    return _eventosEnMapa
        .where((e) => e['categoria'] == _filtroSeleccionado)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondo,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            color: AppTheme.primario,
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mapa de eventos 🗺️',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Trujillo, La Libertad',
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 34,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filtros.length,
                    itemBuilder: (context, index) {
                      final seleccionado =
                          _filtroSeleccionado == _filtros[index];
                      return GestureDetector(
                        onTap: () => setState(
                                () => _filtroSeleccionado = _filtros[index]),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding:
                          const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: seleccionado
                                ? Colors.white
                                : Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              _filtros[index],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: seleccionado
                                    ? AppTheme.primario
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Mapa OpenStreetMap
          Expanded(
            flex: 2,
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _trujillo,
                initialZoom: 13,
              ),
              children: [
                // Tiles de OpenStreetMap
                TileLayer(
                  urlTemplate:
                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app_trujillo',
                ),
                // Marcadores de eventos
                MarkerLayer(
                  markers: _eventosFiltrados.map((evento) {
                    return Marker(
                      point: LatLng(evento['lat'], evento['lng']),
                      width: 50,
                      height: 50,
                      child: GestureDetector(
                        onTap: () => _mostrarDetalleEvento(evento),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(evento['color']),
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              evento['emoji'],
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Contador
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_eventosFiltrados.length} lugares encontrados',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Toca un marcador para ver detalle',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),

          // Lista
          Expanded(
            flex: 1,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _eventosFiltrados.length,
              itemBuilder: (context, index) {
                final evento = _eventosFiltrados[index];
                return _buildTarjetaMapa(evento);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalleEvento(Map<String, dynamic> evento) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(evento['emoji'],
                    style: const TextStyle(fontSize: 32)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        evento['nombre'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        evento['lugar'],
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(evento['color']),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    evento['precio'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _infoItem(Icons.calendar_today, evento['fecha']),
                const SizedBox(width: 16),
                _infoItem(Icons.near_me, evento['distancia']),
                const SizedBox(width: 16),
                _infoItem(Icons.category, evento['categoria']),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Future.delayed(const Duration(milliseconds: 300), () {
                        _mapController.move(
                          LatLng(evento['lat'], evento['lng']),
                          16,
                        );
                      });
                    },
                    icon: const Icon(Icons.map_outlined),
                    label: const Text('Ver en mapa'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppTheme.primario,
                      side: const BorderSide(color: AppTheme.primario),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.bookmark_border,
                        color: Colors.white),
                    label: const Text('Guardar',
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primario,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(IconData icono, String texto) {
    return Row(
      children: [
        Icon(icono, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Text(texto,
            style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildTarjetaMapa(Map<String, dynamic> evento) {
    final color = Color(evento['color']);
    return GestureDetector(
      onTap: () {
        _mapController.move(
          LatLng(evento['lat'], evento['lng']),
          16,
        );
        _mostrarDetalleEvento(evento);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(evento['emoji'],
                    style: const TextStyle(fontSize: 24)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    evento['nombre'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Icon(Icons.location_on,
                          size: 12, color: Colors.grey.shade400),
                      const SizedBox(width: 3),
                      Text(
                        evento['lugar'],
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    evento['precio'],
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.near_me,
                        size: 11, color: Colors.grey.shade400),
                    const SizedBox(width: 2),
                    Text(
                      evento['distancia'],
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}