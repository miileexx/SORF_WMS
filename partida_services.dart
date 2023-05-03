
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/EstatusRespuesta.dart';
import 'package:sorfwms/models/Matricula.dart';
import 'package:sorfwms/models/ParametrosUbicar.dart';
import 'package:sorfwms/utilities/logging.dart';

class PartidaService extends ChangeNotifier{
    bool isLoading = true;
    bool isSaving = false;
    List<Matricula> Matriculas = [];
    EstatusRespuesta respuesta = EstatusRespuesta(estatus: 0, descripcionError: "");

    final _log = logger;


    Future ObtenMatriculasPrevio(double folioServicio) async{
     try{

      final parametros = {
        "nFolioServicio" :folioServicio.toString() ,
        "IdAlmacen":Ajustes.IdAlmacen.toString()
      };

      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiCatalogos}/partida/ObtenMatriculasPrevio",parametros);
      
      var headers = {HttpHeaders.contentTypeHeader:"application/json", HttpHeaders.authorizationHeader: "Bearer ${Ajustes.Token}" };

      http.Response response = await http.get(url,headers:headers);
 
      if(response.statusCode == 200){

        Matriculas = matriculaFromJson(response.body);
        notifyListeners();
        return Matriculas;

      } 
      else if(response.statusCode == 401){
        Ajustes.TokenExpired = true;
        notifyListeners();
        return Matriculas;
      } 
      else{
        throw response.statusCode;
      }

    }
    catch(e){    

      _log.e('Error al consultar Matricula, $e');
      throw Exception();  
    
    }

   } 

    Future<List<Matricula>> GuardarPosicion(ParametrosUbicar param) async{
      try{        
      Matriculas=[];
      
      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiOperaciones}/partida/SetPosicion");
      
      var headers = {HttpHeaders.contentTypeHeader:"application/json", HttpHeaders.authorizationHeader: "Bearer ${Ajustes.Token}" };
          
      String body = parametrosUbicarToJson(param); 
      
      http.Response response = await http.post(url,body:body,headers:headers);

      if(response.statusCode == 200){
          Matriculas = matriculaFromJson(response.body);
          return Matriculas;
        }
        else if(response.statusCode == 401){
          Ajustes.TokenExpired = true;
          notifyListeners();
          return Matriculas;
        } else {
          throw response.statusCode;
        }
  
      }catch(e){
        _log.e('Error al GuardarPosicion, $e');
        throw Exception();  
      }
    }

    Future<EstatusRespuesta> SetInicioRecoleccionPrevio(double folioServicio) async{
    try{        
        
      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiOperaciones}/servicio/inicioRecoleccionPrevio",{"nFolioServicio" :folioServicio.toString()});
      
      var headers = {HttpHeaders.contentTypeHeader:"application/json", HttpHeaders.authorizationHeader: "Bearer ${Ajustes.Token}" };

      http.Response response = await http.post(url,headers:headers);

      if(response.statusCode == 200){
          respuesta = estatusRespuestaFromJson(response.body);
          return respuesta;
        }
        else if(response.statusCode == 401){
          Ajustes.TokenExpired = true;
          notifyListeners();
          return respuesta;

        } else {
          
          throw response.statusCode;
        }
  
      }catch(e){
        _log.e('Error al GuardarPosicion, $e');
        throw Exception();  
      }
    }



}
