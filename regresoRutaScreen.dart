
import 'package:flutter/material.dart';

Positioned RegresoRutaScreen(BuildContext context,String routeName) {

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
              onPressed: () =>  Navigator.pushReplacementNamed(context, routeName),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ))),
    );
  }