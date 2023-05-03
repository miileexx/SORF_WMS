
import 'package:flutter/material.dart';
import 'package:sorfwms/Services/partida_services.dart';
import 'package:sorfwms/models/Matricula.dart';
import 'package:sorfwms/models/ParametrosUbicar.dart';

class PendientesUbicarProvider extends ChangeNotifier{
  
  PartidaService servicio = PartidaService();

  double _folioServicio = 0;
  String _matricula = '';
  String _posicion ='';
  bool _recolecionIniciada = true;

  
  bool isLoading = true;
  bool isSaving = false;
  bool isPendUbi= false;

  List<Matricula> matriculas = [];
  List<Matricula> matriculasSeleccionadas = [];

  

  double get FolioServicio{
  return _folioServicio;
  }
  String get matricula{
    return _matricula;
  }
  String get posicion{
    return _posicion;
  }
  bool get RecolecionIniciada{
    return _recolecionIniciada;
  }
  set matricula(String value){
    _matricula = value;
  }
  set posicion(String value){
    _posicion = value;
 }
  set FolioServicio(double value){
  _folioServicio = value;
  }
  set RecolecionIniciada(bool value){
    _recolecionIniciada = value;
  }


  PartidasSeleccionadas(int index,bool value){

    matriculas[index].seleccionado = value;
    notifyListeners();

  }

  seleccionar(bool value, int index){
    matriculas[index].seleccionado = value;
    notifyListeners();
  }
  
  obtenMatriculasPrevio() async{
    isLoading = true;
    if(FolioServicio != 0){
      matriculas=[];
      matriculas = await servicio.ObtenMatriculasPrevio(FolioServicio);
      notifyListeners();
    }
    isLoading = false;
  }

  Future<String> GuardarPosicion() async{
    try{
    isSaving = true;
    notifyListeners();

    String respues = "";

    if(posicion.isEmpty){
      respues = 'Capture una posicion';
    }else{
       if(matriculasSeleccionadas.isEmpty){
      matriculas.forEach((element) {
      if(element.seleccionado!){
        matriculasSeleccionadas.add(element);
      }
     });   
    }
    

    var listaRespuesta = await servicio.GuardarPosicion(
      ParametrosUbicar(
        lMatriculas: matriculasSeleccionadas,
       sPosicion: posicion, 
       bIngreso: false, 
       bPrevio: true, 
       bReubicacion: false
      ));

    if(listaRespuesta.length >0){

        matriculasSeleccionadas = [];
        matricula = "";
        
        if(listaRespuesta.length == 1 ){

          respues = listaRespuesta[0].descripcionError??'Error al guardar';
          if(respues == "OK"){
            matriculas.removeWhere((element) => element.matriculas == listaRespuesta[0].matriculas);
          }
        }else{
      
          listaRespuesta.forEach((mat) {
            if((mat.estatus??0) > 0 ){
                respues = "$respues No se pudo asignar posición a la matrícula: ${mat.matriculas}. Mensaje: ${mat.descripcionError}";
            }else{
                for(int i = 0; i < matriculas.length; i++){
                  if (matriculas[i].matriculas==mat.matriculas)
                  {
                      matriculas.removeAt(i);
                  }
                }
                respues = "$respues la matrícula: ${mat.matriculas}. Se posiciono correctamente";
            }
            
          });        
        }

        if(RecolecionIniciada == false){
          var estatusiniciado = await servicio.SetInicioRecoleccionPrevio(FolioServicio);
          if (estatusiniciado.estatus > 0)
          {
              respues = "No se puedo iniciar la recolección del previo. Mensaje: ${estatusiniciado.descripcionError}";
          }
          else
          {
              RecolecionIniciada = true;
          }
        }

        notifyListeners();

    }else{
      respues = 'Error al guardar posicion';
    }
    

    }

   

    isSaving = false;
    notifyListeners();
    
    return respues;

  } catch(e){
      isSaving = false;
     notifyListeners();
    
    return "Error interno ($e)";
  }
  }
 
  



}


