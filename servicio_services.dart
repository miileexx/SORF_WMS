
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/ConsultaServicio.dart';
import 'package:sorfwms/models/EstatusDetalleServicio.dart';
import 'package:sorfwms/models/ResumenProgramacion.dart';
import 'package:sorfwms/models/ServicioParam.dart';
import 'package:sorfwms/utilities/logging.dart';

class ServicioServices extends ChangeNotifier{

   
  ConsultaServicio servicios = new ConsultaServicio();
  List<ResumenProgramacion> ListaServicios = [];
  List<EstatusDetalleServicio> estauts = [];
  final _log = logger;

  
  Future<ConsultaServicio>Consultaservicio(ServicioParam param) async {
    try{
    
      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiCatalogos}/servicio/consultaservicio",param.toJson());
      
      var headers = {HttpHeaders.contentTypeHeader:"application/json", 'Authorization': 'Bearer ${Ajustes.Token}',};

      http.Response response = await http.get(url,headers:headers);

      if(response.statusCode == 200){
        var res = consultaServicioFromJson(response.body);
        
        notifyListeners();
        return res!;
      }
      else if(response.statusCode == 401){
        Ajustes.TokenExpired = true;
        notifyListeners();
        return servicios;
      } else {
        throw response.statusCode;
      }

    }
    catch(e){   
      _log.e('Error al actualizar el folio de servicio, $e');
      throw Exception();      }
  }

  Future<List<ResumenProgramacion>> ConsultaServiciosByUsuario(ServicioByUsuarioParam param) async{
    try{

      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiCatalogos}/servicio/consultaServiciosByUsuario",param.toJson());
      
      var headers = {HttpHeaders.contentTypeHeader:"application/json", 'Authorization': 'Bearer ${Ajustes.Token}',};

      http.Response response = await http.get(url,headers:headers);

      if(response.statusCode == 200){
         ListaServicios =  resumenProgramacionFromJson(response.body);

        return ListaServicios;

      } 
      else if(response.statusCode == 401){
        Ajustes.TokenExpired = true;
        notifyListeners();
        return ListaServicios;
      } else {
        throw response.statusCode;
      }
    }
    catch(e){      
       _log.e('Error al consultaar los servicios $e');
      throw Exception();
    }
  }

  Future actualizaFolioServicio(DetalleServicio servicio) async{    
    try{      
      notifyListeners();

      List<DetalleServicio> envio = [];
      envio.add(servicio);      
      var url = Uri.http(Ajustes.URL, '${Ajustes.ApiOperaciones}/servicio/actualizaFolioServicio');
      
      var body = servicio.listaDetalleServicioToJson(envio);

      var headers = {HttpHeaders.contentTypeHeader:"application/json", 'Authorization': 'Bearer ${Ajustes.Token}',};

      http.Response response = await http.post(url,body:body,headers:headers);
      
        if(response.statusCode == 200){
            
            estauts = estatusDetalleServicioFromJson(response.body);
            notifyListeners();
            return estauts;
        }
        else if(response.statusCode == 401){
          Ajustes.TokenExpired = true;
          notifyListeners();
          return estauts;
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