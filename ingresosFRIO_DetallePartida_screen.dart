import 'package:flutter/material.dart';
import 'package:selection_menu/selection_menu.dart';

class detallePartida  extends StatelessWidget {
  const detallePartida ({super.key});

  @override
  Widget build(BuildContext context) {
    List listpuerta = [];
    List listpuerta2 = [];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          60.0,
        ),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/partidas");
            },
          ),
          title: Text("Detalle Partida"),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
         physics: ClampingScrollPhysics(),
        child: Container(
          height: 1000,
            width: 500,
          padding: EdgeInsets.all(20),
          child: Align(
            child: Column(
              children: [
                 Row(
                  mainAxisAlignment: MainAxisAlignment.center,
               
                   children: [
                     Checkbox(value: true, onChanged:null),
                     Text('Mercancia Bloqueada', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                   ],
                 ),
                 SizedBox(height: 5,),
                 Text('Mercancia:', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                 SizedBox(height: 5,),
                 Expanded(child: TextFormField(decoration: InputDecoration(border: OutlineInputBorder()), )),
                 SizedBox(height: 5,),
                 Text('Puerto Desc.:', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                 SizedBox(height: 5,),
                 Expanded(child: TextFormField(decoration: InputDecoration(border: OutlineInputBorder()), )),
                 SizedBox(height: 5,),
                 Text('Embalaje:', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                 SizedBox(height: 5,),
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
                 SizedBox(height: 5,),
                Text('Marcas:', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                SizedBox(height: 5,),
                 Expanded(child: TextFormField(decoration: InputDecoration(border: OutlineInputBorder()), )),
                 SizedBox(height: 5,),
                   Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 200, child: Text('P.BL:', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                        SizedBox(width: 100, child: Text('BLT TS BL:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                         ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(child: TextFormField(decoration: InputDecoration(border: OutlineInputBorder()), )),
                            SizedBox(width: 10,),
                            Expanded(child: TextFormField(decoration: InputDecoration(border: OutlineInputBorder()), )),
                          ],
                        ), 
                         SizedBox(height: 5,),
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
                                        itemsList:listpuerta2,
                                        onItemSelected: (value) {
                                           },
                                      ),
                ),
                SizedBox(height: 5,),
                Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(value: false, onChanged: null),
                        SizedBox(width: 100, child: Text('Refrijerado',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                        SizedBox(width: 5),
                        Checkbox(value: false, onChanged: null),
                        SizedBox(width: 100, child: Text('Conjelado',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
                         ],
                        ),
                        SizedBox(height: 5,), 
                        ElevatedButton(
                      style:ElevatedButton.styleFrom(
                      minimumSize: Size(300,60) ),
                      onPressed: () {
                  Navigator.pushReplacementNamed(context, "/imoFrio");
                }, 
                      child:const Text('SIGUIENTE', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)) )
                        
              ],
            ),
          ),
        ),
      ),
    );
  }
}