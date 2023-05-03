import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:sorfwms/Services/inicia_servicio.services.dart';
import 'package:sorfwms/Services/servicio_services.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/ResumenProgramacion.dart';
import 'package:sorfwms/models/ServicioParam.dart';
import 'package:sorfwms/widgets/Loading.dart';


class ServicioProvider extends ChangeNotifier{

    GlobalKey<FormState> formkey = new GlobalKey<FormState>();
    ServicioServices servicioServices = ServicioServices();
    List<ResumenProgramacion> listaServicios = [];
    List<ResumenProgramacion> listaServiciosBusqueda = [];
    IniciaServicioServices iniciaservicios =  IniciaServicioServices();

    bool _bPendRecolectar = false;
    bool isLoading = true; 
    int nSelectedGender = 1;
    double _folioServicio = 0;
    bool _checkConso = false;
    bool _bRecoleccionIniciada = false;
    int _claveUsuario = 0;
    int _bultosPiso = 0;
    int _totalBultos = 0;
    String _folioCapturado = '';
    String _folioCapturadoManual = '';
    bool _ingreso = false;
    bool iniciado = false;
    int _estatus = 0;
    String _descripError = '';

  String get DescripError{
    return _descripError;
  }

  set DescripError(String value){
    _descripError = value;
  }

  int get Estatus{
    return _estatus;
  }

  set Estatus(int value){
    _estatus = value;
  }

    List<bool> checkBox = [];
    List<bool> selecciones = [];

    String get folioCapturadoManual{
      return _folioCapturadoManual;
    }

    set folioCapturadoManual(String value){
      _folioCapturadoManual = value;
      notifyListeners();
    }

    String get folioCapturado{
      return _folioCapturado;
    }

    set folioCapturado(String value){
      _folioCapturado = value;
      notifyListeners();
    }

    int get totalBultos{
      return _totalBultos;
    }

    set totalBultos(int value){
      _totalBultos = value;
      notifyListeners();
    }

    int get bultosPiso{
      return _bultosPiso;
    }
    
    set bultosPiso(int value){
      _bultosPiso = value;
      notifyListeners();
    }

    int get claveUsuario{
      return _claveUsuario;
    }

    set claveUsuario(int value){
      _claveUsuario = value;
      notifyListeners();
    }

    int get SelectedGender{
      return nSelectedGender;
    }

    set SelectedGender(int value){
      nSelectedGender = value;
      notifyListeners();
    }

    BuscarServicioTabla(String value){
      if (value.isNotEmpty) {
        int index = listaServicios.indexWhere((element) => element.folioServicio == double.parse(value)) ?? 0;
        if(index>0){
          var servicioEncontrado = listaServicios[index];
          listaServiciosBusqueda = listaServicios;
          listaServicios = [];
          listaServicios.add(servicioEncontrado);
          selecciones = List<bool>.generate(listaServicios.length, (index) => false);
          notifyListeners();          
        }else{
        if(listaServiciosBusqueda.length > 0){
          listaServicios = listaServiciosBusqueda;
          listaServiciosBusqueda = [];
          selecciones = List<bool>.generate(listaServicios.length, (index) => false);
          notifyListeners();
        }
      }
      }else{
        if(listaServiciosBusqueda.length > 0){
          listaServicios = listaServiciosBusqueda;
          listaServiciosBusqueda = [];
          selecciones = List<bool>.generate(listaServicios.length, (index) => false);
          notifyListeners();
        }
      }
    }

    cambiarSeleccion(int index, bool value){
      selecciones = List<bool>.generate(listaServicios.length, (index) => false);
      selecciones[index] = value;
      notifyListeners();
    }

    double get FolioServicio{
      return _folioServicio;
    }

    set FolioServicio(double value){
      _folioServicio = value;
      notifyListeners();
    }

    bool get PendienteRecolectar{
      return _bPendRecolectar;
    }

    set PendienteRecolectar(bool value){
      if(isLoading == false){
      _bPendRecolectar = value;
      ConsultaServiciosByUsuario();
      notifyListeners();
      }
    }

    bool get RecoleccionIniciada{
      return _bRecoleccionIniciada;
    }


    set RecoleccionIniciada(bool value){
      _bRecoleccionIniciada = value;
    }
    
    ServicioProvider() {
      ConsultaServiciosByUsuario();
    }

    ConsultaServiciosByUsuario() async{
      
      this.isLoading = true;

      if(Ajustes.idUsuario > 0){

        ServicioByUsuarioParam parametros =  ServicioByUsuarioParam(nIdUsuario: Ajustes.idUsuario, 
                                                                      nIdAlmacen: Ajustes.IdAlmacen,
                                                                      bPendRecolectar: PendienteRecolectar,
                                                                      bMonitorFcl: false,
                                                                      bPendAsignar: false,
                                                                      bTerminados: false);


        listaServicios = await servicioServices.ConsultaServiciosByUsuario(parametros);
        this.isLoading = false;
        selecciones = List<bool>.generate(listaServicios.length, (index) => false);  
        notifyListeners();
        return listaServicios;
      }
    }

    IniciarServicio() async{
    isLoading=true;
    ServicioParam parametros = ServicioParam(
                                nTipoAlmacen: Ajustes.IdAlmacen.toString(),
                                nFolioServicio: FolioServicio,
    );

    var res = await iniciaservicios.IniciaServicio(parametros);
    
    Estatus = res["Estatus"];
    DescripError = res["DescripError"];
    isLoading=false;
  }
}