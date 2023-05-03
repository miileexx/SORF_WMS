import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/Services/fotografia_service.dart';
import 'package:sorfwms/models/Fotografias.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Empleado_Provider.dart';
import 'package:sorfwms/providers/Insumo_Provider.dart';
import 'package:sorfwms/providers/MaquinariaProvider.dart';
import 'package:sorfwms/widgets/Alerta.dart';
import 'package:sorfwms/widgets/buttomNavServicio.dart';

class animatedFab extends StatefulWidget {
  const animatedFab({
    Key? key,
  }) : super(key: key);

  @override
  State<animatedFab> createState() => _animatedFabState();
}

class _animatedFabState extends State<animatedFab> {

  final GlobalKey<AnimatedFloatingActionButtonState> key = GlobalKey<AnimatedFloatingActionButtonState>();

  @override
  Widget build(BuildContext context) {
    return
        SizedBox(
          child: Container(
            child: fab(),
          ),
        );
  }

  Widget add() {

    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);
    final insumos = Provider.of<InsumoProvider>(context);
    final maquinaria = Provider.of<MaquinariaProvider>(context);
    final empleado = Provider.of<EmpleadoProvider>(context);
    final fotografia = Provider.of<FotografiaServices>(context);

    return Container(
      child: FloatingActionButton(
        onPressed: consultaServicio.isSaving ? null: ()  async{                           
                  consultaServicio.servicios.detalleServicio!.insumos = insumos.Insumos;
                  consultaServicio.servicios.detalleServicio!.maquinarias = maquinaria.Maquinarias;
                  consultaServicio.servicios.detalleServicio!.personas = empleado.Empleados;
                  consultaServicio.servicios.detalleServicio!.operacionBd = 2;
                  await consultaServicio.actualizaFolioServicio();
                  key.currentState?.closeFABs();
                },
        heroTag: "Guardar",
        tooltip: 'Add',
        child: Icon(Icons.save),
      ),
    );
  }

  Widget image() {

    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);
    final insumos = Provider.of<InsumoProvider>(context);
    final maquinaria = Provider.of<MaquinariaProvider>(context);
    final empleado = Provider.of<EmpleadoProvider>(context);
    final fotografia = Provider.of<FotografiaServices>(context);

    return Container(
      child: FloatingActionButton(
        onPressed: consultaServicio.isSaving ? null: ()  async {                 
               List<Fotografias> listafotos = fotografia.ListaFotografia;
               if(listafotos.length == 0 ){
                  var respuesta = await confirmarServicio(context);
                  if(respuesta){
                    var fecha = DateTime.now();
                    consultaServicio.servicios.detalleServicio!.insumos = insumos.Insumos;
                    consultaServicio.servicios.detalleServicio!.maquinarias = maquinaria.Maquinarias;
                    consultaServicio.servicios.detalleServicio!.personas = empleado.Empleados;
                    consultaServicio.servicios.detalleServicio!.operacionBd = 2;
                    consultaServicio.servicios.detalleServicio!.fechaFin = fecha.toString();
                   var res =  await consultaServicio.actualizaFolioServicio();
                   if(res){
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacementNamed(context, "/servicio");
                   }
                  }
               }else{
                Alerta(context,'SORF WMS', 'Para cerrar el servicio es necesario enviar todas las fotografías desde el módulo correspondiente.');
               }
               key.currentState?.closeFABs();
              },
        heroTag: "Terminar",
        tooltip: 'Image',
        child: Icon(Icons.check),
      ),
    );
  }


  Widget fab(){
   return AnimatedFloatingActionButton(
        key: key,
        fabButtons: <Widget>[
          add(),
          image(),
        ],
        colorStartAnimation: Colors.blue,
        colorEndAnimation: Colors.red,
        animatedIconData: AnimatedIcons.menu_close,
      );
  }
}
