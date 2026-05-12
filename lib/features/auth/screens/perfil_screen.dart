import 'package:flutter/material.dart';
import 'package:app_trujillo/core/theme/app_theme.dart';
import 'package:app_trujillo/core/router/app_router.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  bool _notificaciones = true;
  bool _eventosNearby = true;
  bool _novedades = false;
  String _idioma = 'Español';

  final Map<String, dynamic> _usuario = {
    'nombre': 'Carlos Mendoza',
    'email': 'carlos@email.com',
    'tipo': 'Ciudadano local',
    'emoji': '👤',
    'eventosGuardados': 5,
    'eventosAsistidos': 12,
    'resenas': 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.fondo,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header perfil
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: AppTheme.primario,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 56, 20, 24),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Center(
                      child: Text('👤', style: TextStyle(fontSize: 40)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _usuario['nombre'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _usuario['email'],
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _usuario['tipo'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Estadísticas
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _statItem(
                          '${_usuario['eventosGuardados']}', 'Guardados'),
                      _dividerVertical(),
                      _statItem(
                          '${_usuario['eventosAsistidos']}', 'Asistidos'),
                      _dividerVertical(),
                      _statItem('${_usuario['resenas']}', 'Reseñas'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Sección Mi cuenta
            _seccionTitulo('Mi cuenta'),
            _opcionMenu(
              icono: Icons.person_outline,
              titulo: 'Editar perfil',
              onTap: () {},
            ),
            _opcionMenu(
              icono: Icons.bookmark_outline,
              titulo: 'Eventos guardados',
              badge: '${_usuario['eventosGuardados']}',
              onTap: () {},
            ),
            _opcionMenu(
              icono: Icons.history,
              titulo: 'Historial de eventos',
              onTap: () {},
            ),
            _opcionMenu(
              icono: Icons.star_outline,
              titulo: 'Mis reseñas',
              onTap: () {},
            ),

            const SizedBox(height: 8),

            // Sección Notificaciones
            _seccionTitulo('Notificaciones'),
            _opcionSwitch(
              icono: Icons.notifications_outlined,
              titulo: 'Notificaciones generales',
              valor: _notificaciones,
              onChanged: (v) => setState(() => _notificaciones = v),
            ),
            _opcionSwitch(
              icono: Icons.location_on_outlined,
              titulo: 'Eventos cercanos a mí',
              valor: _eventosNearby,
              onChanged: (v) => setState(() => _eventosNearby = v),
            ),
            _opcionSwitch(
              icono: Icons.campaign_outlined,
              titulo: 'Novedades y festivales',
              valor: _novedades,
              onChanged: (v) => setState(() => _novedades = v),
            ),

            const SizedBox(height: 8),

            // Sección Preferencias
            _seccionTitulo('Preferencias'),
            _opcionMenu(
              icono: Icons.language,
              titulo: 'Idioma',
              subtitulo: _idioma,
              onTap: () => _mostrarSelectorIdioma(),
            ),
            _opcionMenu(
              icono: Icons.color_lens_outlined,
              titulo: 'Apariencia',
              subtitulo: 'Claro',
              onTap: () {},
            ),
            _opcionMenu(
              icono: Icons.help_outline,
              titulo: 'Ayuda y soporte',
              onTap: () {},
            ),
            _opcionMenu(
              icono: Icons.info_outline,
              titulo: 'Acerca de la app',
              subtitulo: 'v1.0.0',
              onTap: () {},
            ),

            const SizedBox(height: 8),

            // Cerrar sesión
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: _cerrarSesion,
                  icon: const Icon(Icons.logout, color: AppTheme.error),
                  label: const Text(
                    'Cerrar sesión',
                    style: TextStyle(
                      color: AppTheme.error,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _cerrarSesion() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, AppRouter.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.error,
            ),
            child: const Text(
              'Cerrar sesión',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _mostrarSelectorIdioma() {
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
            const Text(
              'Seleccionar idioma',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _idiomaOpcion('🇵🇪', 'Español'),
            _idiomaOpcion('🇺🇸', 'English'),
            _idiomaOpcion('🇧🇷', 'Português'),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _idiomaOpcion(String bandera, String idioma) {
    final seleccionado = _idioma == idioma;
    return ListTile(
      leading: Text(bandera, style: const TextStyle(fontSize: 24)),
      title: Text(idioma),
      trailing: seleccionado
          ? const Icon(Icons.check_circle, color: AppTheme.primario)
          : null,
      onTap: () {
        setState(() => _idioma = idioma);
        Navigator.pop(context);
      },
    );
  }

  Widget _seccionTitulo(String titulo) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          titulo,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _opcionMenu({
    required IconData icono,
    required String titulo,
    String? subtitulo,
    String? badge,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppTheme.primario.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icono, color: AppTheme.primario, size: 20),
        ),
        title: Text(
          titulo,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        subtitle: subtitulo != null
            ? Text(subtitulo,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade500))
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (badge != null)
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.primario,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ),
            const SizedBox(width: 4),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  Widget _opcionSwitch({
    required IconData icono,
    required String titulo,
    required bool valor,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppTheme.primario.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icono, color: AppTheme.primario, size: 20),
        ),
        title: Text(
          titulo,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        trailing: Switch(
          value: valor,
          onChanged: onChanged,
          activeColor: AppTheme.primario,
        ),
      ),
    );
  }

  Widget _statItem(String valor, String label) {
    return Column(
      children: [
        Text(
          valor,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _dividerVertical() {
    return Container(
      height: 30,
      width: 1,
      color: Colors.white.withOpacity(0.3),
    );
  }
}