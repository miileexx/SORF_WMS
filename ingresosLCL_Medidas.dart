import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Login_Form_Provider.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/BackgroundPurple.dart';
import 'package:sorfwms/widgets/Loading.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:sorfwms/widgets/bottomNavIngresos.dart';
import 'package:sorfwms/widgets/buttomNavServicio.dart';
import 'package:sorfwms/widgets/buttonActionCamara.dart';
import 'package:sorfwms/widgets/cardContainer.dart';
import 'package:sorfwms/widgets/regresoHome.dart';
import 'package:sorfwms/widgets/regresoRutaScreen.dart';
import 'package:sorfwms/widgets/siguienteRutaScreen.dart';

void main() => runApp(const IngresosMedidas());

class IngresosMedidas extends StatelessWidget {
  const IngresosMedidas({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: const ButtonCamaraServicio(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ButtomNavServicio(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
      ),
      body: SingleChildScrollView(
        child: BackgroundScreen(
          name: "Medidas",
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: size.height * 0.17),
                  CardContainer(
                    full: true,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                      child: TextFormField(
                                      decoration: InputDecoration(
                                      labelText: 'Largo',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                        ),  
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                      decoration: InputDecoration(
                                      labelText: 'Ancho',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                          )
                                        ),  
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                      child: TextFormField(
                                      decoration: InputDecoration(
                                      labelText: 'Alto',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      )
                                        ),  
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                      decoration: InputDecoration(
                                      labelText: 'Peso',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10)
                                          )
                                        ),  
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0)
                                            )
                                          ),
                                          onPressed: () {
                                          },
                                          child: Icon(Icons.disabled_by_default_rounded),
                                        ),
                                        SizedBox(
                                          width: 246,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0)
                                            ),
                                            backgroundColor: Colors.blue,
                                          ),
                                          onPressed: () {}, 
                                          child: Icon(Icons.api_sharp, color: Colors.white),
                                        
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                          ],
                      )
                  ),
                ],
              ),
              RegresoRutaScreen(context, '/ingresosMatriculas'),
              SiguienteRutaScreen(context, '/ingresosMedidas'),
            ],
          ),
        ),
      ),
    );
  }
}