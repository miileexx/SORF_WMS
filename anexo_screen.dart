import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/BackgroundPurple.dart';
import 'package:sorfwms/widgets/animatedFab.dart';
import 'package:sorfwms/widgets/buttomNavServicio.dart';
import 'package:sorfwms/widgets/buttonActionCamara.dart';
import 'package:sorfwms/widgets/cardContainer.dart';
import 'package:sorfwms/widgets/regresoRutaScreen.dart';
import 'package:sorfwms/widgets/siguienteRutaScreen.dart';

class AnexoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BackgroundScreen(
        name: "Anexo",
        child: Stack( 
          children: [
            Column(
              children: [ 
                SizedBox(height: size.height*0.18),
                CardContainer(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: formAnexo(),
                  )
                ),
              ],
            ),
        
            RegresoRutaScreen(context, '/detalleServicio'),
            SiguienteRutaScreen(context, '/insumo'),
          ],
        ),
      ),
      floatingActionButton: const ButtonCamaraServicio(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ButtomNavServicio(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}

class formAnexo extends StatelessWidget {
  const formAnexo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode focusCargaVac = new FocusNode();
    FocusNode focusCargaLlen = new FocusNode();
    final servicioProvider = Provider.of<ConsultaServicioProvider>(context);
    final oServicio = servicioProvider.servicios;

    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            initialValue:
                oServicio.detalleServicio?.cargaVaciada.toString() ?? '0',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
            ],
            decoration:
                DecorationFormSettings(focusCargaVac, '', 'Carga Vaciada'),
            onChanged: (value) {
              if (value != null && value.length > 0) {
                value = value.substring(0, value.length - 1);
              }
              oServicio.detalleServicio?.cargaVaciada =
                  value.isEmpty ? 0 : double.parse(value);
            },
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            initialValue:
                oServicio.detalleServicio?.cargaLlenada.toString() ?? '0',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
            ],
            decoration:
                DecorationFormSettings(focusCargaLlen, '', 'Carga Llenada'),
            onChanged: (value) {
              oServicio.detalleServicio?.cargaLlenada =
                  value.isEmpty ? 0 : double.parse(value);
            },
          )
        ],
      ),
    );
  }
}
