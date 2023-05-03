import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/Services/fotografia_service.dart';
import 'package:sorfwms/widgets/regresoRutaScreen.dart';
/*
class CamaraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CamaraScreen({super.key, required this.cameras}); 

  @override
  CamaraScreenState createState() => CamaraScreenState();
}

class CamaraScreenState extends State<CamaraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fotoprovider = Provider.of<FotografiaServices>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 600,
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SizedBox(height: 20,),
            RegresoRutaScreen(context, '/fotografia')
           
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        onPressed: () async { 
          try {
            await _initializeControllerFuture;
            //final path = '${(await getTemporaryDirectory()).path}/${DateTime.now()}.png';
            final Fotitos = await _controller.takePicture();
            //fotoprovider.ListaFotografia.add(Fotitos);
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
*/