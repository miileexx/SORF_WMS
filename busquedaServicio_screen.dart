import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/Services/fotografia_service.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';
import 'package:sorfwms/widgets/regresoHome.dart';
import 'package:sorfwms/widgets/widgets.dart';

class BusquedaServicioScreen extends StatefulWidget {
  @override
  State<BusquedaServicioScreen> createState() => _BusquedaServicioScreenState();
}

class _BusquedaServicioScreenState extends State<BusquedaServicioScreen> {
  String _scanBarcode = 'Escanea un folio';
  bool validar = false;

  @override
  void initState() {
    super.initState();
  }

  Future<double> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      validar = true;

      return double.parse(barcodeScanRes);
    } catch (e) {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);
    final providerFoto = Provider.of<FotografiaServices>(context);
    final size = MediaQuery.of(context).size;
    final lblServicio = TextEditingController(
        text: "${consultaServicio.FolioServicio.toString().split(".")[0]}");

    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundScreen(
            name: "Buscar Servicio",
            child: Stack(
              children: [
                regresarRutaHome(context),
                Column(
                  children: [
                    SizedBox(height: size.height * 0.17),
                    CardContainer(
                      full: true,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Text(
                                "Servicio",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextFormField(
                                  controller: lblServicio,
                                  keyboardType: TextInputType.number, 
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      consultaServicio.FolioServicio =
                                          double.parse(value);
                                    }
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
                                      contentPadding: const EdgeInsets.only(
                                        right: 30,
                                      ),
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10.0, left: 5.0),
                                        child: IconButton(
                                          icon: const Icon(Icons.qr_code_scanner),
                                          color: Colors.black,
                                          onPressed: () async {
                                            consultaServicio.FolioServicio =
                                                await scanBarcodeNormal();
                                          },
                                        ),
                                      ),
                                      suffixIcon: IconButton(
                                          icon: const Icon(Icons.search,
                                              color: Colors.black),
                                          onPressed: () async {

                                            OverlayLoadingProgress.start(context,
                                                barrierDismissible: false);
                                          
                                            if (_scanBarcode !=
                                                'Escanea un folio') {
                                              consultaServicio.FolioServicio =
                                                  double.parse(_scanBarcode);
                                            }
                                            if (consultaServicio.FolioServicio !=
                                                0) {
                                              consultaServicio.Consolidacion =
                                                  false;
                                              consultaServicio.ObtenerDetalle =
                                                  true;
                                              await consultaServicio
                                                  .ConsultaServicios();
                                              OverlayLoadingProgress.stop();
                                              if (consultaServicio.servicios
                                                      .detalleServicio !=
                                                  null) {
                                                var servicioAnterior = providerFoto.folioServicio;
                                                providerFoto.folioServicio =
                                                    consultaServicio
                                                        .servicios
                                                        .detalleServicio!
                                                        .folioServicio!
                                                        .toString();
                                                providerFoto.tarja =
                                                    consultaServicio.servicios
                                                            .tarja!.tarja ??
                                                        0;
                                                providerFoto.busquedaServicio =
                                                    true;
                                                    if(servicioAnterior != providerFoto.folioServicio){
                                                    providerFoto.ListaFotografia.clear();
                                                    }
                                                     
                                                consultaServicio.ingreso == true ? Navigator.pushReplacementNamed(
                                                    context, "/ingresosFiltros") : Navigator.pushReplacementNamed(
                                                    context, "/fotografia");
                                              }
                                            } else {
                                              _camposVacios(context);
                                            }
                                          }))),
                            ),
                          ]),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }

  Future<void> _camposVacios(context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Ingresa un folio de servicio para continuar.'),
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
}
