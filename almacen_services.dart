import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/Almacen.dart';
import 'package:sorfwms/utilities/api.dart';
import 'package:sorfwms/utilities/logging.dart';

class AlmacenServices extends ChangeNotifier {
  final String _baseUrlCatalogos = Ajustes.URL;
  final String _baseAPICatalogos = Ajustes.ApiCatalogos;
  
  final _log = logger;

  final List<Almacen> Almacenes = [];

  AlmacenServices() {
    getAllCategory();
  }

 

  Future<List<Almacen>> getAllCategory() async {
  try { 
    if(_baseUrlCatalogos.isEmpty || _baseAPICatalogos.isEmpty){
        return Almacenes;
    }   
    var url = Uri.http(_baseUrlCatalogos, '$_baseAPICatalogos/almacen/list');

    _log.i('getAllCategory request');

    http.Response response = await http.get(url);
    
      var jsonData = almacenFromJson(response.body);
      
      _log.i('getAllCategory response');

      Almacenes.addAll(jsonData);

    } catch (e) {
      _log.e('Error al obtener el catálogo de almacen');
      throw Exception();
    }

    return Almacenes;
  }
}
