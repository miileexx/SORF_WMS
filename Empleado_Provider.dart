import 'package:flutter/material.dart';
import 'package:sorfwms/models/Empleado.dart';

class EmpleadoProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  List<Empleado> Empleados = [];
  List<Empleado> EmpleadosElimnados = [];
  List<bool> SelecionTable = [];

  double dMinutosAgisnar = 0;
  int nSelecionEmpleado = 0;
  int nSelecionPuesto = 0;
  int nSelecionTabla = 0;
  bool nOrdinario = true;
  int nClaveDefault = 0;
  String nDescrip = '';

  String get Descrip{
    return nDescrip;
  }

  set Descrip(String descrip){
    nDescrip = descrip;
    notifyListeners();
  }

  bool get Ordinario{  
    return nOrdinario;
  }

  set Ordinario(bool selecion){
    nOrdinario = selecion;
    notifyListeners();
  }

  int get ClaveDefault{
    return nClaveDefault;
  }

  set ClaveDefault(int clave){
    nClaveDefault=clave;
    notifyListeners();
  }

  int get SelecionEmpleado{  
    return nSelecionEmpleado;
  }

  set SelecionEmpleado(int selecion){
    nSelecionEmpleado = selecion;
      notifyListeners();
  }
  
  int get SelecionPuesto{  
    return nSelecionPuesto;
  }

  set SelecionPuesto(int selecion){
    nSelecionPuesto = selecion;
      notifyListeners();
  }

  int get SelecionTabla{  
    return nSelecionTabla;
  }

  set SelecionTabla(int selecion){
    nSelecionTabla = selecion;
      notifyListeners();
  }
  
  double get MinutosAsignados{  
    return dMinutosAgisnar;
  }

  set MinutosAsignados(double Minutos){
    dMinutosAgisnar = Minutos;
      notifyListeners();
  }

  cambiarSeleccion(int index, bool value){
    SelecionTable  = List<bool>.generate(Empleados.length,(int index) => false);
    SelecionTable[index] = value;
    notifyListeners();
  }

  AgregarEmpleado(Empleado empleado){
    empleado.operacionBd = 1;
    Empleados.add(empleado);
    SelecionTable.add(false);
    MinutosAsignados = 0;
    notifyListeners();
  }

  AgregarEmpleados(List<Empleado>? empleado){
    EmpleadosElimnados = [];
    Empleados = empleado??[];
    SelecionTable  = List<bool>.generate(Empleados.length,(int index) => false);
  }

  List<Empleado> retornarPersonas(){
    EmpleadosElimnados.forEach((element) {
      Empleados.add(element);
    });
   
    return Empleados;
  }

  RemoverEmpleado(){

    if(Empleados[SelecionTabla].operacionBd == 0){
      Empleados[SelecionTabla].operacionBd = 3;
      EmpleadosElimnados.add(Empleados[SelecionTabla]);
    }  
    
    Empleados.removeAt(SelecionTabla);   
    SelecionTable  = List<bool>.generate(Empleados.length,(int index) => false);
    notifyListeners();
    MinutosAsignados = 0;

  }
  // 1 insertar, 2 update, 3 delete, 0 none
  
}