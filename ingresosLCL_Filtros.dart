import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Login_Form_Provider.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/widgets/BackgroundPurple.dart';
import 'package:sorfwms/widgets/Loading.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:sorfwms/widgets/cardContainer.dart';
import 'package:sorfwms/widgets/regresoHome.dart';

void main() => runApp(const IngresosLCL());

class IngresosLCL extends StatelessWidget {
  const IngresosLCL({super.key});

  @override
  Widget build(BuildContext context) {

    final servicios = Provider.of<ServicioProvider>(context);
    final loginForm = Provider.of<LoginFormProvider>(context);
    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);
    final GlobalKey<ExpansionTileCardState> cardA = new GlobalKey();
    final GlobalKey<ExpansionTileCardState> cardB = new GlobalKey();
    final size = MediaQuery.of(context).size;


    if (consultaServicio.servicios.detalleServicio != null) {
      var lista = consultaServicio.servicios.tarja!.partidasMercancia![0].marcas;
      var mercancias = consultaServicio.servicios.tarja!.partidasMercancia![0].mercancia;
    }
    
    if(consultaServicio.FolioServicio > 0 && consultaServicio.servicios.detalleServicio == null ) {  
      consultaServicio.ConsultaServicios();
    }

    if(consultaServicio.isLoading==true){
       return Loading();      
    }

    return Scaffold(
      body: BackgroundScreen(
        name: "Filtros",
        child: Stack(
          children: [
            Positioned(
            top: 40,
            left: 20,
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white),
          child: IconButton(
              onPressed: () =>  Navigator.pushReplacementNamed(context, "/buscarServicio"),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ))),
    ),
            Column(
              children: [
                SizedBox(height: size.height * 0.17),
                CardContainer(
                  full: true,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                                  itemCount: consultaServicio.servicios.tarja!.partidasMercancia![0].partida, // La longitud de tu array
                                  itemBuilder: (BuildContext context, int index) {
                                    // Construye cada elemento ListView con base en el índice
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                          child: ExpansionTileCard(
                                            key: Key('card$index'), // Asigna una clave única a cada tarjeta
                                            leading: CircleAvatar(child: Icon(Icons.inventory, color: Colors.black), backgroundColor: Colors.blueGrey[100],),
                                            title: Text(consultaServicio.servicios.tarja!.partidasMercancia![index].marcas),
                                            children: <Widget>[
                                              Divider(
                                                thickness: 1.0,
                                                height: 1.0,
                                              ),
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                                                  ),
                                                  child: Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              Row(
                                children: <Widget>[
                                  Text(
                                "MERCANCIAS: "+consultaServicio.servicios.tarja!.partidasMercancia![0].mercancia,
                                style: GoogleFonts.barlow(
                                  fontSize: 16,
                                ),
                                ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "EMBALAJE: "+consultaServicio.servicios.tarja!.partidasMercancia![0].embalaje,
                                style: GoogleFonts.barlow(fontSize: 16),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "IMO: "+consultaServicio.servicios.tarja!.partidasMercancia![0].imos.length.toString(),
                                    style: GoogleFonts.barlow(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                                                  ),
                                                ),
                                              ),
                                              ButtonBar(
                                                alignment: MainAxisAlignment.spaceAround,
                                                buttonHeight: 52.0,
                                                buttonMinWidth: 90.0,
                                                children: <Widget>[
                                                  TextButton(
                            style: flatButtonStyle,
                            onPressed: () {
                              // Usamos la clave única para encontrar la tarjeta correspondiente y expandirla
                              cardA.currentState?.expand();
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.warehouse),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('PESO: '+consultaServicio.servicios.tarja!.partidasMercancia![0].peso.toString()),
                              ],
                            ),
                                                  ),
                                                  TextButton(
                            style: flatButtonStyle,
                            onPressed: () {
                              // Usamos la clave única para encontrar la tarjeta correspondiente y cerrarla
                              cardB.currentState?.collapse();
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.workspaces_outline),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('BULTOS: '+consultaServicio.servicios.tarja!.partidasMercancia![0].bultos.toString()),
                              ],
                            ),
                                                  ),
                                                  TextButton(
                            style: flatButtonStyle,
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/ingresosPartidas');
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.navigate_next_outlined),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('Seleccionar')
                              ],
                            ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                          ),
                        ],
                    )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}