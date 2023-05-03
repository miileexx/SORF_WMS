import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:sorfwms/Services/servicio_services.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/ConsultaServicio.dart';
import 'package:sorfwms/models/ServicioParam.dart';
import 'package:sorfwms/utilities/logging.dart';

class IniciaServicioServices extends ChangeNotifier{

  final _log = logger;

  Future IniciaServicio(ServicioParam parametros) async {
    try{
    
      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiOperaciones}/servicio/iniciaServicio");
      
      var headers = {
        HttpHeaders.contentTypeHeader: "application/json",
        'Authorization': 'Bearer ${Ajustes.Token}',
      };
      
      var body = '{ "nFolioServicio": ${parametros.nFolioServicio} }';

      http.Response response = await http.post(url, headers: headers, body: body);

      if(response.statusCode == 200){
        var res = jsonDecode(response.body);
        
        return res!;
      }
      else if(response.statusCode == 401){
        Ajustes.TokenExpired = true;
        notifyListeners();
      } else {
        throw response.statusCode;
      }

    }
    catch(e){   
      _log.e('Error al actualizar el folio de servicio, $e');
      throw Exception();      
    }
  }

}
