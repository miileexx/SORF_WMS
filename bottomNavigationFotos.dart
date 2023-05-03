
import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/Services/fotografia_service.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/widgets/Alerta.dart';

class BottomNavigationFotos extends StatelessWidget {

  final FloatingActionButtonLocation fabLocation;
  final NotchedShape? shape;
  
  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];


  const BottomNavigationFotos({super.key, required this.fabLocation, this.shape});

  @override
  Widget build(BuildContext context) {

    final providerFoto = Provider.of<FotografiaServices>(context);

    return BottomAppBar(
      shape: shape,
      color: Primarycolor,
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(
                child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon( Icons.delete ,color: Colors.white),
                          Text('Eliminar', style: TextStyle(color: Colors.white),)
                        ],              
                      )
              ,onPressed: () {
                if(providerFoto.ListaFotografia.isNotEmpty) {
                  providerFoto.eliminarFoto();
                }
              },
              ),
            ),
           
            if (centerLocations.contains(fabLocation)) const Spacer(),            
            
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextButton(                
              // ignore: sort_child_properties_last
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  providerFoto.isLoading ? const CircularProgressIndicator() : const Icon( Icons.send ,color: Colors.white),
                  Text( providerFoto.isLoading ? 'Cargando':'Enviar', style: const TextStyle(color: Colors.white),)
                ],
              ),
              onPressed: providerFoto.isLoading ? null : () async { 
                

                if(providerFoto.isLoading=true){
                  OverlayLoadingProgress.start(context,barrierDismissible: false);
                }                 
                
                //int nConsecutivo  = await  providerFoto.ObtenUltimaFotografiaServicio();

                providerFoto.ListaFotografia.forEach(
                  (element) async {
                  //nConsecutivo = nConsecutivo + 1;

                  //element.nombre =  "F${element.folioServicio.replaceAll(".0", "")}${(nConsecutivo)}.jpg";
                 
                  var resp = await providerFoto.SubirImagen(element);

                  if(resp == 'true'){
                    element.enviado = true;
                  }else{
                    Alerta(context, "SORF", "Error al subir fotos, favor de verificar su conexión. \n\n El respaldo de las fotos se ha guardado en galería.");
                  }
                  providerFoto.removerFotosEnviadas();
                  OverlayLoadingProgress.stop();   
                });

                
                
                
              },                          
              ),
            ),
          ],
        ),
      ),
    );
  }
}