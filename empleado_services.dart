import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/Empleado.dart';
import 'package:sorfwms/utilities/logging.dart';

class EmpleadoService extends ChangeNotifier{

    List<Empleado> Empleados = [];
    double nFolioServicio = 0;
    bool isLoading = true;
    final _log = logger;


    EmpleadoService(){
      obtenEmpleados();
    }

   Future<List<Empleado>> obtenEmpleados() async{
    try{

      var param = {
        "nIdAlmacen" : Ajustes.IdAlmacen.toString(),
        "nFolioServicio" : nFolioServicio.toString()
      };

      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiCatalogos}/empleado/obtenempleado",param);
      
      var headers = {HttpHeaders.contentTypeHeader:"application/json", HttpHeaders.authorizationHeader: "Bearer ${Ajustes.Token}" };

      http.Response response = await http.get(url,headers:headers);

      if(response.statusCode == 200){
        List<Empleado> resp  = empleadoFromJson(response.body);

        Empleados.addAll(resp);
        isLoading = false;
        notifyListeners();
        return Empleados;
      }
      else if(response.statusCode == 401){
        Ajustes.TokenExpired = true;
        notifyListeners();
        return Empleados;
      } 
      else {
        throw response.statusCode;
      }

    }
    catch(e){     
      
      _log.e('Error al consultar insumo, $e');
      throw Exception();  
    
    }
  }

}