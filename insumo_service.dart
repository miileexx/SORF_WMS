import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/Insumo.dart';
import 'package:sorfwms/utilities/logging.dart';
class InsumoService extends ChangeNotifier{

    bool isLoading = true;
    bool isSaving = false;
    List<Insumo> Insumos = [];
    final _log = logger;



  InsumoService(){
    obtenInsumos(Ajustes.IdAlmacen.toString());
  }
  

   Future<List<Insumo>> obtenInsumos(String id) async{
    isLoading = true;
     try{

      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiCatalogos}/insumo/obtenInsumos",{"id" : id});
      
      var headers = {HttpHeaders.contentTypeHeader:"application/json", HttpHeaders.authorizationHeader: "Bearer ${Ajustes.Token}" };

      http.Response response = await http.get(url,headers:headers);
 
      if(response.statusCode == 200){

       var res = insumoFromJson(response.body);

       Insumos.addAll(res);

        isLoading = false;
        notifyListeners();
        
       return Insumos;

      } 
      else if(response.statusCode == 401){
        Ajustes.TokenExpired = true;
        notifyListeners();
        return Insumos;
      } 
      else{
        throw response.statusCode;
      }

    }
    catch(e){    

      _log.e('Error al consultar insumo, $e');
      throw Exception();  
    
    }




   } 


}