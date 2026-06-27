import 'package:flutter/material.dart';
import 'package:app_trujillo/core/theme/app_theme.dart';
import 'package:app_trujillo/core/router/app_router.dart';
import 'package:app_trujillo/features/eventos/screens/turismo_screen.dart';
import 'package:app_trujillo/features/auth/screens/perfil_screen.dart';
import 'package:app_trujillo/features/mapa/screens/mapa_screen.dart';
import 'package:app_trujillo/features/eventos/models/evento_model.dart';
import 'package:app_trujillo/features/eventos/services/eventos_json_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _paginaActual = 0;
  CategoriaEvento? _categoriaSeleccionada;
  late Future<List<Map<String, dynamic>>> _eventosFuture;

  final EventosJsonService _eventosService = EventosJsonService();

  final List<Map<String, dynamic>> _categorias = [
    {'nombre': 'Todos', 'icono': '🎯', 'valor': null},
    {'nombre': 'Cultural', 'icono': '🎭', 'valor': 'cultural'},
    {'nombre': 'Danza', 'icono': '💃', 'valor': 'danza'},
    {'nombre': 'Teatro', 'icono': '🎬', 'valor': 'teatro'},
    {'nombre': 'Música', 'icono': '🎶', 'valor': 'musica'},
    {'nombre': 'Turismo', 'icono': '🗺️', 'valor': 'turistico'},
    {'nombre': 'Arte', 'icono': '🎨', 'valor': 'arte'},
    {'nombre': 'Taller', 'icono': '🛠️', 'valor': 'taller'},
  ];

  @override
  void initState() {
    super.initState();
    _eventosFuture = _eventosService.obtenerEventos();
  }

  List<Map<String, dynamic>> _filtrarEventos(List<Map<String, dynamic>> eventos) {
    if (_categoriaSeleccionada == null) return eventos;
    return eventos
        .where((e) => e['categoria'] == _categoriaSeleccionada!.name)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondo,
      body: IndexedStack(
        index: _paginaActual,
        children: [
          _buildPaginaInicio(),
          const MapaScreen(),
          const TurismoScreen(),
          const PerfilScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _paginaActual,
        onDestinationSelected: (index) => setState(() => _paginaActual = index),
        backgroundColor: Colors.white,
        indicatorColor: AppTheme.primario.withValues(alpha: 0.15),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppTheme.primario),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.map_outlined),
            selectedIcon: Icon(Icons.map, color: AppTheme.primario),
            label: 'Mapa',
          ),
          NavigationDestination(
            icon: Icon(Icons.location_city_outlined),
            selectedIcon: Icon(Icons.location_city, color: AppTheme.primario),
            label: 'Turismo',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person, color: AppTheme.primario),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _buildPaginaInicio() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _eventosFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'No se pudieron cargar los eventos.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final eventosFiltrados = _filtrarEventos(snapshot.data ?? []);

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: true,
              snap: true,
              backgroundColor: AppTheme.primario,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: AppTheme.primario,
                  padding: const EdgeInsets.fromLTRB(16, 45, 16, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Trujillo Cultural 🎭',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Buscar eventos...',
                            hintStyle: TextStyle(fontSize: 13),
                            prefixIcon: Icon(Icons.search, size: 18),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: _categorias.length,
                  itemBuilder: (context, index) {
                    final cat = _categorias[index];
                    final seleccionado = _categoriaSeleccionada?.name == cat['valor'];
                    return GestureDetector(
                      onTap: () => setState(() {
                        _categoriaSeleccionada = cat['valor'] == null
                            ? null
                            : CategoriaEvento.values.firstWhere(
                                (e) => e.name == cat['valor'],
                              );
                      }),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: seleccionado ? AppTheme.primario : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: seleccionado ? AppTheme.primario : Colors.grey.shade300,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(cat['icono'], style: const TextStyle(fontSize: 14)),
                            const SizedBox(width: 4),
                            Text(
                              cat['nombre'],
                              style: TextStyle(
                                fontSize: 12,
                                color: seleccionado ? Colors.white : Colors.black87,
                                fontWeight: seleccionado ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Text(
                  'Eventos destacados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (eventosFiltrados.isEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Center(child: Text('No hay eventos para esta categoría.')),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildTarjetaEvento(eventosFiltrados[index]),
                    childCount: eventosFiltrados.length,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildTarjetaEvento(Map<String, dynamic> evento) {
    final colores = {
      'cultural': AppTheme.primario,
      'danza': const Color(0xFFAD1457),
      'teatro': const Color(0xFF4527A0),
      'musica': const Color(0xFF6A1B9A),
      'turistico': const Color(0xFF1565C0),
      'arte': const Color(0xFF00838F),
      'taller': const Color(0xFF558B2F),
    };
    final color = colores[evento['categoria']] ?? AppTheme.primario;
    final esGratuito = evento['esGratuito'] == true;

    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.detalle,
        arguments: evento['id'] ?? 1,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 6,
              decoration: BoxDecoration(
                color: color,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          evento['titulo'].toString(),
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          esGratuito ? 'Gratuito' : 'S/ ${evento['precio']}',
                          style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          evento['fecha'].toString(),
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.location_on, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          evento['lugar'].toString(),
                          style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          evento['tipo'].toString().toUpperCase(),
                          style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 12, color: Colors.grey.shade400),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
