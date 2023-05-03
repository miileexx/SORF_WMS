import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/widgets/cardContainer.dart';

void main() => runApp(const IngresosScreen());

class IngresosScreen extends StatelessWidget {
  const IngresosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);
    final servicios = Provider.of<ServicioProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ingresos',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: () { 
            consultaServicio.ingreso = false;
            Navigator.pushReplacementNamed(context, "/home");
           },),
          title: Text('Ingresos',
          style: GoogleFonts.roboto(
                textStyle: const TextStyle(fontSize: 18, color: Colors.black)),
          ),
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
                color: HexColor('#ADD8E6'),
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/buscarServicio");
                    consultaServicio.ingreso = true;
                  },
                  child: SizedBox(
                    width: 180.0,
                    height: 180.0,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          "assets/images/desco.png",
                          width: 60,
                          height: 60,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                      child: Text('Desc/Separación/SUDDIV', textAlign: TextAlign.center,
                        style: GoogleFonts.barlow(
                          textStyle: const TextStyle(fontSize: 17, color: Colors.black)),
                      ),
                    ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
                color: HexColor('#ADD8E6'),
                child: InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 180.0,
                    height: 180.0,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Image.asset(
                          "assets/images/expo.png",
                          width: 70,
                          height: 70,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                      child: Text('Exportación', textAlign: TextAlign.center,
                        style: GoogleFonts.barlow(
                          textStyle: const TextStyle(fontSize: 18, color: Colors.black)),
                      ),
                    ),
                      ],
                    ),
                  ),
                ),
              ),
            ]
          ),
          ],
        ),
        
      ),
    );
  }
}
