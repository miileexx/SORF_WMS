import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/Services/fotografia_service.dart';
import 'package:sorfwms/models/Fotografias.dart';
import 'package:sorfwms/utilities/constants.dart';

class BottomNavigationPartidas extends StatelessWidget {

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;
  
  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];


  const BottomNavigationPartidas({super.key, required this.fabLocation, this.shape});

  @override
  Widget build(BuildContext context) {

    final providerFoto = Provider.of<FotografiaServices>(context);

    return BottomAppBar(
      shape: shape,
      color: Primarycolor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon( Icons.add ,color: Colors.white),
                          Text('Añadir matriculas', style: TextStyle(color: Colors.white),)
                        ],              
                      )
              ,onPressed: () {
                Navigator.pushReplacementNamed(context, "/subPartidas");
              },
              ),
            ),
           
            if (centerLocations.contains(fabLocation)) const Spacer(),            
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(                
              // ignore: sort_child_properties_last
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  providerFoto.isLoading ? const CircularProgressIndicator() : const Icon( Icons.post_add_rounded ,color: Colors.white),
                  Text( providerFoto.isLoading ? 'Cargando':'Editar/Añadir partidas', style: const TextStyle(color: Colors.white),)
                ],
              ),
              onPressed:  () { 
               Navigator.pushReplacementNamed(context, "/detallePartida");
              },                          
              ),
            ),
          ],
        ),
      ),
    );
  }
}