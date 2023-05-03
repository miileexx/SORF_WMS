import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sorfwms/main.dart';
import 'package:sorfwms/utilities/constants.dart';

class PreferenciasUsuario extends StatelessWidget {
  const PreferenciasUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Primarycolor,
              ),
              child: Text('SORF2 WMS DEMO')),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, 'setting');
            },
          ),
          ListTile(
            leading: Icon(Icons.file_present),
            title: const Text('Bitácora'),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
