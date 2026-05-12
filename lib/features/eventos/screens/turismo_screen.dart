import 'package:flutter/material.dart';
import 'package:app_trujillo/core/theme/app_theme.dart';

class TurismoScreen extends StatefulWidget {
  const TurismoScreen({super.key});

  @override
  State<TurismoScreen> createState() => _TurismoScreenState();
}

class _TurismoScreenState extends State<TurismoScreen> {
  int _categoriaSeleccionada = 0;

  final List<String> _categorias = [
    'Todos',
    'Arqueológico',
    'Museos',
    'Playas',
    'Gastronomía',
    'Naturaleza',
  ];

  final List<Map<String, dynamic>> _atractivos = [
    {
      'nombre': 'Chan Chan',
      'tipo': 'Arqueológico',
      'descripcion':
      'Ciudad de barro más grande de América precolombina. Patrimonio Mundial UNESCO.',
      'distancia': '5 km del centro',
      'horario': '9:00 AM - 4:00 PM',
      'entrada': 'S/ 10.00',
      'emoji': '🏛️',
      'color': 0xFF8B1A1A,
      'destacado': true,
    },
    {
      'nombre': 'Huaca del Sol y la Luna',
      'tipo': 'Arqueológico',
      'descripcion':
      'Templos de la cultura Moche con impresionantes murales polícromos.',
      'distancia': '6 km del centro',
      'horario': '9:00 AM - 4:00 PM',
      'entrada': 'S/ 15.00',
      'emoji': '🌞',
      'color': 0xFFD4A017,
      'destacado': true,
    },
    {
      'nombre': 'Plaza de Armas de Trujillo',
      'tipo': 'Histórico',
      'descripcion':
      'Centro histórico con arquitectura colonial. Catedral y casas señoriales del siglo XVII.',
      'distancia': 'Centro',
      'horario': 'Todo el día',
      'entrada': 'Gratuito',
      'emoji': '⛪',
      'color': 0xFF1565C0,
      'destacado': true,
    },
    {
      'nombre': 'Museo de Arte de Trujillo',
      'tipo': 'Museos',
      'descripcion':
      'Colección de arte colonial, republicano y contemporáneo del norte del Perú.',
      'distancia': '0.5 km del centro',
      'horario': '9:00 AM - 5:00 PM',
      'entrada': 'S/ 5.00',
      'emoji': '🎨',
      'color': 0xFF00838F,
      'destacado': false,
    },
    {
      'nombre': 'Huanchaco',
      'tipo': 'Playas',
      'descripcion':
      'Balneario famoso por sus caballitos de totora y surf. Tradición pesquera milenaria.',
      'distancia': '12 km del centro',
      'horario': 'Todo el día',
      'entrada': 'Gratuito',
      'emoji': '🏄',
      'color': 0xFF0277BD,
      'destacado': true,
    },
    {
      'nombre': 'Museo Cao',
      'tipo': 'Museos',
      'descripcion':
      'Museo dedicado a la Señora de Cao, primera gobernante mujer de América.',
      'distancia': '60 km del centro',
      'horario': '9:00 AM - 4:00 PM',
      'entrada': 'S/ 15.00',
      'emoji': '👑',
      'color': 0xFFAD1457,
      'destacado': true,
    },
    {
      'nombre': 'Cevichería El Mochica',
      'tipo': 'Gastronomía',
      'descripcion':
      'Gastronomía típica del norte: ceviche, shambar, sopa teóloga y moros y cristianos.',
      'distancia': '1 km del centro',
      'horario': '11:00 AM - 5:00 PM',
      'entrada': 'Desde S/ 20',
      'emoji': '🍽️',
      'color': 0xFFE65100,
      'destacado': false,
    },
    {
      'nombre': 'Bosque de Piedras Quilcayhuanca',
      'tipo': 'Naturaleza',
      'descripcion':
      'Formaciones rocosas naturales en los andes liberteños. Ideal para trekking.',
      'distancia': '80 km del centro',
      'horario': 'Todo el día',
      'entrada': 'S/ 5.00',
      'emoji': '🏔️',
      'color': 0xFF2E7D32,
      'destacado': false,
    },
  ];

  List<Map<String, dynamic>> get _atractivosFiltrados {
    if (_categoriaSeleccionada == 0) return _atractivos;
    final categoria = _categorias[_categoriaSeleccionada];
    return _atractivos.where((a) => a['tipo'] == categoria).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondo,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            snap: true,
            backgroundColor: AppTheme.primario,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppTheme.primario,
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 12),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Turismo en Trujillo 🗺️',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Descubre los mejores lugares',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Categorías
          SliverToBoxAdapter(
            child: SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                itemCount: _categorias.length,
                itemBuilder: (context, index) {
                  final seleccionado = _categoriaSeleccionada == index;
                  return GestureDetector(
                    onTap: () =>
                        setState(() => _categoriaSeleccionada = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: seleccionado
                            ? AppTheme.primario
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: seleccionado
                              ? AppTheme.primario
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _categorias[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: seleccionado
                                ? Colors.white
                                : Colors.black87,
                            fontWeight: seleccionado
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Destacados título
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'Atractivos turísticos',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Lista de atractivos
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  final atractivo = _atractivosFiltrados[index];
                  return _buildTarjeta(atractivo);
                },
                childCount: _atractivosFiltrados.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTarjeta(Map<String, dynamic> atractivo) {
    final color = Color(atractivo['color']);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  atractivo['emoji'],
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        atractivo['nombre'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          atractivo['tipo'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (atractivo['destacado'])
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.secundario,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        '⭐ Top',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Contenido
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  atractivo['descripcion'],
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade700,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _infoChip(
                        Icons.location_on, atractivo['distancia'], color),
                    const SizedBox(width: 8),
                    _infoChip(
                        Icons.access_time, atractivo['horario'], color),
                    const SizedBox(width: 8),
                    _infoChip(
                        Icons.attach_money, atractivo['entrada'], color),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.map_outlined,
                            size: 16, color: color),
                        label: Text(
                          'Ver en mapa',
                          style: TextStyle(color: color, fontSize: 12),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: color),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.info_outline,
                            size: 16, color: Colors.white),
                        label: const Text(
                          'Más info',
                          style: TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding:
                          const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icono, String texto, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icono, size: 11, color: color),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                texto,
                style: TextStyle(
                  fontSize: 10,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}