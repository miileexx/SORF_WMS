
import 'package:flutter/material.dart';


Future Alerta(context, String titulo, String mensaje) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(titulo),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(mensaje),
            ],
          ),
        ),
        actions: [          
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