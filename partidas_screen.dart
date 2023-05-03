import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../models/Fotografias.dart';
import '../widgets/bottomNavigationFotos.dart';
import '../widgets/buttonNavigationPartidas.dart';

class Partidas extends StatelessWidget {
  const Partidas ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          60.0,
        ),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/ingresosFrio");
            },
          ),
          title: Text("Confirmar Ingreso"),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Align(
          child: Container(
            padding: EdgeInsets.all(20),
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