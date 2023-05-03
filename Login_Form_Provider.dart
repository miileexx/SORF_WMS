import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier{

    GlobalKey<FormState> formkey = new GlobalKey<FormState>();

    String User = "";
    String Pass = "";
    String Almacen = ""; 

    LoginFormProvider(
      this.User,
      this.Pass,
      this.Almacen
    );

}