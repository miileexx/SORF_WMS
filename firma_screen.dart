import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/providers/Firmas_Provider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:signature/signature.dart';

import 'firmaPreview_screen.dart';

class FirmaScreen extends StatefulWidget {

  @override
  State<FirmaScreen> createState() => _FirmaScreenState();
}

class _FirmaScreenState extends State<FirmaScreen> {
  late SignatureController controller;

  @override 
  void initState() {
    super.initState();

    controller = SignatureController(
      penColor: Colors.black,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){

    final consultaServicio = Provider.of<ConsultaServicioProvider>(context); 
    final firmasServicio = Provider.of<FirmasProvider>(context); 
    final firma = consultaServicio.servicios.detalleServicio!.firmaClienteb64;
    final nuevaFirma = consultaServicio.NuevaFirma;
    final firmaCodificada = firmasServicio.FirmaCodificada;

    Uint8List _bytesImage;
    _bytesImage = Base64Decoder().convert(firma!);
    final snackBar = SnackBar(content: Text('Inserta tu firma para continuar.'));

    Uint8List _bytesImage2;
    _bytesImage2 = Base64Decoder().convert(nuevaFirma!);

    Uint8List _bytesImage3;
    _bytesImage3 = Base64Decoder().convert(firmaCodificada!);

    bool padFirmas = firmasServicio.ControllerLimpio;
    
    return Scaffold(
    backgroundColor: Colors.white,
    appBar: PreferredSize(preferredSize: const Size.fromHeight(60.0,
      ),
        child: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () { Navigator.pushReplacementNamed(context, "/maquinaria"); },),
        title: Text(
          "Firmas",
          style: GoogleFonts.barlow(
              textStyle: const TextStyle(fontSize: 20, color: Colors.black)),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
    ),
    body: Container(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
      children: <Widget>[
        const SizedBox(
          height: 50,
          width: 50,
        ),
        firma ==""&&firmaCodificada=="" ?Container(
          child: Signature(
          width: 280,
          height: 270,
          controller: controller,
          backgroundColor: HexColor('#E0E0E0'),
            ),
          ):firmaCodificada!=''? Image.memory(_bytesImage3) : nuevaFirma==firma ? Image.memory(_bytesImage2): Image.memory(_bytesImage),
          SizedBox(
            height: 20,
            width: 20,
          ),
          firma==""&&firmaCodificada==""?Row(
            children: <Widget>[
              Container(
                child: buildClear(),
                width: 190,
              ),
              Container(
                width: 100,
                child: FloatingActionButton(
                  backgroundColor: Colors.green[400],
                  heroTag: 'Validar',
                  onPressed: () async {
                    if (controller.isNotEmpty) {
                      final signature = await exportSignature();
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) =>
                              FirmaPreview(signature: signature!)),
                        ),
                      );
                      controller.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Icon(Icons.check),
                ),
              ),
            ],
          ):Row(
            children: <Widget>[
              Container(
                width: 200,
                child: FloatingActionButton(
                  backgroundColor: Colors.red[400],
                  heroTag: 'Volver a firmar',
                  onPressed: () {
                    firmasServicio.ControllerLimpio=true;
                  },
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
              Container(
                width: 100,
                child: FloatingActionButton(
                  backgroundColor: Colors.green[400],
                  heroTag: 'Validar',
                  onPressed: () async {
                    Navigator.pushReplacementNamed(context, "/home");
                  },
                  child: Icon(Icons.check),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
            width: 10,
          ),
          padFirmas==true ? Row(
           children: <Widget>[
            SizedBox(
              height: 40,
              width: 35,
            ),
            Signature(
              width: 280,
              height: 270,
              controller: controller,
              backgroundColor: HexColor('#E0E0E0'),
            ),
           ], 
          ): Container(),
          SizedBox(
            height: 10,
            width: 10,
          ),
          padFirmas== true ? Row(
            children: <Widget>[
              Container(
                child: buildClear(),
                width: 210,
              ),
              Container(
                width: 100,
                child: FloatingActionButton(
                  backgroundColor: Colors.green[400],
                  heroTag: 'Validar',
                  onPressed: () async {
                    if (controller.isNotEmpty) {
                      final signature = await exportSignature();
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) =>
                              FirmaPreview(signature: signature!)),
                        ),
                      );
                      controller.clear();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Icon(Icons.check),
                ),
              ),
            ],
          ): Container(),
        ],
      ),
        ),
      )
      )
    );
  }

  Future<Uint8List?> exportSignature() async {
  final exportController = SignatureController(
    penStrokeWidth: 2,
    exportBackgroundColor: Colors.white,
    penColor: Colors.black,
    points: controller.points,
  );

  final signature = exportController.toPngBytes();
  exportController.dispose();
  return signature;
}

  buildClear() => FloatingActionButton(
    backgroundColor: Colors.red[600],
    heroTag: 'Borrar',
    child: Icon(Icons.clear, color: Colors.white),
    onPressed: () => controller.clear(),
  );
}