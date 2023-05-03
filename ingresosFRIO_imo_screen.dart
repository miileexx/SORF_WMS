import 'package:flutter/material.dart';

class imoFrio extends StatelessWidget {
  const imoFrio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          60.0,
        ),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/detallePartida");
            },
          ),
          title: Text("IMO"),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: Container( 
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                  Text('IMO'),
                  SizedBox(width: 5,),
            Expanded(child: TextFormField(decoration: InputDecoration(border: OutlineInputBorder()))),
            SizedBox(width: 20,),
            Text('UN'),
            SizedBox(width: 5,),
            Expanded(child: TextFormField(decoration: InputDecoration(border: OutlineInputBorder()))),
              ],
            ),
            SizedBox(height: 15,),
           Column(
                    children: [
                         Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('IMO & UN 1'),
                    subtitle: Text('Detalle'),
                  ),
                ],
              ),
            )    ]),
             SizedBox(height: 5,),
           Column(
                    children: [
                         Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('IMO & UN 2'),
                    subtitle: Text('Detalle'),
                  ),
                ],
              ),
            )    ]),
             SizedBox(height: 5,),
           Column(
                    children: [
                         Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('IMO & UN 3'),
                    subtitle: Text('Detalle'),
                  ),
                ],
              ),
            )    ]),
            SizedBox(height: 5,),
           Column(
                    children: [
                         Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('IMO & UN 4'),
                    subtitle: Text('Detalle'),
                  ),
                ],
              ),
            )    ]),
            SizedBox(height: 5,),
           Column(
                    children: [
                         Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text('IMO & UN 5'),
                    subtitle: Text('Detalle'),
                  ),
                ],
              ),
            )    ]),
              ElevatedButton(
                    style:ElevatedButton.styleFrom(
                    minimumSize: Size(300,60) ),
                    onPressed: () {
                Navigator.pushReplacementNamed(context, "/ingresosFrio");
              }, 
                    child:const Text('FINALIZAR', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)) )
                       
          ],
        ),
      ),
    );
  }
}