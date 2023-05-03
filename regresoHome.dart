
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';

Positioned regresarRutaHome(BuildContext context) {
  final consultaServicio = Provider.of<ConsultaServicioProvider>(context);
    return Positioned(
      top: 40,
      left: 20,
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          child: IconButton(
              onPressed: () {
                consultaServicio.ingreso = false;
                Navigator.pushReplacementNamed(context, "/home");
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ))),
    );
  }