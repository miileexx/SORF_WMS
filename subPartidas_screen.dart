import 'package:flutter/material.dart';
import 'package:selection_menu/selection_menu.dart';

class SubPartidas extends StatelessWidget {
  const SubPartidas ({super.key});

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
          title: Text("Ingreso Subpartida"),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Align(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(value: true, onChanged:null),
                    Text('DESCARGADO', style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 5,),
                 SizedBox(
                  height: 50,
                  child: Text('PAN REPOSTERIA, PASTELES BISCUIS...')),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 200, child: Text('P.BL:', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                      SizedBox(width: 100, child: Text('BLT BL:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
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
                      Row(
                        children: [
                          Checkbox(value: false, onChanged:null),
                          Text('Refrigerado', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                          SizedBox(width: 60,),
                          Checkbox(value: false, onChanged:null),
                          Text('Congelado', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        ],
                      ),
                        Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 200, child: Text('BULTOS:', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),)),
                      SizedBox(width: 100, child: Text('PESO:',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
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
                       SizedBox(
                height: 15,
              ),
              Text("Embalaje Recinto",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Checkbox(value: false, onChanged:null),
                              Text('Averia', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text('Observaciones de averia',style: TextStyle(fontSize: 18,) ),
                          SizedBox(height: 5,),
                          TextFormField(decoration: InputDecoration(border: OutlineInputBorder()), ),
                          SizedBox(height: 10,),
                           ElevatedButton(
                    style:ElevatedButton.styleFrom(
                    minimumSize: Size(300,60) ),
                    onPressed: () {
                Navigator.pushReplacementNamed(context, "/frioLote");
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