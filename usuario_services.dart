import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/usuarioResponse_model.dart';
import 'package:sorfwms/utilities/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioServices extends ChangeNotifier {
  Future<UsuarioResponse> login(
      String Usuario, String Password, String Almacen) async {
    try {
      var url = Uri.http(
          Ajustes.URL, "${Ajustes.APIAutenticacion}/login/autenticaUsuario");

      var response = await http.post(url,
          headers: {"Accept": "application/json"},
          body: ({
            'sUser': Usuario.toString().trim(),
            'sPwd': Password.toString().trim(),
            'nIdAlmacen': Almacen
          }));

      if (response.statusCode == 200) {
        UsuarioResponse _data = UsuarioResponseFromJson(response.body);
        saveSharedPrefences(_data, Almacen);
        return _data;
      }

      return new UsuarioResponse(success: false);
    } catch (e) {
      print(e);
      return new UsuarioResponse(success: false);
    }
  }

  saveSharedPrefences(UsuarioResponse _usuarioResponse, String _almacen) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Ajustes.TokenExpired = false;
    preferences.setInt("idUsuario", _usuarioResponse.idUsuario?.toInt() ?? 0);
    preferences.setString("token", _usuarioResponse.token?.toString() ?? '');
    preferences.setString(
        "nombreCompleto", _usuarioResponse.nombreCompleto?.toString() ?? '');
    preferences.setInt("idAlmacen", int.parse(_almacen));
  }
}
