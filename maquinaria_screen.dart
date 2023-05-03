import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';
import 'package:sorfwms/Services/maquinaria_services.dart';
import 'package:sorfwms/models/Maquinaria.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/MaquinariaProvider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/BackgroundPurple.dart';
import 'package:sorfwms/widgets/buttomNavServicio.dart';
import 'package:sorfwms/widgets/buttonActionCamara.dart';
import 'package:sorfwms/widgets/cardContainer.dart';
import 'package:sorfwms/widgets/regresoRutaScreen.dart';
import 'package:sorfwms/widgets/siguienteRutaScreen.dart';


class MaquinariaScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
       return  ChangeNotifierProvider(
      create: (context) => MaquinariaService(),
      child: MaquinariaContainer());
  }
} 

class MaquinariaContainer extends StatelessWidget {
  const MaquinariaContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    final maquinariaService = Provider.of<MaquinariaService>(context);
    final maquinariaProvider = Provider.of<MaquinariaProvider>(context);
    final size = MediaQuery.of(context).size;
    
    FocusNode focusMinutos = new FocusNode();
    return Scaffold(
      body: BackgroundScreen(
        name:  "Maquinaria",
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(  
                              child: SelectionMenu(
                                componentsConfiguration: DialogComponentsConfiguration(
                                  menuSizeConfiguration: const MenuSizeConfiguration(
                                    maxHeightFraction: 0.5,
                                    maxWidthFraction: 0.8,
                                    minWidth: 500,
                                    minHeight: 500,
                                    requestAvoidBottomInset: true,
                                    enforceMinWidthToMatchTrigger: true,
                                    width: 100,
                                    requestConstantHeight: true,
                                  ),
                    
                                  triggerComponent: TriggerComponent(
                                    builder: _triggerMaquinaria
                                  ),
                                ),
                                showSelectedItemAsTrigger: true,
                                itemSearchMatcher: (searchString, item) {
                                  return item.descripMaquinaria!.toLowerCase().contains(searchString!.trim().toLowerCase());
                                },
                                itemBuilder: (context, item, onItemTapped) {                                
                                  return Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: onItemTapped,
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child:Text(item.descripMaquinaria.toString())
                                      )
                                    ),
                                  );
                                },
                                 itemsList: maquinariaService.maquinarias, 
                                 onItemSelected: (value) {
                                  maquinariaService.MaquinariaSelecionada = value.claveMaquinaria!;
                                },
                                ) ,
                            ),
                          SizedBox(height: 10,),
                          Container(
                            child: Row(
                              children: [
                                Text('MIN ASIGNAR: ', style: GoogleFonts.manrope(fontSize: 18)),
                                Container(
                                  width: size.width*0.25,
                                  height: 40,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    maxLength: 4,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                        ],
                                    initialValue: '${maquinariaProvider.MinutosAsignados>0?maquinariaProvider.MinutosAsignados:''}',
                                    onChanged: (value) {
                                      if (value == "") {
                                        maquinariaProvider.MinutosAsignados = 0;
                                      }else{
                                        maquinariaProvider.MinutosAsignados = double.parse(value);
                                      }
                                    },
                                    decoration: DecorationFormBorder(focusMinutos),
                                  ),
                                ),
                                SizedBox(width: size.width*0.02),
                                Container(
                                      decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Primarycolor,
                                    ),                                  
                                    child: IconButton(
                                       icon: Icon(Icons.add_sharp),
                                       color: Colors.white,
                                       iconSize: 20,
                                       onPressed: () { 
                                        if(maquinariaProvider.MinutosAsignados==0){
                                          _minutosAsignados(context);
                                        } else {
                                           Maquinaria maquinaria = maquinariaService.maquinarias.firstWhere((element) => element.claveMaquinaria == maquinariaService.MaquinariaSelecionada);
                                          maquinaria.horasMaquinaria = maquinariaProvider.MinutosAsignados;
                                          maquinariaProvider.AgregarMaquinaria(maquinaria);
                                        }
                                       },
                                       ),
                                  ),
                                Container(
                                  child: IconButton(
                                      iconSize: 30,
                                        onPressed: () {
                                          maquinariaProvider.RemoverMaquinaria();
                                        },
                                        icon: Icon(Icons.remove_circle_outline)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            height: 250,
                            child: SingleChildScrollView(
                              child: DataTable(
                                showCheckboxColumn: false,
                                columns: [
                                  DataColumn(label: Text('Clave' )),
                                  DataColumn(label: Text('Min.' )),
                                  DataColumn(label: Text('Maquinaria')),
                                ],
                                rows:List.generate(maquinariaProvider.Maquinarias.length, (index) {
                                   return DataRow( 
                                    selected: maquinariaProvider.SelecionTable[index],
                                     onSelectChanged: ((value) {     
                                        maquinariaProvider.SelecionTabla=index;
                                        maquinariaProvider.cambiarSeleccion(index, value!);   
                                    }),
                                    cells: [
                                     DataCell(Center(child: (Text(maquinariaProvider.Maquinarias[index].claveMaquinaria!.toString(), style: GoogleFonts.barlow())))),
                                     DataCell(Center(child: (Text(maquinariaProvider.Maquinarias[index].horasMaquinaria.toString(), style: GoogleFonts.barlow())))),
                                     DataCell(Center(child: (Text(maquinariaProvider.Maquinarias[index].descripMaquinaria!, style: GoogleFonts.barlow()))))                                   
                                    ]
                                  );
                                })
                              ),
                            ),
                          )
                        ],
                        
                      ),
                    ) 
                  )
                ),
                ),
              ],
            ),
        
            RegresoRutaScreen(context, '/personal'),
            SiguienteRutaScreen(context, '/firma'),
          ],
        ),
      ),       
      floatingActionButton: const ButtonCamaraServicio(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:  ButtomNavServicio(
          fabLocation: FloatingActionButtonLocation.centerDocked,
          shape: CircularNotchedRectangle(),
        ),
    );
  }

  static Widget _triggerMaquinaria (TriggerComponentData data) {
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
        "Selecciona una maquinaria",
        style: GoogleFonts.barlow(textStyle: TextStyle(color: Colors.black), fontSize: 20)
      ),
    )
    );
  }

  Future<void> _minutosAsignados(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('SORFWMS'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Ingresa los minutos para continuar.'),
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

}