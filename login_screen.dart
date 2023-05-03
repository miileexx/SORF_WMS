import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/Services/almacen_services.dart';
import 'package:sorfwms/Services/usuario_services.dart';
import 'package:sorfwms/providers/Login_Form_Provider.dart';
import 'package:sorfwms/utilities/constants.dart';
import 'package:sorfwms/utilities/logging.dart';
import 'package:sorfwms/utilities/preferencias.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';
import 'package:sorfwms/utilities/logging.dart';
import 'dart:convert';
import 'dart:ui';

/*
LoginScreen.dart
Creado        : MHG
Fecha         : 16/01/2023
Descripcion   : Ajuste en preferencias
--------------------------------------------------------------------------------------------
*/

class LoginScreen extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<LoginScreen> {
  //const _SignInState({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  late String user, password;
  bool isLoading = false;
  final _log = logger;

  @override
  Widget build(BuildContext context) {
    final almacenservice = Provider.of<AlmacenServices>(context);
    final loginForm = Provider.of<LoginFormProvider>(context);
    final usuarioservice = new UsuarioServices();

    return Scaffold(
      endDrawer: PreferenciasUsuario(),
      appBar: AppBar( 
        backgroundColor: Color(0xFF73AEF5),
        elevation: 0,
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              _backgroundLogin(),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 50.0,
                  ),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: Image.asset('assets/images/SORFLogo200.png'),
                          ),
                        ),
                        _buildAlmacen(loginForm: loginForm),
                        const SizedBox(height: 30.0),
                        _buildUsuario(loginForm: loginForm),
                        const SizedBox(height: 30.0),
                        _buildPassword(loginForm: loginForm),
                        const SizedBox(height: 20.0),
                        _buildLoginBtn(
                            loginForm: loginForm,
                            usuarioservice: usuarioservice,
                            isLoading: isLoading),
                        Row(
                          children: const <Widget>[
                            SizedBox(
                              height: 270,
                              width: 198,
                            ),
                            Text('Versión 1.0.6', style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _buildLoginBtn extends StatefulWidget {
  const _buildLoginBtn(
      {Key? key,
      required this.loginForm,
      required this.usuarioservice,
      required this.isLoading})
      : super(key: key);

  final LoginFormProvider loginForm;
  final UsuarioServices usuarioservice;
  final bool isLoading;

  @override
  _BuildLoginBtnState createState() => _BuildLoginBtnState();
}

class _BuildLoginBtnState extends State<_buildLoginBtn> {
  bool isLoading = false;
  final _log = logger;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        //padding: const EdgeInsets.symmetric(vertical: 25.0),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ElevatedButton(
            onPressed: () async {
              OverlayLoadingProgress.start(
                context,
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Autenticando...',
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 1.5, color: Colors.white70),
                    ),
                    const SizedBox(height: 30),
                    CircularProgressIndicator(),
                  ],
                ),
              );
              if (widget.loginForm.User.isNotEmpty &&
                  widget.loginForm.Pass.isNotEmpty) {
                var userResponse = await widget.usuarioservice.login(
                    widget.loginForm.User.trim(),
                    widget.loginForm.Pass.trim(),
                    widget.loginForm.Almacen);
                _log.i('Se verifican las credenciales del usuario');
                if (userResponse.success!) {
                  _log.i('El usuario se autenticó y es valido el acceso');
                  OverlayLoadingProgress.stop();
                  setState(() {
                    isLoading = true;
                  });
                  Navigator.pushReplacementNamed(context, "/home");
                } else {
                  _log.e('Usuario o contraseña incorrectos');
                  OverlayLoadingProgress.stop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Usuario o contraseña incorrectos")));
                }
              } else {
                _log.e('No se permiten campos vacíos');
                OverlayLoadingProgress.stop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("No se permiten campos vacíos.")));
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                elevation: 5.0),
            child: const Text(
              'Autenticar',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 20.0,
                fontWeight: FontWeight.normal,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ));
  }
}

class _buildPassword extends StatelessWidget {
  const _buildPassword({
    Key? key,
    required this.loginForm,
  }) : super(key: key);

  final LoginFormProvider loginForm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Contraseña',
          style: kLabelStyle,
        ),
        const SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            textInputAction: TextInputAction.go,
            obscureText: true,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: 'Ingresa tu contraseña',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) => loginForm.Pass = value,
          ),
        ),
      ],
    );
  }
}

class _buildAlmacen extends StatefulWidget {
  final LoginFormProvider loginForm;
  const _buildAlmacen({Key? key, required this.loginForm}) : super(key: key);
  @override
  _buildAlmacenState createState() => new _buildAlmacenState();
}

class _buildAlmacenState extends State<_buildAlmacen> {
  String _newValue = '1';

  @override
  Widget build(BuildContext context) {
    final almacenservice = Provider.of<AlmacenServices>(context);
    _newValue = widget.loginForm.Almacen;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Almacén',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(8),
          height: 60,
          width: 400,
          decoration: kBoxDecorationStyle,
          child: DropdownButton(
            dropdownColor: Color(0xFF6CA8F1),
            isExpanded: true,
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down, color: Colors.white),
            hint: const Text(
              'Selecciona un almacén',
              style: kHintTextStyle,
            ),
            items: almacenservice.Almacenes.map((item) {
              return DropdownMenuItem(
                value: item.tipoAlmacen.toString(),
                child: Text(
                  item.nombreAlmacen.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            onChanged: (value) {
              widget.loginForm.Almacen = value.toString();
              setState(() {
                _newValue = value.toString();
              });
            },
            value: _newValue,
          ),
        ),
      ],
    );
  }
}

class _buildUsuario extends StatelessWidget {
  const _buildUsuario({
    Key? key,
    required this.loginForm,
  }) : super(key: key);

  final LoginFormProvider loginForm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Usuario',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextFormField(
            textInputAction: TextInputAction.next,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Ingresa tu usuario',
              hintStyle: kHintTextStyle,
            ),
            onChanged: (value) => loginForm.User = value,
          ),
        ),
      ],
    );
  }
}

class _backgroundLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF73AEF5),
            Color(0xFF61A4F1),
            Color(0xFF478DE0),
            Color(0xFF398AE5),
          ],
          stops: [0.1, 0.4, 0.7, 0.9],
        ),
      ),
    );
  }
}
