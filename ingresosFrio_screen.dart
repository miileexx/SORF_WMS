import 'package:flutter/material.dart';

class IngresosFrioScreen extends  StatelessWidget {
  const IngresosFrioScreen ({super.key});
  
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
       appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          60.0,
        ),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
          ),
          title: Text("Ingresos FRIO"),
          backgroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: 
      Align(

        child: Container(
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            ElevatedButton(
              style:ElevatedButton.styleFrom(
              minimumSize: Size(300,60) ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/temperaturaRecibida");
              }, 
              child: const Text('CONFIRMAR INGRESOS 0 DE 6',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))),
              const SizedBox(
                
                height: 20.0,
              ),
              ElevatedButton(
                style:ElevatedButton.styleFrom(
                minimumSize: Size(300,60) ),
                onPressed: null,
                child:const Text('Terminar servicio',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)) )
          ]),
        ),
      ),
    );
  }
}