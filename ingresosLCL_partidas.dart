import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/BackgroundPurple.dart';
import 'package:sorfwms/widgets/bottomNavIngresos.dart';
import 'package:sorfwms/widgets/cardContainer.dart';
import 'package:sorfwms/widgets/combosWidget.dart';
import 'package:sorfwms/widgets/regresoRutaScreen.dart';
import 'package:sorfwms/widgets/siguienteRutaScreen.dart';

void main() => runApp(const IngresosPartidas());

class IngresosPartidas extends StatefulWidget {
  const IngresosPartidas({super.key});

  @override
  State<IngresosPartidas> createState() => _IngresosPartidasState();
}

class _IngresosPartidasState extends State<IngresosPartidas> {
  @override
  Widget build(BuildContext context) {

    FocusNode txtServicio = new FocusNode();
    FocusNode txtTarja = new FocusNode();
    FocusNode txtAA = new FocusNode();
    FocusNode txtGafete = new FocusNode();
    FocusNode txtObservacion = new FocusNode();

    final size = MediaQuery.of(context).size;
    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);
    FocusNode focusMinutos = new FocusNode();

    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(
      backgroundColor: Colors.blue,
      iconColor: Colors.white,
      menuButtonPressed: () {},
      searchButtonPressed: () {},
    ),
      body: BackgroundScreen(
        name: "Partidas",
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
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
                              const SizedBox(height: 17),
                                TextFormField(
                                initialValue: consultaServicio.servicios.tarja!.partidasMercancia![0].mercancia ?? '',
                                textInputAction: TextInputAction.next,
                                style: GoogleFonts.openSans(
                                          fontSize: 16
                                        ),
                                decoration: DecorationFormSettingsPartidas(txtAA, '', 'Mercancía'),
                                onChanged: (value) {
                                // oServicio.detalleServicio?.responsableAgencia = value;
                                },
                              ),
                              const SizedBox(height: 18),
                              TextFormField(
                                initialValue: consultaServicio.servicios.tarja!.partidasMercancia![0].puertoDestino ?? '',
                                textInputAction: TextInputAction.next,
                                style: GoogleFonts.openSans(
                                          fontSize: 16
                                        ),
                                decoration: DecorationFormSettingsPartidas(txtAA, '', 'Puerto Des'),
                                onChanged: (value) {
                                // oServicio.detalleServicio?.responsableAgencia = value;
                                },
                              ),
                              const SizedBox(height: 18),
                              TextFormField(
                                initialValue: consultaServicio.servicios.tarja!.partidasMercancia![0].embalaje ?? '',
                                textInputAction: TextInputAction.next,
                                style: GoogleFonts.openSans(
                                          fontSize: 16
                                        ),
                                decoration: DecorationFormSettingsPartidas(txtAA, '', 'Embalaje:'),
                                onChanged: (value) {
                                // oServicio.detalleServicio?.responsableAgencia = value;
                                },
                              ),
                              const SizedBox(height: 18),
                              TextFormField(
                                initialValue: consultaServicio.servicios.tarja!.partidasMercancia![0].marcas,
                                textInputAction: TextInputAction.next,
                                style: GoogleFonts.openSans(
                                          fontSize: 16
                                        ),
                                decoration: DecorationFormSettingsPartidas(txtGafete, '', 'Marcas:'),
                                onChanged: (value) {
                                  //oServicio.detalleServicio?.gafeteRespAa = value;
                                },
                              ),
                              const SizedBox(
                                    height: 18,
                                  ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: 
                                      TextFormField(
                                        initialValue: consultaServicio.servicios.tarja!.partidasMercancia![0].peso.toString(),
                                        textInputAction: TextInputAction.next,
                                        style: GoogleFonts.openSans(
                                          fontSize: 16
                                        ),
                                        decoration:
                                            DecorationFormSettingsPartidas(txtObservacion, '', 'Peso'),
                                        onChanged: (value) {
                                          //oServicio.detalleServicio?.observaciones = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 1.0),
                                      child: TextFormField(
                                        initialValue: consultaServicio.servicios.tarja!.partidasMercancia![0].bultos.toString(),
                                        style: GoogleFonts.openSans(
                                          fontSize: 16
                                        ),
                                        textInputAction: TextInputAction.next,
                                        decoration:
                                            DecorationFormSettingsPartidas(txtObservacion, '', 'Bultos'),
                                        onChanged: (value) {
                                          //oServicio.detalleServicio?.observaciones = value;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text('Unidad de Medida', style: GoogleFonts.barlow(
                                      fontSize: 18,
                                    )
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const CombosWidget(
                                    items: ['Kilogramo', 'Gramo', 'Miligramo', 'Tonelada'],
                                    selection: 'Kilogramo',
                                    width: 115,
                                  ),
                                const SizedBox(width: 5),
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
                                      iconSize: 40,
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
            ),
            RegresoRutaScreen(context, '/ingresosFiltros'),
            SiguienteRutaScreen(context, '/ingresosMatriculas'),
          ],
        ),
      ),
    );
  }
}
