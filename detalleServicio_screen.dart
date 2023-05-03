import 'package:flutter/material.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Empleado_Provider.dart';
import 'package:sorfwms/providers/Insumo_Provider.dart';
import 'package:sorfwms/providers/MaquinariaProvider.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';
import 'package:sorfwms/screens/TokenExpiredSceen.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/Loading.dart';
import 'package:sorfwms/widgets/buttomNavServicio.dart';
import 'package:sorfwms/widgets/buttonActionCamara.dart';
import 'package:sorfwms/widgets/widgets.dart';

class DetalleServicioScreen extends StatefulWidget {

  @override
  State<DetalleServicioScreen> createState() => _DetalleServicioScreenState();
}

class _DetalleServicioScreenState extends State<DetalleServicioScreen> {
  @override
  Widget build(BuildContext context) {
   
    final servicios = Provider.of<ServicioProvider>(context);
    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);
    final maquinariaProvider = Provider.of<MaquinariaProvider>(context);
    final empleadoProvider = Provider.of<EmpleadoProvider>(context);
    final insumoProvider = Provider.of<InsumoProvider>(context);
    final size = MediaQuery.of(context).size;

    if (consultaServicio.servicios.detalleServicio != null) {
      maquinariaProvider.AgregarMaquinarias(
          consultaServicio.servicios.detalleServicio!.maquinarias);
      empleadoProvider.AgregarEmpleados(
          consultaServicio.servicios.detalleServicio!.personas);
      insumoProvider.AgregarInsumos(
          consultaServicio.servicios.detalleServicio!.insumos);
    }
    
    if(consultaServicio.FolioServicio > 0 && consultaServicio.servicios.detalleServicio == null ) {  
      consultaServicio.ConsultaServicios();
      OverlayLoadingProgress.stop();
    }

    if(consultaServicio.isLoading==true){
       return Loading();      
    }

    if (Ajustes.TokenExpired) {
      return TokenExpiredScreen();
    }

    return Scaffold(
      body: BackgroundScreen(
        name: "Servicios",
        child: Stack(
          children: [
             Column(
              children: [
                SizedBox(height: size.height*0.18),
                CardContainer(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                      child: formDetalleServicio()),
                  ),
                ),
              ],
            ),
            
            RegresoRutaScreen(context, '/servicio'),
            SiguienteRutaScreen(context, '/anexo'),
          ],
        ),
      ),
      floatingActionButton: const ButtonCamaraServicio(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const ButtomNavServicio(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}

class formDetalleServicio extends StatefulWidget {
  const formDetalleServicio({
    Key? key,
  }) : super(key: key);

  @override
  State<formDetalleServicio> createState() => _formDetalleServicioState();
}

class _formDetalleServicioState extends State<formDetalleServicio> {

  @override
  Widget build(BuildContext context) {
    FocusNode txtServicio = new FocusNode();
    FocusNode txtTarja = new FocusNode();
    FocusNode txtAA = new FocusNode();
    FocusNode txtGafete = new FocusNode();
    FocusNode txtObservacion = new FocusNode();
    final now = DateTime.now();

    final servicioProvider = Provider.of<ConsultaServicioProvider>(context);

    final oServicio = servicioProvider.servicios;
    oServicio.detalleServicio?.fechaInicio = now.toString();

    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            enabled: false,
            initialValue: oServicio.detalleServicio?.folioServicio
                    .toString()
                    .split('.')[0] ??
                '',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: DecorationFormSettings(txtServicio, '', 'Servicio:'),
          ),
          SizedBox(height: 18),
          TextFormField(      
            enabled: false,         
            initialValue:  oServicio.tarja != null?oServicio.tarja!.tarja?.toString():'',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
            decoration: DecorationFormSettings(txtTarja, '', 'Tarja:'),
          ),
          SizedBox(height: 18),
          TextFormField(
            initialValue: oServicio.detalleServicio?.responsableAgencia ?? '',
            textInputAction: TextInputAction.next,
            decoration: DecorationFormSettings(txtAA, '', 'AA:'),
            onChanged: (value) {
              oServicio.detalleServicio?.responsableAgencia = value;
            },
          ),
          SizedBox(height: 18),
          TextFormField(
            initialValue: oServicio.detalleServicio?.gafeteRespAa,
            textInputAction: TextInputAction.next,
            decoration: DecorationFormSettings(txtGafete, '', 'Gafete:'),
            onChanged: (value) {
              oServicio.detalleServicio?.gafeteRespAa = value;
            },
          ),
          SizedBox(height: 15),
          TextFormField(
            initialValue: oServicio.detalleServicio?.observaciones,
            textInputAction: TextInputAction.next,
            maxLines: 5,
            decoration:
                DecorationFormSettings(txtObservacion, '', 'Observaciones:'),
            onChanged: (value) {
              oServicio.detalleServicio?.observaciones = value;
            },
          ),
          
        ],
      ),
    );
  }
}
