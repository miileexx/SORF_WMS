import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirmasProvider extends ChangeNotifier{

  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  bool nControllerLimpio = false;
  String nFirmaCodificada = '';
  String nPath = '';

  String get Path{
    return nPath;
  }
  set Path(String path){
    nPath = path;
    notifyListeners();
  }

  String get FirmaCodificada{
    return nFirmaCodificada;
  }

  set FirmaCodificada(String firmaCodificada){
    nFirmaCodificada = firmaCodificada;
    notifyListeners();
  }

  bool get ControllerLimpio{
    return nControllerLimpio;
  }

  set ControllerLimpio(bool controllerlimpio){
    nControllerLimpio = controllerlimpio;
    notifyListeners();
  }
}