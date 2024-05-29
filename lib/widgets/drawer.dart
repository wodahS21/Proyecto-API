import 'package:flutter/material.dart';
import 'package:poketcg/Services/auth_services.dart';
import 'package:provider/provider.dart';

class DrawerHome extends StatelessWidget {
  const DrawerHome({super.key});

  @override
  void _logout(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await authService.logout();
    Navigator.pushReplacementNamed(context, 'login');
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 71, 71, 71)),
            child: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () => Navigator.pushNamed(context, '/favorites')),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Cerrar sesión'),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
