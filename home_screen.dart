import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorfwms/Services/almacen_services.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Login_Form_Provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';
import 'package:sorfwms/screens/TokenExpiredSceen.dart';
import 'package:sorfwms/utilities/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late SharedPreferences preferences;
  int _idUsuario = 0;
  String _token = '';
  String _nombreCompleto = '';
  int _idAlmacen = 0;

  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  List<String> cards = [
    "Ingresos",
    "Servicios",
    "Salidas",
    "Pendientes ubicar",
    "Reubicación",
    "Fotografías",
    "Matrícula",
    "Reingresos",
    "Imprimir etiquetas",
    "Inventarios",
    "Etiquetas Rack",
    "Monitor Turnos",
  ];
  List<String> cardsImages = [
    'foto1.png',
    'foto2.png',
    'foto3_disabled.png',
    'foto4_disabled.png',
    'foto5_disabled.png',
    'foto6.png',
    'foto7.png',
    'foto8.png',
    'foto9.png',
    'foto10.png',
    'foto11.png',
    'foto12.png',
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    final loginForm = Provider.of<LoginFormProvider>(context);
    final almacenService = Provider.of<AlmacenServices>(context);
    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);
    final servicios = Provider.of<ServicioProvider>(context);

    if (Ajustes.TokenExpired) {
      return TokenExpiredScreen();
    }

    return Scaffold(
        key: _key,
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
            60.0,
          ),
          child: AppBar(
            leading: InkWell(
              child: const Icon(
                Icons.exit_to_app,
                color: Colors.black,
              ),
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                String URL = Ajustes.URL;
                String Catalogos = Ajustes.ApiCatalogos;
                String Operaciones = Ajustes.ApiOperaciones;
                String Autenticacion = Ajustes.APIAutenticacion;

                preferences.clear();

                Ajustes.URL = URL;
                Ajustes.APIAutenticacion = Autenticacion;
                Ajustes.ApiCatalogos = Catalogos;
                Ajustes.ApiOperaciones = Operaciones;

                loginForm.User = "";
                loginForm.Pass = "";
                Navigator.pushReplacementNamed(context, "/login");
              },
            ),
            title: Text(
              "Bienvenido(a) " + _nombreCompleto,
              style: GoogleFonts.roboto(
                  textStyle: const TextStyle(
                      fontSize: 18, letterSpacing: 1, color: Colors.black)),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          // implement GridView.builder
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 180,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              itemCount: cards.length,
              itemBuilder: (BuildContext ctx, index) {
                return Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: cards[index] == "Fotografías" ||
                                cards[index] == "Servicios" || cards[index] == "Ingresos"
                            ? HexColor('#ADD8E6')
                            : HexColor('#BDC3C7'),
                        borderRadius: BorderRadius.circular(15)),
                    child: cards[index] == "Fotografías" ||
                            cards[index] == "Servicios" || cards[index] == "Ingresos"
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(40),
                                backgroundColor: Colors.transparent,
                                elevation: 0),
                            onPressed: () {
                              if (cards[index] == 'Fotografías') {
                                consultaServicio.ingreso == false;
                                Navigator.pushReplacementNamed(
                                    context, "/buscarServicio");
                              }
                              if (cards[index] == 'Servicios') {
                                servicios.listaServicios=[];
                                servicios.PendienteRecolectar=false;
                                OverlayLoadingProgress.start(context);
                                Navigator.pushReplacementNamed(
                                    context, "/servicio");
                              }
                              if (cards[index] == 'Ingresos') {
                                Navigator.pushReplacementNamed(context, "/ingresoScreen");
                              }
                            },
                            child: Column(children: [
                              SizedBox(height: 25),
                              Container(
                                width: 120,
                                height: 90,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(0),
                                    child: Image.asset(
                                      "assets/images/" + cardsImages[index],
                                      width: 100,
                                      height: 100,
                                    )),
                              ),
                              SizedBox(height: 13),
                              Text(
                                cards[index],
                                textAlign: TextAlign.center,
                                style: GoogleFonts.barlow(
                                  textStyle: TextStyle(
                                      color: Colors.black, fontSize: 21),
                                ),
                              ),
                            ]),
                          )
                        : Column(children: [
                            SizedBox(height: 25),
                            Container(
                              width: 120,
                              height: 90,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(0),
                                  child: Image.asset(
                                    "assets/images/" + cardsImages[index],
                                    width: 100,
                                    height: 100,
                                  )),
                            ),
                            SizedBox(height: 13),
                            Text(
                              cards[index],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.barlow(
                                textStyle: TextStyle(
                                    color: Colors.black, fontSize: 21),
                              ),
                            ),
                          ]));
              }),
        ));
  }

  getSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      _idUsuario = preferences.getInt("idUsuario") ?? 0;
      _token = preferences.getString("token") ?? '';
      _nombreCompleto = preferences.getString("nombreCompleto") ?? '';
      _idAlmacen = preferences.getInt("idAlmacen") ?? 0;
    });
  }

  deleteSharedPreferences() async {
    preferences = await SharedPreferences.getInstance();
    String URL = Ajustes.URL;
    String Catalogos = Ajustes.ApiCatalogos;
    String Operaciones = Ajustes.ApiOperaciones;
    String Autenticacion = Ajustes.APIAutenticacion;

    preferences.clear();

    Ajustes.URL = URL;
    Ajustes.APIAutenticacion = Autenticacion;
    Ajustes.ApiCatalogos = Catalogos;
    Ajustes.ApiOperaciones = Operaciones;
    setState(() {
      _idUsuario = 0;
    });
  }
}
