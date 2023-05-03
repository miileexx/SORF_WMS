import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorfwms/main.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/utilities/preferencias.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context){
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/images/userImage.png",
                fit: BoxFit.cover,
                width: 90,
                height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage('https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'),
              ),
            ), accountEmail: null, accountName: null,
          ),
          ListTile(
            leading: const Icon(Icons.scanner),
            title: const Text('Escáner'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> MyApp())),
          ),
          ListTile(
            leading: const Icon(Icons.photo_size_select_large_outlined),
            title: const Text('Firma'),
            onTap: () => {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            // ignore: avoid_returning_null_for_void
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Policies'),
            // ignore: avoid_returning_null_for_void
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            title: const Text('Exit'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () async {    
              SharedPreferences preferences = await SharedPreferences.getInstance();
              String URL = Ajustes.URL;
              String Catalogos = Ajustes.ApiCatalogos;
              String Operaciones = Ajustes.ApiOperaciones;
              String Autenticacion = Ajustes.APIAutenticacion;
              
              preferences.clear();
              
              Ajustes.URL = URL;
              Ajustes.APIAutenticacion = Autenticacion;
              Ajustes.ApiCatalogos = Catalogos;
              Ajustes.ApiOperaciones = Operaciones
              ;
             Navigator.pushReplacementNamed(context, "/login");
            },
          ),
        ],
      ),
    );
  }
}