import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Firmas_Provider.dart';
import 'package:sorfwms/providers/Login_Form_Provider.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';

class FirmaPreview extends StatelessWidget {

  final Uint8List signature;
  const FirmaPreview({Key? key, required this.signature}) :super(key: key);

  @override
  Widget build(BuildContext context) {

    final consultaServicio = Provider.of<ConsultaServicioProvider>(context); 
    final loginForm = Provider.of<LoginFormProvider>(context);
    final servicios = Provider.of<ServicioProvider>(context);
    final firmas = Provider.of<FirmasProvider>(context);
    final folioServicios = servicios.FolioServicio;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/maquinaria");
              firmas.ControllerLimpio=false;
              consultaServicio.NuevaFirma=consultaServicio.servicios.detalleServicio!.firmaClienteb64!;
            },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: [
            IconButton(
              onPressed: (){
                saveSignature(context, signature,folioServicios, firmas);
              },
              icon: const Icon(Icons.save),
            ),
          ],
          centerTitle: true,
          title: const Text('Vista previa'),
        ),
        body: Center(
          child: Image.memory(signature),
        ));
  }

  Future<void> _imagenGuardada(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('SORFWMS'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('La firma se guardó correctamente.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }

  Future<void> _imagenGaleria(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('SORFWMS'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('La firma no se pudo subir, se ha guardado una copia en galería.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
  }

  Future? saveSignature(BuildContext context, signature, folioServicios, firmas) async {

  var url = Uri.http(Ajustes.URL,"${Ajustes.ApiOperaciones}/servicio/guardarFirma");

  String dataBase64 = base64.encode(signature);
  firmas.FirmaCodificada = dataBase64;

  Map data = {
        "archivo": dataBase64,
        "tarja": 0,
        "partida": 0,
        "folioServicio": folioServicios,
        "tipoFoto": 2,
        "nombre": "",
        "ruta": "", 
        "estatus": 0,
        "descripcionError": ""
  };

  var body = json.encode(data);
  var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${Ajustes.Token}',
        },
        body: body);

    if(response.statusCode==200){
      Map<String, dynamic> datos = jsonDecode(response.body);
      int estado = datos["estatus"];
      if(estado==0){
        _imagenGuardada(context);
        
      } if(estado!=0){
        final status = await Permission.storage.status;
        if (!status.isGranted) {
        await Permission.storage.request();
          final time = DateTime.now().toIso8601String().replaceAll('.', ':');
          final name = 'sorfwms_firma$time';
          final result = await ImageGallerySaver.saveImage(signature, name: name);
          _imagenGaleria(context);
    } 
  }
    }}
}