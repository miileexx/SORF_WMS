import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/providers/PendientesUbicarProvider.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/Alerta.dart';
import 'package:sorfwms/widgets/BackgroundPurple.dart';
import 'package:sorfwms/widgets/cardContainer.dart';
import 'package:sorfwms/widgets/regresoRutaScreen.dart';

class PendientesUbicarScreen extends StatefulWidget {
  const PendientesUbicarScreen({super.key});

  @override
  State<PendientesUbicarScreen> createState() => _PendientesUbicarScreenState();
}

class _PendientesUbicarScreenState extends State<PendientesUbicarScreen> {
  @override
  Widget build(BuildContext context) {
    final PenUbicProvider = Provider.of<PendientesUbicarProvider>(context);
    final servicios = Provider.of<ServicioProvider>(context);

    final TextEditingController _posicionController =
        TextEditingController(text: '${PenUbicProvider.posicion}');
    final TextEditingController _matriculaController =
        TextEditingController(text: '${PenUbicProvider.matricula}');
    final size = MediaQuery.of(context).size;
    final FocusNode focusPosicion = FocusNode();
    final FocusNode focusMatricula = FocusNode();

    bool blnguardar = true;
    return Scaffold(
      body: BackgroundScreen(
        name: 'Recolectar',
        child: Stack(
          children: [           
            SingleChildScrollView(
            child: Column(
                children: [
                  SizedBox(height: size.height*0.18),
                  CardContainer(
                    full: true,
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Container(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Title(color: Colors.black, child: Text('Total de bultos: ${PenUbicProvider.matriculas.length}',
                            style: TextStyle(fontSize: 20),
                            )),
                            Container(
                              height: size.height*0.40,
                              child: Container(
                                child: ListView.builder(
                                  itemCount: PenUbicProvider.matriculas.length,
                                  itemBuilder: (context, index) {
                                    final matricula =
                                        PenUbicProvider.matriculas[index];
                                    return Card(
                                      color: Colors.grey[200],
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CheckboxListTile(
                                            secondary: size.width > 400?Icon(Icons.inventory):null,
                                            title: Row(
                                              children: [
                                                Text('${matricula.matriculas}'),
                                                SizedBox(width: size.width*0.05,),
                                                Text('${matricula.posicionString}'),
                      
                                              ],
                                            ),
                                            subtitle: Row(
                                              children: [
                                                Text(
                                                    '${matricula.embalajePartida}'),
                                                const SizedBox(width: 10),
                                                Text(
                                                    '${matricula.bultos}/${matricula.totalBultos}'),
                                                const SizedBox(width: 20),
                                                Text('${matricula.pesoPartida}')
                                              ],
                                            ),
                                            value: PenUbicProvider
                                                .matriculas[index].seleccionado,
                                            onChanged: (value) {
                                              PenUbicProvider.seleccionar(
                                                  value!, index);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 16),
                            TextFormField(
                                controller: _matriculaController,
                                  
                                onChanged: (value) {
                                  PenUbicProvider.matricula = value;                        
                                },
                                decoration: InputDecoration(
                                        labelText: 'Matricula',
                                        labelStyle: TextStyle(color: focusMatricula.hasFocus ? Primarycolor : Secundarycolor),
                                         border: OutlineInputBorder(          
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(width: 2, color: Primarycolor), //4211d0
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: BorderSide(width: 2, color: Primarycolor), //4211d0
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(width: 2, color: Secundarycolor)                                            
                                            ),

                                        suffixIcon: IconButton( 
                                        icon: Icon(Icons.center_focus_weak_sharp),
                                        onPressed: () async{
                                          PenUbicProvider.matricula = await scanBarcodeNormal();
                                          PenUbicProvider.matriculasSeleccionadas = [];           
                                  
                                          PenUbicProvider.matriculas.forEach((element) {
                                  
                                  if(element.matriculas!.trim() == PenUbicProvider.matricula.trim()){
                                       PenUbicProvider.matriculasSeleccionadas.add(element);                                  
                                       blnguardar = false;      
                                       return;                            
                                    }
                                  });
                                  
                                  if(blnguardar){
                                    Alerta(context, "SORF WMS", "La matrícula no se encuentra en el listado pendiente de ubicar.");
                                    return;
                                  } 
                      
                                          
                                  
                                 
                                                                            
                                          setState(() {
                                              
                                            });
                                        },)
                                      ),
                              
                                onFieldSubmitted: (value) async { 
                                  OverlayLoadingProgress.start(context);
                                  PenUbicProvider.matriculasSeleccionadas = [];           
                                  
                                  PenUbicProvider.matriculas.forEach((element) {
                                  
                                  if(element.matriculas!.trim() == value.trim()){
                                       PenUbicProvider.matriculasSeleccionadas.add(element);                                  
                                       blnguardar = false;      
                                       return;                            
                                    }
                                  });
                                  
                                  if(blnguardar){
                                    Alerta(context, "SORF WMS", "La matrícula no se encuentra en el listado pendiente de ubicar.");
                                    OverlayLoadingProgress.stop();
                                    return;
                                  } 
                      
                                          
                                  
                                  var respuesta = await PenUbicProvider.GuardarPosicion();
                                  
                                  Alerta(context, "SORF WMS", respuesta); 
                                  
                                  OverlayLoadingProgress.stop();
                                  
                                },
                              ),
                          const SizedBox(height: 16),
                            Row(
                                children: [
                                  Container(
                                    width: size.height>600? size.width*0.90 : size.width*0.75,
                                    child: Container(
                                      child: TextFormField(                                      
                                        textInputAction: TextInputAction.next,
                                        controller: _posicionController,
                                        onChanged: (value) {
                                          PenUbicProvider.posicion = value;                        
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Posicion',
                                          labelStyle: TextStyle(color: focusPosicion.hasFocus ? Primarycolor : Secundarycolor),
                                           border: OutlineInputBorder(          
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(width: 2, color: Primarycolor), //4211d0
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: BorderSide(width: 2, color: Primarycolor), //4211d0
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide(width: 2, color: Secundarycolor)                                            
                                              ),

                                          suffixIcon: IconButton( 
                                          icon: Icon(Icons.center_focus_weak_sharp),
                                          onPressed: () async{
                                            PenUbicProvider.posicion = await scanBarcodeNormal();
                                            setState(() {
                                              
                                            });
                                          },)
                                        )
                                      ),
                                    ),
                                  ),
                                  if(PenUbicProvider.isPendUbi)
                                  Container(
                                    child: TextFormField(
                                      decoration: DecorationFormSettings(FocusNode(), '', 'Pos. disp.')
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
             Positioned(
              top: 40,
              left: 20,
              child: Container(    
                width: 50,
                height: 50,             
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Center(
                    child: IconButton(
                        onPressed: () {
                          OverlayLoadingProgress.start(context);
                          servicios.ConsultaServiciosByUsuario();
                          Navigator.pushReplacementNamed(context, '/servicio');
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        )),
                  )
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: PenUbicProvider.isSaving
            ? null
            : () async {
                var respuesta = await PenUbicProvider.GuardarPosicion();

                Alerta(context, "SORF WMS", respuesta);
              },
        child: PenUbicProvider.isSaving
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(
                Icons.save,
                color: Colors.white,
              ),
      ),
    );
  }

  Future<String> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);          
      return barcodeScanRes;
    } catch (e) {
      return '';
    }
  }
}
