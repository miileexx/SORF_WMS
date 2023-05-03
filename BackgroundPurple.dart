import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorfwms/widgets/cardBar.dart';

class BackgroundScreen extends StatelessWidget {
  final Widget child;
  String name;

  BackgroundScreen({Key? key, required this.child,required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
        child: Stack(
          children: [
            CardBar(),
             Column(
               children: [              
                 NombreCard(name: name),             
               ],
             ),
            
            this.child,
      
            
          ],
        ),
      
    );
  }
}

class NombreCard extends StatelessWidget {
  const NombreCard({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;

    return 
    Container(
       width: double.infinity,
       height: size.height*0.15,
       margin: EdgeInsets.all(20),
       child: Center(
         child: Text(
           name,
           style: GoogleFonts.lato(
             textStyle: TextStyle(
                 color: Colors.white,
                 fontSize: 30,
                 fontWeight: FontWeight.bold),
           ),
         ),
       ),
     );
  }
}
