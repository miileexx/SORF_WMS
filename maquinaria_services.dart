import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/Insumo.dart';
import 'package:sorfwms/models/Maquinaria.dart';
import 'package:sorfwms/utilities/logging.dart';

class MaquinariaService extends ChangeNotifier{

    bool isLoading = true;
    List<Maquinaria> maquinarias = [];
    final int _nTipo = 0;
    final _log = logger;
    int _maquinariaSelecionada =  0;

    int get MaquinariaSelecionada{
      return _maquinariaSelecionada;
    }

    set MaquinariaSelecionada(int value){
      _maquinariaSelecionada = value;
      notifyListeners();

    }
  
    

    MaquinariaService(){
      obtenMaquinaria();
    }

   Future<List<Maquinaria>> obtenMaquinaria() async{
    try{


      var param = {
        "nIdAlmacen" : Ajustes.IdAlmacen.toString(),
        "nTipo" : _nTipo.toString()
      };

      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiCatalogos}/maquinaria/obtenMaquinaria",param);
      
      var headers = {HttpHeaders.contentTypeHeader:"application/json", HttpHeaders.authorizationHeader: "Bearer ${Ajustes.Token}" };

      http.Response response = await http.get(url,headers:headers);

      if(response.statusCode == 200){

        var resp =  maquinariaFromJson(response.body);

        maquinarias.addAll(resp);
        notifyListeners();
        return maquinarias;

      }
      else if(response.statusCode == 401){
          Ajustes.TokenExpired = true;
          isLoading = false;
          notifyListeners();
          return maquinarias;
      } 
      else {
        throw response.statusCode;
      }

    }
    catch(e){               
      _log.e('Error al consultar categorias, $e');
      throw Exception();  
    }
  }


}