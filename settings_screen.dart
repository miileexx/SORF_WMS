import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/utilities/decorationForm.dart';
import 'package:sorfwms/widgets/BackgroundPurple.dart';
import 'package:sorfwms/widgets/cardBar.dart';
import 'package:sorfwms/widgets/cardContainer.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FocusNode txtUrl = new FocusNode();
  FocusNode txtApiCatalogos = new FocusNode();
  FocusNode txtApiOperaciones = new FocusNode();
  FocusNode txtAPIAutenticacion = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: BackgroundScreen(
        name: 'Configuración',
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 60,
                left: 20,
                child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ))),
              ),
              Column(
                children: [
                  SizedBox(height: size.height * 0.20),
                  CardContainer(
                      child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          focusNode: txtUrl,
                          initialValue: Ajustes.URL,
                          onChanged: (value) {
                            Ajustes.URL = value;
                            setState(() {});
                          },
                          style: const TextStyle(fontSize: 20),
                          decoration: DecorationFormSettings(
                              txtUrl,'URL del WMS','URL del WMS'),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          focusNode: txtAPIAutenticacion,
                          initialValue: Ajustes.APIAutenticacion,
                          onChanged: (value) {
                            Ajustes.APIAutenticacion = value;
                            setState(() {});
                          },
                          style: const TextStyle(fontSize: 20),
                          decoration: DecorationFormSettings(
                              txtAPIAutenticacion,'API Autenticacion','API Autenticacion'),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          focusNode: txtApiCatalogos,
                          initialValue: Ajustes.ApiCatalogos,
                          onChanged: (value) {
                            Ajustes.ApiCatalogos = value;
                            setState(() {});
                          },
                          style: const TextStyle(fontSize: 20),
                          decoration: DecorationFormSettings(txtApiCatalogos,'API CATALOGOS', 'API CATALOGOS'),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          focusNode: txtApiOperaciones,
                          initialValue: Ajustes.ApiOperaciones,
                          onChanged: (value) {
                            Ajustes.ApiOperaciones = value;
                            setState(() {});
                          },
                          style: const TextStyle(fontSize: 20),
                          decoration: DecorationFormSettings(txtApiOperaciones,'API Operaciones', 'API Operaciones'),
                        ),
                      ),
                    
                    ],
                  )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

 
}
