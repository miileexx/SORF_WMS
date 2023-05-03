import 'package:flutter/material.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';

import '../utilities/constants.dart';
import '../widgets/BackgroundPurple.dart';
import '../widgets/cardContainer.dart';
import '../widgets/regresoRutaScreen.dart';
import '../widgets/siguienteRutaScreen.dart';
import 'ingresosFRIO_Menu_screen.dart';

class temperaturaRecibidaScreen  extends StatelessWidget {
  const temperaturaRecibidaScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    List listpuerta = [];
     final size = MediaQuery.of(context).size;
     
    return Scaffold(
      
      body:BackgroundScreen(
        name: "Temp. Recibida",
        child: Stack( 
          children: [
            SingleChildScrollView(
              child: Column(
                children: [ 
                  SizedBox(height: size.height*0.18),
                  CardContainer(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: formTempRecibida(),
                    )
                  ),
                ],
              ),
            ),
        
            RegresoRutaScreen(context, '/ingresosFrio'),
            SiguienteRutaScreen(context, '/partidas'),
          ],
        ),
      ),
    );
  }
}

class formTempRecibida extends StatelessWidget {
  const formTempRecibida({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List listpuerta = [];
        final FocusNode focusMatricula = FocusNode();

    return SingleChildScrollView(
      child: Center( child:
         Container(
          
          //padding: EdgeInsets.all(20),
           child: Column(children: [
              Text("Folio de Servicio", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text("123456789",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              
              //Text("Sello origen", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextFormField(decoration: InputDecoration(
                 labelText: 'Sello Origen',
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
              ) ),
              SizedBox(
                height: 15,
              ),
              TextFormField(decoration: InputDecoration(
                 labelText: 'Temperatura esperada',
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
              ) ),
                SizedBox(
                height: 15,
              ),
             TextFormField(decoration: InputDecoration(
                 labelText: 'Temperatura recibida',
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
              ) ),
              
               SizedBox(height: 5),
             
              SizedBox(
                height: 15,
              ),
              Text("Seleccione puerta ingreso",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
               SizedBox(height: 5),
              SizedBox(
                width: 300,
                child: SelectionMenu(
                                      showSelectedItemAsTrigger: true,
                                      itemSearchMatcher: (searchString, item) {
                                        return item.descripInsumo!
                                            .toLowerCase()
                                            .contains(
                                                searchString!.trim().toLowerCase());
                                      },
                                      itemBuilder: (context, item, onItemTapped) {
                                        return Material(
                                          color: Colors.white,
                                          child: InkWell(
                                              onTap: onItemTapped,
                                              child: Padding(
                                                  padding: EdgeInsets.all(10),
                                                  child: Text(
                                                      item.descripInsumo.toString()))),
                                        );
                                      },
                                      itemsList:listpuerta,
                                      onItemSelected: (value) {
                                       
                                      },
                                    ),
              ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                /*  ElevatedButton(
                    style:ElevatedButton.styleFrom(
                    minimumSize: Size(300,60) ),
                    onPressed: () {
                Navigator.pushReplacementNamed(context, "/partidas");
              }, 
                    child:const Text('CONFIRMAR', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)) )*/
                 ]),
         ),
      ),
     
    );
  }
}