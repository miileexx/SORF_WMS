import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
     body: Center(
       child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
       mainAxisSize: MainAxisSize.min,
       children: const [
        SizedBox(
           width: 150,
           height: 150,
           child: Image(
            
            image:AssetImage(
             ("assets/images/montacargas.gif"))),
         ),
         SizedBox(height: 20,),
         Text('Cargando...',
         style:  TextStyle(
          fontSize: 24
         ),
          ),
       ],
      ),
     ),
    );
  }
}
