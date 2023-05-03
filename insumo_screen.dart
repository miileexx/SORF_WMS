import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';
import 'package:sorfwms/Services/insumo_service.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/models/Insumo.dart';
import 'package:sorfwms/providers/Insumo_Provider.dart';
import 'package:sorfwms/screens/TokenExpiredSceen.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/animatedFab.dart';
import 'package:sorfwms/widgets/buttomNavServicio.dart';
import 'package:sorfwms/widgets/buttonActionCamara.dart';
import 'package:sorfwms/widgets/widgets.dart';

class InsumoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => InsumoService(), child: InsumoScreenContainer());
  }
}

class InsumoScreenContainer extends StatelessWidget {
  const InsumoScreenContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final insumo = Provider.of<InsumoService>(context);
    final insumoProvider = Provider.of<InsumoProvider>(context);
    var seleccion = 0;
    final size = MediaQuery.of(context).size;

    List<bool> _selected = List<bool>.generate(
        insumoProvider.Insumos.length, (int index) => false);
    FocusNode focusCantidad = new FocusNode();
    double _Cantidad = 0;

    final _ctrlCantidadInsumo =
        TextEditingController(text: "${insumoProvider.getCantidadInsumo>0?insumoProvider.getCantidadInsumo:''}");

    if (Ajustes.TokenExpired) {
      return TokenExpiredScreen();
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundScreen(
        name: "Insumo",
        child: Stack(
          children: [
             Column(
              children: [
                SizedBox(height: size.height*0.18),
                CardContainer(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(                  
                              child: SelectionMenu(
                                componentsConfiguration:
                                    DialogComponentsConfiguration(
                                  menuSizeConfiguration:
                                      const MenuSizeConfiguration(
                                    maxHeightFraction: 0.5,
                                    maxWidthFraction: 0.8,
                                    minWidth: 500,
                                    minHeight: 500,
                                    requestAvoidBottomInset: true,
                                    enforceMinWidthToMatchTrigger: true,
                                    width: 100,
                                    requestConstantHeight: true,
                                  ),
                                  triggerComponent:
                                      TriggerComponent(builder: _triggerBuilder),
                                ),
                                showSelectedItemAsTrigger: true,
                                itemSearchMatcher: (searchString, item) {
                                  return item.descripInsumo!
                                      .toLowerCase()
                                      .contains(
                                          searchString!.trim().toLowerCase());
                                },
                                itemBuilder: (context, item, onItemTapped) {
                                  return Material(
                                    color: Colors.white,
                                    child: InkWell(
                                        onTap: onItemTapped,
                                        child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                                item.descripInsumo.toString()))),
                                  );
                                },
                                itemsList: insumo.Insumos,
                                onItemSelected: (value) {
                                  insumoProvider.setselecion = value.claveInsumo!;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'CANTIDAD: ',
                                    style: GoogleFonts.manrope(fontSize: 18),
                                  ),
                                  Container(
                                    width: size.width*0.25,
                                    height: 38,
                                    child: TextFormField(
                                        //initialValue: null,
                                        onChanged: (value) {
                                          if (value == "") {
                                            insumoProvider.cantidadInsumo = 0;
                                          } else {
                                            insumoProvider.cantidadInsumo = double.parse(value);
                                          } 
                                        },
                                        controller: _ctrlCantidadInsumo,
                                        textAlign: TextAlign.center,
                                        maxLength: 4,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                        ],
                                        decoration:
                                            DecorationFormBorder(focusCantidad)),
                                  ),
                                  SizedBox(width: size.width *0.03),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Primarycolor,
                                    ),
                                    child: IconButton(
                                      color: Colors.white,
                                      iconSize: 20,
                                      onPressed: () {
                                        if(insumoProvider.cantidadInsumo==0){
                                            _insumoVacio(context);
                                          } if(insumoProvider.cantidadInsumo!=0){
                                            Insumo cmbInsumo =
                                              insumo.Insumos.firstWhere(
                                                  (element) =>
                                                      element.claveInsumo ==
                                                      insumoProvider.getselecion);
                                              cmbInsumo.cantidadInsumo =
                                              insumoProvider.cantidadInsumo;
                                          insumoProvider.Agregarinsumo(cmbInsumo);
                                        }
                                      },
                                      icon: Icon(Icons.add_sharp),
                                    ),
                                  ),
                                  Container(                                  
                                    child: IconButton(
                                      iconSize: 55,
                                        onPressed: () {
                                          insumoProvider.removerInsumo();
                                        },
                                        icon: Icon(Icons.remove_circle_outline)),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: DataTable(
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) =>
                                        Color.fromARGB(255, 210, 223, 233)),
                                showCheckboxColumn: false,
                                columns: [
                                  DataColumn(
                                      label: Expanded(
                                          child: Text('Clave',
                                              style: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text('Cantidad',
                                              style: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)))),
                                  DataColumn(
                                      label: Expanded(
                                          child: Text('Insumo',
                                              style: GoogleFonts.manrope(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12)))),
                                ],
                                rows: insumoProvider.Insumos.map((insumo) =>
                                    DataRow(
                                        selected: insumo.select,
                                        onSelectChanged: (value) {
                                          insumoProvider.removeselection();
                                          insumoProvider.cantidadInsumo =
                                              insumo.cantidadInsumo!;
                                          insumoProvider.setselecion =
                                              insumo.claveInsumo!;
                                          insumo.select = value!;
                                        },
                                        cells: [
                                          DataCell(Text(
                                              insumo.claveInsumo.toString())),
                                          DataCell(Text(
                                              insumo.cantidadInsumo.toString())),
                                          DataCell(Text(
                                              insumo.descripInsumo.toString())),
                                        ])).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        
            RegresoRutaScreen(context, '/anexo'),
            SiguienteRutaScreen(context, '/personal'),
          ],
        ),
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

  Widget _customPopupItemBuilderExample2(
    BuildContext context,
    Insumo? item,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
          selected: isSelected, title: Text(item?.descripInsumo ?? '')),
    );
  }

  static Widget _triggerBuilder(TriggerComponentData data) {
    return SizedBox(
      height: 50,
      width: 700,
      child: OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
        backgroundColor: Colors.white,
      ),
      onPressed: data.triggerMenu,
      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
      label: Text(
        "Selecciona un insumo",
        style: GoogleFonts.barlow(textStyle: TextStyle(color: Colors.black), fontSize: 20)
      ),
    )
    );
  }

  Future<void> _insumoVacio(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('SORFWMS'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Selecciona un insumo y la cantidad para continuar.'),
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
