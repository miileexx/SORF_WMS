import 'package:cross_scroll/cross_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/PendientesUbicarProvider.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';
import 'package:sorfwms/providers/Login_Form_Provider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ServiciosScreen extends StatefulWidget {
  @override
  State<ServiciosScreen> createState() => _ServiciosScreenState();
}

var searchController = TextEditingController();

class _ServiciosScreenState extends State<ServiciosScreen> {
  Widget build(BuildContext context) {
    return ServicioScreenContainer();
  }
}

class ServicioScreenContainer extends StatefulWidget {
  const ServicioScreenContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<ServicioScreenContainer> createState() =>
      _ServicioScreenContainerState();
}

class _ServicioScreenContainerState extends State<ServicioScreenContainer> {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final servicios = Provider.of<ServicioProvider>(context);
    final pendUbicProvider = Provider.of<PendientesUbicarProvider>(context);
    final size = MediaQuery.of(context).size;

    var recolectados = false;
    var iniciar = false;

    if (servicios.isLoading == false) {
      OverlayLoadingProgress.stop();
    }
    Future<String> scanBarcodeFolioServicio() async {
    String barcodeScanRes;
    try {

      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      return barcodeScanRes;
    } catch (e) {
      return '';
    }
  }
  

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          60.0,
        ),
        child: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/home");
            },
          ),
          title: Text(
            "Usuario: " + loginForm.User,
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(fontSize: 18, color: Colors.black)),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: TextFormField(
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (Value) {
                     servicios.BuscarServicioTabla(Value);
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(28)),
                    borderSide: BorderSide(color: Colors.black)),
                  filled: true,
                  fillColor: HexColor('#E6E6E3'),
                  border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                  
                  ),
                  
                  labelText: 'Buscar',
                  labelStyle: TextStyle(color: Colors.black),              
                  suffixIcon: IconButton( 
                    icon: Icon(Icons.center_focus_weak_sharp, color: Colors.black),
                    onPressed: () async{
                      servicios.BuscarServicioTabla(await scanBarcodeFolioServicio());                              
                    },
                  )
                 )

                ),
              ),
            ),
            SizedBox(
                height: size.height * 0.65,
                width: size.width,
                child: CrossScroll(
                  hoverColor: Colors.transparent,
                  dimColor: Colors.transparent,
                  child: Container(
                    child: DataTable(
                        showCheckboxColumn: false,
                        columnSpacing: 16.0,
                        columns: [
                          DataColumn(
                              label: Text('Folio',
                                  style: GoogleFonts.barlow(
                                      textStyle: kRowStyle))),
                          DataColumn(
                              label: Text('Bultos',
                                  style: GoogleFonts.barlow(
                                      textStyle: kRowStyle))),
                          DataColumn(
                              label: Text('IMO',
                                  style: GoogleFonts.barlow(
                                      textStyle: kRowStyle))),
                          DataColumn(
                              label: Expanded(
                            child: Text(
                              'Estatus',
                              style: GoogleFonts.barlow(textStyle: kRowStyle),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataColumn(
                              label: Expanded(
                            child: Text(
                              'Identificación',
                              style: GoogleFonts.barlow(textStyle: kRowStyle),
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataColumn(
                              label: Text('Embalaje',
                                  style: GoogleFonts.barlow(
                                      textStyle: kRowStyle))),
                        ],
                        rows: List.generate(servicios.listaServicios.length,
                            (index) {
                          return DataRow(
                              selected: servicios.selecciones[index],
                              onSelectChanged: ((value) {
                                servicios.cambiarSeleccion(index, value!);
                                servicios.FolioServicio = servicios
                                    .listaServicios[index].folioServicio!;
                                servicios.claveUsuario = servicios
                                    .listaServicios[index].claveUsuario!;
                                servicios.bultosPiso =
                                    servicios.listaServicios[index].bultosPiso!;
                                servicios.totalBultos = servicios
                                    .listaServicios[index].totalBultos!;
                              }),
                              cells: [
                                DataCell(Center(
                                    child: (Text(
                                        servicios
                                            .listaServicios[index].folioServicio
                                            .toString()
                                            .split('.')[0],
                                        style: GoogleFonts.roboto(
                                            textStyle: kColumnStyle))))),
                                DataCell(Center(
                                    child: (Text(
                                        '${servicios.listaServicios[index].totalBultos}/${servicios.listaServicios[index].bultosPiso}',
                                        style: GoogleFonts.roboto(
                                            textStyle: kColumnStyle))))),
                                DataCell(Center(
                                    child: (Text(
                                        servicios.listaServicios[index]
                                                    .peligroso ==
                                                true
                                            ? 'Sí'
                                            : 'No',
                                        style: GoogleFonts.roboto(
                                            textStyle: kColumnStyle))))),
                                DataCell(Center(
                                    child: (Text(
                                        (servicios.listaServicios[index]
                                                        .estatusServicio ??
                                                    0) ==
                                                3
                                            ? servicios.listaServicios[index]
                                                        .totalBultos ==
                                                    servicios
                                                        .listaServicios[index]
                                                        .bultosPiso
                                                ? "Recolectado"
                                                : "En recolección"
                                            : returnvalorEstatus(servicios
                                                .listaServicios[index]
                                                .estatusServicio),
                                        style: GoogleFonts.roboto(
                                            textStyle: kColumnStyle))))),
                                DataCell(Center(
                                    child: (Text(
                                        servicios.listaServicios[index]
                                            .bultosPartidas
                                            .toString(),
                                        style: GoogleFonts.roboto(
                                            textStyle: kColumnStyle))))),
                                DataCell(Center(
                                    child: (Text(
                                        servicios.listaServicios[index]
                                            .embalajePartida
                                            .toString(),
                                        style: GoogleFonts.roboto(
                                            textStyle: kColumnStyle))))),
                              ]);
                        })),
                  ),
                )),
            Container(
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                checkColor: Colors.white,
                value: servicios.PendienteRecolectar,
                onChanged: (value) {
                  if (servicios.isLoading == false) {
                    OverlayLoadingProgress.start(context,
                        barrierDismissible: false);
                  }
                  if (servicios.isLoading == true) {
                    OverlayLoadingProgress.stop();
                  }
                  servicios.PendienteRecolectar = value!;
                },
                title: Text(
                  'Todos los pendientes de recolección.',
                  style: GoogleFonts.roboto(fontSize: 18),
                ),
              ),
            ),
            Container(
                child: Column(
              children: <Widget>[
                Row(
                  children: [
                    const SizedBox(
                      height: 50,
                      width: 95,
                    ),
                    ButtonTheme(
                      minWidth: 50.0,
                      height: 50.0,
                      child: OutlinedButton(
                          onPressed: () {
                            if(servicios.bultosPiso==servicios.totalBultos){
                              iniciar = true;
                            } if (servicios.FolioServicio > 0&&iniciar==true) {
                              if (Ajustes.IdAlmacen == 2) {
                                if (servicios.bultosPiso > 0) {
                                } else {
                                  if (servicios.bultosPiso == 0 &&
                                      servicios.totalBultos == 0) {
                                  } else {
                                    _iniciarDescargas(context);
                                  }
                                }
                              } else {
                                _servicioNoAsignado(context);
                              }
                              showMaterialModalBottomSheet(
                                  context: context,
                                  builder: (context) => const Modal());
                            } else {
                              _noRecolectados(context);
                            }
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: HexColor('#ADD8E6'),
                          ),
                          child: Text('Iniciar',
                              style: GoogleFonts.barlow(
                                  textStyle: const TextStyle(
                                      color: Colors.black, fontSize: 20)))),
                    ),
                    const SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (servicios.bultosPiso == servicios.totalBultos) {
                            recolectados = true;
                          }
                          if (servicios.FolioServicio != 0 &&
                              recolectados == false) {
                            OverlayLoadingProgress.start(context);
                            pendUbicProvider.FolioServicio =
                                servicios.FolioServicio;
                            pendUbicProvider.matriculasSeleccionadas = [];
                            pendUbicProvider.posicion = '';
                            pendUbicProvider.matricula = '';
                            pendUbicProvider.RecolecionIniciada =
                                servicios.RecoleccionIniciada;
                            await pendUbicProvider.obtenMatriculasPrevio();
                            OverlayLoadingProgress.stop();
                            Navigator.pushNamed(context, '/pendientesUbicar');
                          } else {
                            _recolectados(context);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          disabledBackgroundColor: HexColor('#BDC3C7'),
                          backgroundColor: HexColor('#BDC3C7'),
                        ),
                        child: Text('Recolectar',
                            style: GoogleFonts.barlow(
                                textStyle: const TextStyle(
                                    color: Colors.black, fontSize: 20)))),
                  ],
                )
              ],
            )),
          ],
        ),
      ),
    );
  }
}

