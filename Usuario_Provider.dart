import 'package:flutter/material.dart';
import 'package:sorfwms/models/usuarioResponse_model.dart';

class UsuarioProvider extends ChangeNotifier{

    GlobalKey<FormState> formkey = new GlobalKey<FormState>();
  
    UsuarioResponse ususario = new UsuarioResponse(success: false);

    UsuarioProvider(
      this.ususario
    );

}