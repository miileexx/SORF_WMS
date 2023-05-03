
import 'package:flutter/material.dart';

Positioned SiguienteRutaScreen(BuildContext context,String routeName) {

    return Positioned(
      top: 40,
      right: 20,
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          child: IconButton(
              onPressed: () =>  Navigator.pushReplacementNamed(context, routeName),
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ))),
    );
  }