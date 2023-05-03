import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/BackgroundPurple.dart';
import 'package:sorfwms/widgets/bottomNavIngresos.dart';
import 'package:sorfwms/widgets/cardContainer.dart';
import 'package:sorfwms/widgets/combosWidget.dart';
import 'package:sorfwms/widgets/regresoRutaScreen.dart';
import 'package:sorfwms/widgets/siguienteRutaScreen.dart';

void main() => runApp(const IngresosIMO());

class IngresosIMO extends StatefulWidget {
  const IngresosIMO({super.key});

  @override
  State<IngresosIMO> createState() => _IngresosIMOState();
}

class _IngresosIMOState extends State<IngresosIMO> {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final lblServicio = TextEditingController();

    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(
      backgroundColor: Colors.blue,
      iconColor: Colors.white,
      menuButtonPressed: () {
        Navigator.pushReplacementNamed(context, "/home");
      },
      searchButtonPressed: () {},
    ),
      body: SingleChildScrollView(
        child: BackgroundScreen(
          name: "IMO",
          child: Stack(
            children: <Widget>[
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
                                children: <Widget>[
                                Row(
                                  children: [
                                    Text('IMO: ', style: GoogleFonts.barlow(fontSize: 20)),
                                    const CombosWidget(
                                        items: [''],
                                        selection: '',
                                        height: 35,
                                        width: 90,
                                  ),
                                  SizedBox(width: 10),
                                  Text('UN:', style: GoogleFonts.barlow(fontSize: 20)),
                                  SizedBox(width: 10),
                                  SizedBox(
                                        width: size.width * 0.2,
                                        height: 35,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                          //  hintText: 'Ingrese la cantidad',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    const SizedBox(width: 10),
                                  Container(
                                      decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Primarycolor,
                                    ),                                  
                                    child: IconButton(
                                       icon: const Icon(Icons.add_sharp),
                                       color: Colors.white,
                                       iconSize: 20,
                                       onPressed: () { 
                                        
                                       },
                                       ),
                                  ),
                                  Container(
                                  child: IconButton(
                                      iconSize: 35,
                                        onPressed: () {
                                        },
                                        icon: const Icon(Icons.remove_circle_outline)),
                                  ),
                                  ],
                                ),
                              ], 
                            ),
                          ),
                        ],
                      ),      
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