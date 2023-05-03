import 'package:flutter/material.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';

class temperaturaRecibidaScreen  extends StatelessWidget {
  const temperaturaRecibidaScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    List listpuerta = [];
    return Scaffold(
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          60.0,
        ),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/ingresosFrio");
            },
          ),
          title: Text("Temperatura Recibida"),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body:SingleChildScrollView(
        child: Align( child:
         Container(
          
          padding: EdgeInsets.all(20),
           child: Column(children: [
              Text("Folio de Servicio", style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              Text("123456789",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              Text("Sello origen", style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              TextFormField(decoration: InputDecoration(border: OutlineInputBorder()), ),
              SizedBox(
                height: 15,
              ),
              Text("Temperatura esperada",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
               SizedBox(height: 5),
              TextFormField(
                decoration: InputDecoration( border: OutlineInputBorder(),),
               ),
              SizedBox(
                height: 15,
              ),
              Text("Temperatura recibida",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
               SizedBox(height: 5),
              TextFormField( decoration: InputDecoration(border: OutlineInputBorder()),),
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
                                  ElevatedButton(
                    style:ElevatedButton.styleFrom(
                    minimumSize: Size(300,60) ),
                    onPressed: () {
                Navigator.pushReplacementNamed(context, "/partidas");
              }, 
                    child:const Text('CONFIRMAR', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)) )
        ]),
         ),
        
        ),
      ),
    );
  }
}