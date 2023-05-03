import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/Fotografias.dart';
import 'package:sorfwms/models/TipoFoto.dart';
import 'package:sorfwms/utilities/logging.dart';

class FotografiaServices extends ChangeNotifier {
  
  List<Fotografias> ListaFotografia = [];  
  String folioServicio = '' ;
  double tarja = 0;
  int index = 0;
  int tipoFoto = 2;
  bool busquedaServicio = true;
  bool isLoading = false; 
  final _log = logger;
  int nConsecutivo = 0;

  int get Consecutivo{
    return nConsecutivo;
  }

  set Consecutivo(int value){
    nConsecutivo = value;
    notifyListeners();
  }


  FotografiaServices(){
      ObtenUltimaFotografiaServicio();

  }

  String get FolioServicio{
      return folioServicio;
    }

  set FolioServicio(String value){
      folioServicio = value;
      notifyListeners();
  }

  List<TipoFoto> ListaTipoFotos = Ajustes.IdAlmacen == 2? 
  [
    TipoFoto(value: 1, descripTipoFoto: "Identificación"),
    TipoFoto(value: 2, descripTipoFoto: "Carga"),
    TipoFoto(value: 3, descripTipoFoto: "Consolidación"),
    TipoFoto(value: 4, descripTipoFoto: "Avería"),
    TipoFoto(value: 5, descripTipoFoto: "Vaciado"),
    TipoFoto(value: 6, descripTipoFoto: "Descarga")
    
  ]:[
    TipoFoto(value: 1, descripTipoFoto: "Averías"),
    TipoFoto(value: 2, descripTipoFoto: "Transporte"),
    TipoFoto(value: 3, descripTipoFoto: "1er estiba"),
    TipoFoto(value: 4, descripTipoFoto: "Identificación"),
    TipoFoto(value: 5, descripTipoFoto: "Exterior"),
    TipoFoto(value: 6, descripTipoFoto: "Sello protección"),
    TipoFoto(value: 7, descripTipoFoto: "Estibas"),
    TipoFoto(value: 8, descripTipoFoto: "Desconsolidación")
  ];

  agregarFotos(Fotografias foto){
    nConsecutivo = nConsecutivo + 1;
    foto.nombre =  "F${foto.folioServicio.replaceAll(".0", "")}${(nConsecutivo)}.jpg";
    
    ListaFotografia.add(foto);

    notifyListeners();
  }

  eliminarFoto(){
    ListaFotografia.removeAt(index);
    notifyListeners();
  }

  removerFotosEnviadas(){
    ListaFotografia.removeWhere((element) => element.enviado == true);
    notifyListeners();
  }

Future SubirImagen(Fotografias foto) async{
    try{
    
    isLoading = true;
    notifyListeners();
    
    var url = Uri.http(Ajustes.URL,"${Ajustes.ApiOperaciones}/servicio/subirFoto");

    var bytes = await foto.file!.readAsBytes();   
    String dataBase64 = base64.encode(bytes);

    Map data = {
      "cotenidoByte": dataBase64,
      "folioServicio": foto.folioServicio,
      "NombreFoto": foto.nombre,
      "tipoFoto": foto.tipoFoto,
      "tipoAlmacen": Ajustes.IdAlmacen == 2 ? "LCL" :"FRIO"
    };
    print("Se recibe el nombre: "+foto.nombre!);
    var body = json.encode(data);
    

    logger.i(body);

    var response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Ajustes.Token}',
      },body: body);

        if(response.statusCode == 200){ 
            logger.i(response.body.toString());
            isLoading = false;            
            notifyListeners();
            return 'true';
        }
        else if(response.statusCode == 401){
          Ajustes.TokenExpired = true;
          notifyListeners();
          return 'false';
        }
        else {
          throw response.statusCode;
        }

    }
    catch(e){ 
      await guardarEnGaleria(foto);
      _log.e('Error al subir fotografia, $e');
                  isLoading = false;            

      return 'false';

    }
  }

Future guardarEnGaleria(foto) async {
  final permission = Permission.storage;
  final status = await permission.status;
  
  if (!status.isGranted) {
    await permission.request();
  }
  
  final bytes = await foto.file!.readAsBytes();
  final result = await ImageGallerySaver.saveImage(Uint8List.fromList(bytes));
  
  final imagePath = result['filePath'];
  print('Ruta absoluta de la imagen guardada: $imagePath');
}

Future ObtenUltimaFotografiaServicio() async{
  try{
    
      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiCatalogos}/servicio/ObtenUltimaFotografiaServicio", {"nFolioServicio": folioServicio.toString().replaceAll(".0", "")});
      var headers = {HttpHeaders.contentTypeHeader:"application/json", 'Authorization': 'Bearer ${Ajustes.Token}',};
      http.Response response = await http.get(url,headers:headers);

      if(response.statusCode == 200){
                Consecutivo =  int.parse(response.body);
      }
      else if(response.statusCode == 401){
        Ajustes.TokenExpired = true;
        notifyListeners();
        Consecutivo = 0;
      } else {
        Consecutivo = 0;
      }

  }
  catch(e){            
    _log.e('Error al obtener fotografia, $e');
    Consecutivo = 0;
  }

}

Future<List<Fotografias>>obtenFotografiasServicio() async {
    try{
    
      var url = Uri.http(Ajustes.URL,"${Ajustes.ApiCatalogos}/servicio/ObtenFotografiasServicio", {"nFolioServicio": folioServicio.toString()});
    
      var headers = {HttpHeaders.contentTypeHeader:"application/json", 'Authorization': 'Bearer ${Ajustes.Token}',};

      http.Response response = await http.get(url,headers:headers);

      if(response.statusCode == 200){
        ListaFotografia  = fotografiasFromJson(response.body);
        return ListaFotografia;
      }
      else if(response.statusCode == 401){
        Ajustes.TokenExpired = true;
        notifyListeners();
        return ListaFotografia;
      } else {
        throw response.statusCode;
      }

    }
    catch(e){            
      _log.e('Error al obtener fotografia, $e');
      throw Exception();  
    }
  }


}