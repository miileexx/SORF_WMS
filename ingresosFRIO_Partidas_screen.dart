import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/Fotografias.dart';
import '../widgets/BackgroundPurple.dart';
import '../widgets/bottomNavigationFotos.dart';
import '../widgets/buttomNavServicio.dart';
import '../widgets/buttonActionCamara.dart';
import '../widgets/buttonNavigationPartidas.dart';
import '../widgets/cardContainer.dart';
import '../widgets/regresoRutaScreen.dart';

class Partidas extends StatelessWidget {
  const Partidas ({super.key});

  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BackgroundScreen(
        name: "Confirmar ingreso",
        child: Stack( 
          children: [
            SingleChildScrollView(
              child: Column(
                children: [ 
                  SizedBox(height: size.height*0.18),
                  CardContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: confirmaIngreso(),
                    )
                  ),
                ],
              ),
            ),
        
            RegresoRutaScreen(context, '/ingresosFrio'),
            //SiguienteRutaScreen(context, '/insumo'),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_sharp),
        onPressed: () async {
          final ImagePicker _picker = ImagePicker();
          final XFile? photo = await _picker.pickImage(
              source: ImageSource.camera,
              imageQuality: 50,
              maxHeight: 1080,
              maxWidth: 720,
              preferredCameraDevice: CameraDevice.rear);
          if (photo == null) {
            return;
          }
          //providerFoto.agregarFotos(Fotografias(folioServicio: providerFoto.folioServicio, tipoFoto: providerFoto.tipoFoto, file: photo));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavigationPartidas(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}

class confirmaIngreso extends StatelessWidget {
  const confirmaIngreso({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          child: Container(
           
            child: Column(
              children: [
                Text('Scan: ', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                Row(crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      SizedBox(
                        width: 300,
                        child: TextFormField( decoration: InputDecoration(border: OutlineInputBorder()), )),
                        SizedBox(width: 20,),
                      Ink(decoration: ShapeDecoration( color: Colors.blue,shape: CircleBorder()),
                        child: IconButton(
                        onPressed: null, 
                        icon:Icon(Icons.done,color: Colors.black87,))),
                            ],
                 ),
                 SingleChildScrollView(
                  child: Column(
                    children: [
                         Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Partida 1'),
                    subtitle: Text('Descripción y Confirmación'),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    ListTile(
                      title: Text('Partida 2'),
                      subtitle: Text('Descripción y Confirmación'),
                    ),
                  ],
                ),
              ),
              Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Partida 3'),
                    subtitle: Text('Descripción y Confirmación'),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Partida 4'),
                    subtitle: Text('Descripción y Confirmación'),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Partida 5'),
                    subtitle: Text('Descripción y Confirmación'),
                  ),
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('Partida 6'),
                    subtitle: Text('Descripción y Confirmación'),
                  ),
                ],
              ),
            ),
                    ],
                  )
                    ),
                
              ],
            ),
          ),
        ),
      ),
      
    );
  }
}

   