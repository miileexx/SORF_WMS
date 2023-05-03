import 'package:flutter/material.dart';
import 'package:sorfwms/Services/inicia_servicio.services.dart';
import 'package:sorfwms/Services/servicio_services.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/ConsultaServicio.dart';
import 'package:sorfwms/models/EstatusDetalleServicio.dart';
import 'package:sorfwms/models/ServicioParam.dart';

class ConsultaServicioProvider extends ChangeNotifier{
    
  double _folioServicio = 0;
  bool _bConsolidacion = false;
  bool _bObtenerDetalleMercancia = true;
  ConsultaServicio servicios =  ConsultaServicio();
  ServicioServices servicioServices =  ServicioServices();
  IniciaServicioServices iniciaservicios =  IniciaServicioServices();
  bool isLoading = true;
  bool isSaving  = false;
  bool loaded = false;
  bool _ingreso = false;
  String _nuevaFirma = '';
  String _mercanciaVal = '';
  String _nuevaVar = '';

  String get NuevaVar{
    return _nuevaVar;
  }
  
  set NuevaVar(String value){
    _nuevaVar = value;
    notifyListeners();
  }

  String get MercanciaVal{
    return _mercanciaVal;
  }

  set MercanciaVal(String value){
    _mercanciaVal = value;
    notifyListeners();
  }

  bool get ingreso{
    return _ingreso;
  }

  set ingreso(bool value){
    _ingreso = value;
    notifyListeners();
  }

  String get NuevaFirma{
    return _nuevaFirma;
  }

  set NuevaFirma(String value){
    _nuevaFirma = value;
    notifyListeners();
  }

  double get FolioServicio{
    return _folioServicio;
  }

  set FolioServicio(double value){
    _folioServicio = value;
  }

  bool get Consolidacion{
    return _bConsolidacion;
  }
  
  set Consolidacion(bool value){
    _bConsolidacion = value;
  }

   bool get ObtenerDetalle{
    return _bObtenerDetalleMercancia;
  }
  
  set ObtenerDetalle(bool value){
    _bObtenerDetalleMercancia = value;
  }


  ConsultaServicios() async{
    isLoading = true;

    ServicioParam parametros = ServicioParam(
                                nTipoAlmacen: Ajustes.IdAlmacen.toString(),
                                nFolioServicio: FolioServicio,
                                bConsolidacion: Consolidacion,
                                bObtenerDetalleMercancia: ObtenerDetalle);

    servicios = await servicioServices.Consultaservicio(parametros);
    
    isLoading = false;
    notifyListeners();
  }

  actualizaFolioServicio()async{
    isSaving = true;
    notifyListeners();

    List<EstatusDetalleServicio>  respuesta = await servicioServices.actualizaFolioServicio(servicios.detalleServicio!);
    
    isSaving = false;
    loaded=true;
    notifyListeners();

    if(respuesta.length > 0){
      return respuesta[0].success;
    }else{
          
      isSaving = false;
      return false;
    }
    
    
    
  }

}