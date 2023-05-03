import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/Services/fotografia_service.dart';
import 'package:sorfwms/models/Fotografias.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Firmas_Provider.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/BackgroundPurple.dart';
import 'package:sorfwms/widgets/bottomNavigationFotos.dart';
import 'package:sorfwms/widgets/cardContainer.dart';
import 'package:sorfwms/widgets/regresoRutaScreen.dart';

class FotografiaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final firmas = Provider.of<FirmasProvider>(context);
    final providerFoto = Provider.of<FotografiaServices>(context);
    final servicio = Provider.of<FotografiaServices>(context);
    final heightTotal = size.height-(size.height*0.18);
    final consultaServicio = Provider.of<ConsultaServicioProvider>(context);

    return Scaffold(
      body: BackgroundScreen(
        name: "Fotografias",
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(height: size.height * 0.18),
                CardContainer(
                  child: Container(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20.0,
                        ),
                        child: Container(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text('Folio de Servicio: ', style: TextStyle(fontSize: 18)),
                                          const SizedBox(width: 10,),
                                          Text(providerFoto.folioServicio.toString(), style: const TextStyle(fontSize: 18)),
                                        ],                                     

                                      ),
                                      SizedBox(height: heightTotal * 0.02 ),
                                      Row(
                                        children: [
                                          const Text('Tarja: ', style: TextStyle(fontSize: 18)),
                                          const SizedBox(width: 10,),
                                          Text(providerFoto.tarja.toString(), style: const TextStyle(fontSize: 18, ) ),
                                        ],                                     
                          
                                      ),
                                    ],
                                  ),
                                ),
                                                               
                                SizedBox(height: heightTotal * 0.02 ),
                                Container(
                                  child: DropdownButtonFormField(
                                      decoration: DecorationDropdownForm(),
                                      hint: const Text(
                                        'Selecciona el tipo de foto ',
                                      ),
                                      items:
                                          providerFoto.ListaTipoFotos.map((item) {
                                        return DropdownMenuItem(
                                            value: item.value,
                                            child: Text(item.descripTipoFoto));
                                      }).toList(),
                                      onChanged: (value) {}),
                                ),
                                SizedBox(height: heightTotal * 0.02 ),
                          
                                Container(
                                  child: Swiper(
                                    itemCount:
                                        providerFoto.ListaFotografia.length,
                                    layout: SwiperLayout.STACK,
                                    itemWidth: size.width * 0.5,
                                    itemHeight: heightTotal * 0.5,
                                    onTap: (index) {
                                      providerFoto.index = index;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content:
                                                  Text("Imagen Seleccionada.")));
                                    },
                                    itemBuilder: (context, index) {
                                      return FadeInImage(
                                          placeholder: const AssetImage(
                                              'assets/images/no-image.jpg'),
                                          image: FileImage( File(providerFoto
                                              .ListaFotografia[index].file!.path)));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ),
              ],     
            ),
            
            RegresoRutaScreen(context, consultaServicio.ingreso==true ? '/ingresosMedidas' : providerFoto.busquedaServicio == true ?'/buscarServicio' : '/detalleServicio'),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_sharp),
        onPressed: () async {
          final ImagePicker _picker = ImagePicker();
          final XFile? photo = await _picker.pickImage(
              source: ImageSource.camera,
              imageQuality: 50,
              maxHeight: 1080,
              maxWidth: 720,
              preferredCameraDevice: CameraDevice.rear);

          if (photo == null) {
            return;
          }
         providerFoto.agregarFotos(Fotografias(folioServicio: providerFoto.folioServicio, tipoFoto: providerFoto.tipoFoto, file: photo));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomNavigationFotos(
        fabLocation: FloatingActionButtonLocation.centerDocked,
        shape: CircularNotchedRectangle(),
      ),
    );
  }
}