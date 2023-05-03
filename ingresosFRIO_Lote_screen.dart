import 'package:flutter/material.dart';
import 'package:selection_menu/selection_menu.dart';

class LoteFrio extends StatelessWidget {
  const LoteFrio({super.key});

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
              Navigator.pushReplacementNamed(context, "/partidas");
            },
          ),
          title: Text("Lote"),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Align(
            child:Column(children: [
                      Text('Lote',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                      TextFormField( decoration: InputDecoration(border: OutlineInputBorder()),),
                      SizedBox(height: 10,),
                      Text('Lotes',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                      SizedBox(height: 5,),
                     SizedBox(
                      height: 110,
                       child: Container(
                        color: Colors.grey[300],
                        padding: EdgeInsets.all(5),
                         child: SingleChildScrollView(
                           child: Column(
                             children: [
                               Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text('LOTE 1'),
                                            subtitle: Text('Información'),
                                          ),
                                        ],
                                      ),
                                    ),
                                     Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text('LOTE 2'),
                                            subtitle: Text('Información'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Card(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ListTile(
                                            title: Text('LOTE 3'),
                                            subtitle: Text('Información'),
                                          ),
                                        ],
                                      ),
                                    ),
                             ],
                           ),
                         ),
                       ),
                     ),
                        
                          SizedBox(height: 10,),
                      Row(
                        children: [
                          Text('Caducidad',style: TextStyle(fontSize: 16)),
                          SizedBox(width: 10,),
                          Text('dd/mm/aaaa ',style: TextStyle(fontSize: 16)),
                        ],
                      ),
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
                SizedBox(height: 10,),
                Text('Caducidad',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                      SizedBox(height: 5,),
                SizedBox(height: 110,
                  child: Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.all(5),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                                  child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text('Caducidad 1'),
                              subtitle: Text('DD/MM/AAAA'),
                            ),
                          ],
                                  ),
                                ),
                                 Card(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                      ListTile(
                        title: Text('Caducidad 2'),
                        subtitle: Text('DD/MM/AAAA'),
                      ),
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
            
                  ),
                ),
           
                       SizedBox(
                                      height: 15,
                                    ),
                                    ElevatedButton(
                      style:ElevatedButton.styleFrom(
                      minimumSize: Size(300,60) ),
                      onPressed: () {
                  Navigator.pushReplacementNamed(context, "/ingresosFrio");
                }, 
                      child:const Text('FINALIZAR', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)) )
            ],),
          ),
        ),
      ),
    );
  }
}