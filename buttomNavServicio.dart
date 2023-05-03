import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/Services/fotografia_service.dart';
import 'package:sorfwms/models/Fotografias.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Empleado_Provider.dart';
import 'package:sorfwms/providers/Insumo_Provider.dart';
import 'package:sorfwms/providers/MaquinariaProvider.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/widgets/Alerta.dart';

class ButtomNavServicio extends StatelessWidget {

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;
  
  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];


  const ButtomNavServicio({super.key, required this.fabLocation, this.shape});

  @override
  Widget build(BuildContext context) {

    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);
    final insumos = Provider.of<InsumoProvider>(context);
    final maquinaria = Provider.of<MaquinariaProvider>(context);
    final empleado = Provider.of<EmpleadoProvider>(context);
    final fotografia = Provider.of<FotografiaServices>(context);
    final servicios = Provider.of<ServicioProvider>(context);
    
    return BottomAppBar(
      shape: shape,
      color: Primarycolor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),             
              // ignore: sort_child_properties_last
              child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                          IconButton(color:  Colors.white, iconSize: 35, onPressed: () { 
                            servicios.listaServicios=[];
                            servicios.PendienteRecolectar=false;
                            Navigator.pushReplacementNamed(context, "/servicio");
                          }, icon: Icon(Icons.home)),
                        ],              
                      ),
              ),
          
            if (centerLocations.contains(fabLocation)) const Spacer(),
          
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PopupMenuButton(
                constraints: const BoxConstraints.expand(width: 150, height: 100),
                icon: Icon(Icons.more, color: Colors.white),
                iconSize: 33,
                itemBuilder: (BuildContext bc) {
                  return [
                    PopupMenuItem(
                      child: Container(
                        child: Container(
                          child: SizedBox(
                            width: 200,
                            child: TextButton.icon(
                              onPressed: 
                              consultaServicio.isSaving ? null: ()  async {            
                                if(consultaServicio.isSaving==false){
                                  OverlayLoadingProgress.start(context);
                                }          
                              consultaServicio.servicios.detalleServicio!.insumos = insumos.RetornarInsumos();
                              consultaServicio.servicios.detalleServicio!.maquinarias = maquinaria.RetornaMaquinaria();
                              consultaServicio.servicios.detalleServicio!.personas = empleado.retornarPersonas();
                              consultaServicio.servicios.detalleServicio!.operacionBd = 2;
                              await consultaServicio.actualizaFolioServicio();
                              if(consultaServicio.loaded==true){
                                OverlayLoadingProgress.stop();
                              }
                                              }, 
                              icon: const Icon(Icons.save,color: Colors.black),
                              label: const Text('Guardar',style: TextStyle(color: Colors.black))),
                          ),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      child: Container(
                        child: Container(
                          width: 180,
                          child: TextButton.icon(
                            onPressed: () async{
                              List<Fotografias> listafotos = fotografia.ListaFotografia;
                      
                              if(listafotos.length == 0 ){
                                
                                  var respuesta = await confirmarServicio(context);
                      
                                  if(respuesta){
                      
                                    var fecha = DateTime.now();
                      
                                    consultaServicio.servicios.detalleServicio!.insumos = insumos.RetornarInsumos();
                                    consultaServicio.servicios.detalleServicio!.maquinarias = maquinaria.RetornaMaquinaria();
                                    consultaServicio.servicios.detalleServicio!.personas = empleado.retornarPersonas();
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
                            }, 
                            icon: const Icon(Icons.check,color: Colors.black),
                            label: const Text('Terminar',style: TextStyle(color: Colors.black))),
                        ),
                      ),
                    ),
                  ];
                },
              ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

Future<bool> confirmarServicio(context) async {
  bool respuesta = false;
  await showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
        title: const Text('SORF WMS'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('¿Desea cerrar el servicio?.'),
            ],
          ),
        ),
        actions: [
          TextButton(
                onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          TextButton(
            child: const Text('Confirmar'),
            onPressed: (){
                respuesta = true;
                Navigator.of(context).pop();
            },
          ),
        ],
      ),
  );
  return respuesta;
}