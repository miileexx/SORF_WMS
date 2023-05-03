import 'package:flutter/material.dart';

import '../widgets/BackgroundPurple.dart';
import '../widgets/cardContainer.dart';
import '../widgets/regresoRutaScreen.dart';
import '../widgets/siguienteRutaScreen.dart';
import 'anexo_screen.dart';

class IngresosFrioScreen extends  StatelessWidget {
  const IngresosFrioScreen ({super.key});
  
  
  @override
  Widget build(BuildContext context){
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackgroundScreen(
        name: "Ingresos Frio",
        child: Stack( 
          children: [
            Column(
              children: [ 
                SizedBox(height: size.height*0.18),
                CardContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: btningresoFrio(),
                  )
                ),
              ],
            ),
        
            RegresoRutaScreen(context, '/home'),
            //SiguienteRutaScreen(context, '/i'),
          ],
        ),
      ),
    );
     
    
  }
}

class btningresoFrio extends StatelessWidget {
  const btningresoFrio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
       child: Center(

        child: Container(
          padding: EdgeInsets.all(20),
          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
            ElevatedButton(
              style:ElevatedButton.styleFrom(
              minimumSize: Size(300,90) ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/temperaturaRecibida");
              }, 
              child: const Text('CONFIRMAR INGRESOS n DE n',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))),
              const SizedBox(
                
                height: 40.0,
              ),
              ElevatedButton(
                style:ElevatedButton.styleFrom(
                minimumSize: Size(300,90) ),
                onPressed: null,
                child:const Text('TERMINAR SERVICIO',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)) )
          ]),
        ),
      ),
     
    );
  }
}