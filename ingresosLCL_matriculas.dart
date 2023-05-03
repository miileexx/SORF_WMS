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

void main() => runApp(const IngresosMatriculas());

class IngresosMatriculas extends StatefulWidget {
  const IngresosMatriculas({super.key});

  @override
  State<IngresosMatriculas> createState() => _IngresosMatriculasState();
}

class _IngresosMatriculasState extends State<IngresosMatriculas> {
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
          name: "Matrículas",
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
                                      const Text(
                                        'Cant:',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
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
                                      const SizedBox(
                                    width: 10,
                                  ),
                                 const CombosWidget(
                                        items: [''],
                                        selection: '',
                                        height: 35,
                                        width: 130,
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 2,
                                child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: TextFormField(
                                  controller: lblServicio,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Buscar',
                                    hintStyle: const TextStyle(fontSize: 16),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[100],
                                    contentPadding: const EdgeInsets.only(right: 10),
                                    prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 5.0),
                                        child: IconButton(
                                          icon: const Icon(Icons.qr_code_scanner),
                                          color: Colors.black,
                                          onPressed: () async {
                                          },
                                        ),
                                      ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.search, color: Colors.black),
                                      onPressed: () async {
                                      },
                                    ),
                                  ),
                                )
                              ),
                              ),
                            ], 
                          ),
                        ),
                      ],
                    ),      
                  ),    
                ],
              ),
              RegresoRutaScreen(context, '/ingresosPartidas'),
              SiguienteRutaScreen(context, '/ingresosIMO'),
            ],
          ),
        ),
      ),
    );
  }
}