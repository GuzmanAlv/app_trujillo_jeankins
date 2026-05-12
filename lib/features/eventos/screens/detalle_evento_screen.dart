import 'package:flutter/material.dart';
import 'package:app_trujillo/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DetalleEventoScreen extends StatefulWidget {
  final int eventoId;
  const DetalleEventoScreen({super.key, required this.eventoId});

  @override
  State<DetalleEventoScreen> createState() => _DetalleEventoScreenState();
}

class _DetalleEventoScreenState extends State<DetalleEventoScreen> {
  bool _guardado = false;
  bool _favorito = false;

  Future<void> _abrirMapa() async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=Coliseo+Gran+Chimu+Trujillo+Peru',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el mapa')),
        );
      }
    }
  }

  Future<void> _compartir() async {
    final url = Uri.parse(
      'https://wa.me/?text=Te+invito+al+Concurso+Nacional+de+Marinera+en+Trujillo+%F0%9F%92%83+Enero+2026+en+el+Coliseo+Gran+Chim%C3%BA',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondo,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppTheme.primario,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _favorito ? Icons.favorite : Icons.favorite_border,
                  color: _favorito ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() => _favorito = !_favorito);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        _favorito
                            ? '❤️ Agregado a favoritos'
                            : 'Eliminado de favoritos',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: _compartir,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppTheme.primario,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 40),
                      Text('💃', style: TextStyle(fontSize: 60)),
                      Text(
                        'Concurso Nacional de Marinera',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _chip('TRADICIONAL', AppTheme.primario),
                      const SizedBox(width: 8),
                      _chip('S/ 25.00', const Color(0xFFAD1457)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _infoCard([
                    _infoRow(Icons.calendar_today, 'Fecha', 'Enero 2026'),
                    _divider(),
                    _infoRow(Icons.access_time, 'Hora', '09:00 AM'),
                    _divider(),
                    _infoRow(Icons.location_on, 'Lugar', 'Coliseo Gran Chimú'),
                    _divider(),
                    _infoRow(Icons.person, 'Organiza',
                        'Municipalidad de Trujillo'),
                  ]),
                  const SizedBox(height: 16),

                  const Text(
                    'Descripción',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'El Concurso Nacional de Marinera es el evento de danza '
                        'más importante del Perú. Se realiza anualmente en Trujillo, '
                        'reuniendo a cientos de parejas de todo el país que compiten '
                        'en diferentes categorías. Incluye pasacalles, exhibición de '
                        'caballos de paso y actividades culturales paralelas.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),

                  const Text(
                    'Ubicación',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Mini mapa clickeable
                  GestureDetector(
                    onTap: _abrirMapa,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppTheme.primario.withOpacity(0.3)),
                      ),
                      child: Stack(
                        children: [
                          const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.map,
                                    size: 40, color: Colors.grey),
                                SizedBox(height: 8),
                                Text(
                                  'Coliseo Gran Chimú, Trujillo',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppTheme.primario,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Abrir en Maps',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Botones acción
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _abrirMapa,
                          icon: const Icon(Icons.map_outlined),
                          label: const Text('Cómo llegar'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.primario,
                            side: const BorderSide(
                                color: AppTheme.primario),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            setState(() => _guardado = !_guardado);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  _guardado
                                      ? '✅ Evento guardado'
                                      : 'Evento eliminado de guardados',
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          icon: Icon(
                            _guardado
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: Colors.white,
                          ),
                          label: Text(
                            _guardado ? 'Guardado' : 'Guardar',
                            style: const TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _guardado
                                ? Colors.green
                                : AppTheme.primario,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String texto, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        texto,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _infoRow(IconData icono, String label, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icono, size: 18, color: AppTheme.primario),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const Spacer(),
          Text(
            valor,
            style: const TextStyle(
                fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: Colors.grey.shade200,
    );
  }
}