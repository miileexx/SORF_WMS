import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selection_menu/components_configurations.dart';
import 'package:selection_menu/selection_menu.dart';
import 'package:sorfwms/Services/empleado_services.dart';
import 'package:sorfwms/Services/puesto_services.dart';
import 'package:sorfwms/models/Empleado.dart';
import 'package:sorfwms/providers/Empleado_Provider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/buttomNavServicio.dart';
import 'package:sorfwms/widgets/buttonActionCamara.dart';
import 'package:sorfwms/widgets/widgets.dart';

class EmpleadoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmpleadoService()),
        ChangeNotifierProvider(create: (_) => PuestoService()),
      ],
      child: EmpleadoContainer(),
    );
  }
}

class EmpleadoContainer extends StatelessWidget {
  const EmpleadoContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final empleadoService = Provider.of<EmpleadoService>(context);
    final puestoService = Provider.of<PuestoService>(context);
    final empleadoProvider = Provider.of<EmpleadoProvider>(context);
    final size = MediaQuery.of(context).size;


    FocusNode focusMinutos = new FocusNode();
    return Scaffold(
      body: SingleChildScrollView(
        child: BackgroundScreen(
        name: "Personal",
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
                                    builder: _triggerBuilder
                                  ),
                                ),
                                showSelectedItemAsTrigger: true,
                                itemSearchMatcher: (searchString, item) {
                                  return item.nombreEmpleado!.toLowerCase().contains(searchString!.trim().toLowerCase());
                                },
                                itemBuilder: (context, item, onItemTapped) {                                
                                  return Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: onItemTapped,
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                           child:Text(item.nombreEmpleado.toString()),
                                      )
                                    ),
                                  );
                                },
                                 itemsList: empleadoService.Empleados, 
                                 onItemSelected: (value) {
                                  empleadoProvider.SelecionEmpleado = value.idEmpleado;
                                  empleadoProvider.SelecionPuesto = value.clavePuesto;
                    
                                  for(int i = 0; i < puestoService.Puestos.length; i++){
                                    if(puestoService.Puestos[i].claveCategoria == value.clavePuesto){
                                      empleadoProvider.ClaveDefault = i;
                                      return;
                                    }
                                  }
                                },
                                ) ,
                            ),
                          SizedBox(height: 15),                        
                          Container(  
                              child: SelectionMenu(
                                initiallySelectedItemIndex:  puestoService.Puestos.length>0?empleadoProvider.ClaveDefault:null,
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
                                    builder: _triggerPuestos
                                  ),
                                ),
                                showSelectedItemAsTrigger: true,
                                itemSearchMatcher: (searchString, item) {
                                  return item.descripcion!.toLowerCase().contains(searchString!.trim().toLowerCase());
                                },
                                itemBuilder: (context, item, onItemTapped) {                                
                                  return Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: onItemTapped,
                                      child: Padding(
                                          padding: EdgeInsets.all(10),
                                          child:Text(
                                            item.descripcion.toString()
                                        )
                                      )
                                    ),
                                  );
                                },
                                 itemsList: puestoService.Puestos,                               
                                 onItemSelected: (value) {
                                    empleadoProvider.SelecionPuesto = value.claveCategoria;
                                },
                                ) ,
                            ), 
                          SizedBox(height: 15),
                          Container(
                            child: Row(
                              children: [
                                Text('MIN ASIGNAR: ', style: GoogleFonts.manrope(fontSize: 18)),
                                Container(
                                  width: size.width*0.24,
                                  height: 40,
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    maxLength: 4,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                                        ],
                                    initialValue: empleadoProvider.MinutosAsignados >0?empleadoProvider.MinutosAsignados.toString():'',
                                    onChanged: (value) {
                                      if (value == "") {
                                        empleadoProvider.MinutosAsignados = 0;
                                      }else{
                                        empleadoProvider.MinutosAsignados = double.parse(value);
                                      }
                                    },
                                    decoration: DecorationFormBorder(focusMinutos),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                      decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Primarycolor,
                                    ),                                  
                                    child: IconButton(
                                       icon: Icon(Icons.add_sharp),
                                       color: Colors.white,
                                       iconSize: 30,
                                       onPressed: () { 
                                        if(empleadoProvider.MinutosAsignados==0){
                                          _minutosAsignados(context);
                                        } else {
                                          Empleado empleado = empleadoService.Empleados.firstWhere((element) => element.idEmpleado == empleadoProvider.nSelecionEmpleado);
                                          empleado.clavePuesto = empleadoProvider.SelecionPuesto;
                                          empleado.horas = empleadoProvider.MinutosAsignados;
                                          empleado.ordinario = empleadoProvider.Ordinario;
                                          empleadoProvider.AgregarEmpleado(empleado);
                                        }
                                       },
                                       ),
                                  ),
                                Container(
                                  child: IconButton(
                                      iconSize: 38,
                                        onPressed: () {
                    
                                          empleadoProvider.RemoverEmpleado();
                    
                                        },
                                        icon: Icon(Icons.remove_circle_outline)),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Radio(
                                   value: true, 
                                   groupValue: empleadoProvider.Ordinario, 
                                   onChanged: (value) {
                                      empleadoProvider.Ordinario = value!;
                                    },
                                ),
                                Text(
                                  'ORDINARIO',
                                  style: new TextStyle(fontSize: 17.0),
                                ),
                                Radio(
                                    value: false, 
                                    groupValue: empleadoProvider.Ordinario,  
                                    onChanged: (value){
                                      empleadoProvider.Ordinario = value!;
                                    },
                                ),                              
                                Text(
                                  'ADICIONAL',
                                  style: new TextStyle(fontSize: 17.0),
                                ),
                                
                              ],
                            ),
                          ),
                          SizedBox(height: 3),
                          Container(
                            width: double.infinity,
                            height: 250,
                            child: SingleChildScrollView(
                              child: DataTable(
                                showCheckboxColumn: false,
                                columns: const [
                                  DataColumn(label: Text('Clave' )),
                                  DataColumn(label: Text('Min.' )),
                                  DataColumn(label: Text('Nombre' )),
                                  DataColumn(label: Text('Tipo' )),
                                ],
                                rows:List.generate(empleadoProvider.Empleados.length, (index) {
                                  return DataRow(
                                    selected: empleadoProvider.SelecionTable[index],
                                    onSelectChanged: ((value) {     
                                        empleadoProvider.SelecionTabla=index;
                                        empleadoProvider.MinutosAsignados = empleadoProvider.Empleados[index].horas!;
                                        empleadoProvider.cambiarSeleccion(index, value!);   
                                    }),
                                    cells: [
                                      DataCell(Center(child: (Text(empleadoProvider.ClaveDefault.toString(), style: GoogleFonts.barlow())))),
                                      DataCell(Center(child: (Text(empleadoProvider.Empleados[index].horas.toString(), style: GoogleFonts.barlow())))),
                                      DataCell(Center(child: (Text(empleadoProvider.Empleados[index].nombreEmpleado.toString(), style: GoogleFonts.barlow())))),
                                      DataCell(Center(child: (Text(empleadoProvider.Empleados[index].ordinario!?"Ordinario":"Adicional", style: GoogleFonts.barlow())))),
                                    ]
                                  );
                    
                                })
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    )
                ),
                ),
              ],
            ),  
            RegresoRutaScreen(context, '/insumo'),
            SiguienteRutaScreen(context, '/maquinaria'),
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
        "Selecciona un personal",
        style: GoogleFonts.barlow(textStyle: TextStyle(color: Colors.black), fontSize: 20)
      ),
    )
    );
  }

  static Widget _triggerPuestos (TriggerComponentData data) {
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
        "Selecciona un puesto",
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
