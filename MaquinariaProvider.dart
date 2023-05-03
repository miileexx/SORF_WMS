import 'package:flutter/material.dart';
import 'package:sorfwms/models/Maquinaria.dart';


class MaquinariaProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  List<Maquinaria> Maquinarias = [];
  List<Maquinaria> MaquinariasEliminadas = [];

  List<bool> SelecionTable = [];

  double dMinutosAgisnar = 0;
  int nSelecionMaquinaria = 0;
  int nSelecionTabla = 0;

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
    SelecionTable  = List<bool>.generate(Maquinarias.length,(int index) => false);
    SelecionTable[index] = value;
    notifyListeners();
  }

  AgregarMaquinaria(Maquinaria maquinaria){
    maquinaria.operacionBd = 1; 
    Maquinarias.add(maquinaria);
    SelecionTable.add(false);
    notifyListeners();
  } 

 AgregarMaquinarias( List<Maquinaria>? maquinarias){
    MaquinariasEliminadas = [];
    Maquinarias = maquinarias??[];
    SelecionTable  = List<bool>.generate(Maquinarias.length,(int index) => false);
  } 

  RetornaMaquinaria(){
    MaquinariasEliminadas.forEach((element) {
      Maquinarias.add(element);
    });

    return Maquinarias;

  }

  RemoverMaquinaria(){
    
    if(Maquinarias[SelecionTabla].operacionBd == 0){
      Maquinarias[SelecionTabla].operacionBd = 3;
      MaquinariasEliminadas.add(Maquinarias[SelecionTabla]);
    }  
    
    Maquinarias.removeAt(SelecionTabla);   
    SelecionTable  = List<bool>.generate(Maquinarias.length,(int index) => false);
    notifyListeners();
  }

  
}