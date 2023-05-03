import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/Puesto.dart';
import 'package:sorfwms/utilities/logging.dart';

class PuestoService extends ChangeNotifier{

    List<Puesto> Puestos = [];
    bool isLoading = true;
    final _log = logger;


    PuestoService(){
      obtenPuestos();
    }

   Future<List<Puesto>> obtenPuestos() async{
    try{
      isLoading = true;
    
      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiCatalogos}/empleado/obtenCategorias");
      
      var headers = {HttpHeaders.contentTypeHeader:"application/json", HttpHeaders.authorizationHeader: "Bearer ${Ajustes.Token}" };

      http.Response response = await http.get(url,headers:headers);

      if(response.statusCode == 200){
        List<Puesto> resp  = puestoFromJson(response.body);
        Puestos.addAll(resp);
          isLoading = false;
          notifyListeners();
        return Puestos;
      } 
      else if(response.statusCode == 401){
          Ajustes.TokenExpired = true;
          isLoading = false;
          notifyListeners();
          return Puestos;
        } else {
        throw response.statusCode;
      }

    }
    catch(e){               
      _log.e('Error al consultar categorias, $e');
      throw Exception();  
    }
  }

}