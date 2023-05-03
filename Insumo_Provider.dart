import 'package:flutter/material.dart';
import 'package:sorfwms/models/Insumo.dart';

class InsumoProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  List<Insumo> Insumos = [];
  List<Insumo> InsumosEliminados = [];
  double cantidadInsumo = 0;
  int operacionBd = 1;
  int _selecion = 0;
  bool _selecionadoTabla = false;

  bool get SeleccionadoTabla {
    return _selecionadoTabla;
  }

  set SeleccionadoTabla(bool select) { 
    _selecionadoTabla = select;
    notifyListeners();
  }

  int get getselecion {
    return _selecion;
  }

  set setselecion(int selecion) {
    _selecion = selecion;
    notifyListeners();
  }

  set setCantidadInsumo(double cantidad) {
    cantidadInsumo = cantidad;
    notifyListeners();
  }

  int get getOperacionBd {
    return operacionBd;
  }

  set setOperacionBd(int p__operacionBD) {
    operacionBd = p__operacionBD;
    notifyListeners();
  }

  double get getCantidadInsumo {
    return this.cantidadInsumo;
  }

  Agregarinsumo(Insumo insumo) {
    insumo.operacionBd = 1;
    Insumos.add(insumo);
    notifyListeners();
  }

  ActualizarInsumo(Insumo p__insumo) {
    Insumos[Insumos.indexWhere(
        (element) => element.claveInsumo == p__insumo.claveInsumo)] = p__insumo;
    notifyListeners();
  }

  AgregarInsumos(List<Insumo>? insumos) {
    InsumosEliminados = [];
    Insumos = insumos ?? [];
  }
  RetornarInsumos(){
    InsumosEliminados.forEach((element) {
      Insumos.add(element);
    });
   return Insumos;
  }

  removerInsumo() {
    var insumo = Insumos[Insumos.indexWhere((element) => element.claveInsumo == _selecion)];
   
    if(insumo.operacionBd == 0){
      insumo.operacionBd = 3;
      InsumosEliminados.add(insumo);
    }
    
    Insumos.removeWhere((element) => element.claveInsumo == _selecion);
    notifyListeners();

  }

  
  removeselection() {
    if (Insumos != null) {
      Insumos.forEach((element) {
        if (element.select == true) {
          element.select = false;
        }
      });

      notifyListeners();
    }
  }
}
