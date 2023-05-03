import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/Services/fotografia_service.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';

class ButtonCamaraServicio extends StatelessWidget {
  const ButtonCamaraServicio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);    
    final providerFoto = Provider.of<FotografiaServices>(context);


    return FloatingActionButton(
      onPressed: () {
        var servicioAnterior = providerFoto.folioServicio;
        providerFoto.folioServicio = consultaServicio.servicios.detalleServicio!.folioServicio!.toString();
        providerFoto.tarja = consultaServicio.servicios.tarja?.tarja??0;
        providerFoto.busquedaServicio = false;

        if(servicioAnterior != providerFoto.folioServicio){
          providerFoto.ListaFotografia.clear();
        }
        Navigator.pushReplacementNamed(context, "/fotografia");
      },
      child: Icon(Icons.camera_alt_outlined),
    );
  }
}