Future<void> _servicioNoAsignado(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Servicio no asignado para este usuario.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _noRecolectados (context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('SORFWMS'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Los bultos aún no están recolectados.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _recolectados(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('SORFWMS'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Los bultos ya están recolectados.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _seleccionarFolio(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Selecciona un folio de servicio para continuar.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _iniciarDescargas(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                  'Para poder iniciar debes descargar al menos un bulto de almacén a piso.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _servicioIniciado(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('SORFWMS'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                  'Este servicio ya se había iniciado.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<void> _folioNoExiste(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('SORFWMS'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text(
                  'Este folio de servicio no existe en el sistema.'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


class Modal extends StatefulWidget {
  const Modal({
    Key? key,
  }) : super(key: key);

  @override
  State<Modal> createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  String _scanBarcode = 'Escanea un folio';
  bool validar = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      validar = true;
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Error';
    }
    if (!mounted) return;
    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final servicios = Provider.of<ServicioProvider>(context);
    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);

    return Container(
      height: 450,
      width: 200,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 30,
            width: 50,
          ),
          Text(
            'Selecciona el tipo de servicio:',
            style: GoogleFonts.barlow(
                textStyle: const TextStyle(color: Colors.black, fontSize: 20)),
          ),
          const SizedBox(
            height: 10,
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              textInputAction: TextInputAction.go,
              controller: searchController,
              decoration: InputDecoration(
                  hintText: _scanBarcode != true
                      ? _scanBarcode.toString()
                      : 'Escanea un folio',
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
                  contentPadding: const EdgeInsets.only(right: 30),
                  prefixIcon: const Padding(
                    padding:  EdgeInsets.only(right: 10.0, left: 05.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.document_scanner,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      scanBarcodeNormal();
                    },
                  )),
            ),
          ),
          ListTile(
            leading: Radio(
              value: 1,
              groupValue: servicios.SelectedGender,
              onChanged: (value) {
                servicios.SelectedGender = value!;
              },
            ),
            title: const Text('Consolidación'),
          ),
          ListTile(
            leading: Radio(
              value: 2,
              groupValue: servicios.SelectedGender,
              onChanged: (value) {
                servicios.SelectedGender = value!;
              },
            ),
            title: const Text('Liberación'),
          ),
          ListTile(
            leading: Radio(
              value: 3,
              groupValue: servicios.SelectedGender,
              onChanged: (value) {
                servicios.SelectedGender = value!;
              },
            ),
            title: const Text('Previos/Desco'),
          ),
          Container(
            margin: EdgeInsets.all(10),
            width: 350,
            height: 50,
            child: Align(
              alignment: Alignment.topRight,
              child: FloatingActionButton(
                // ignore: prefer_const_constructors
                backgroundColor: HexColor('#ADD8E6'),
                child: Icon(
                  Icons.navigate_next,
                  color: Colors.black54,
                  size: 30,
                ),
                onPressed: () async{
                  if (_scanBarcode != 'Escanea un folio') {
                    servicios.folioCapturado = _scanBarcode;
                  } else {
                    servicios.folioCapturado = searchController.text;
                  }
                  await servicios.IniciarServicio();

                  if(servicios.Estatus==0||servicios.Estatus==58){
                    servicios.Estatus==58 ? _servicioIniciado(context) : 
                    consultaServicio.isLoading = true;
                    consultaServicio.servicios.detalleServicio = null;
                    consultaServicio.FolioServicio = servicios.FolioServicio;
                    consultaServicio.Consolidacion =
                    servicios.SelectedGender == 1 ? true : false;
                    OverlayLoadingProgress.start(context);
                    Navigator.pushNamed(context, '/detalleServicio');
                  } 
                  else {
                    _folioNoExiste(context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  }

returnvalorEstatus(int? estatusServicio) {
  switch (estatusServicio) {
    case 0:
      return "Ninguno";
    case 1:
      return "Iniciado";
    case 2:
      return "Terminado";
    case 3:
      return "Pendiente";
  }


}
