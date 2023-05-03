import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sorfwms/Services/almacen_services.dart';
import 'package:sorfwms/Services/fotografia_service.dart';
import 'package:sorfwms/models/Ajustes.dart';
import 'package:sorfwms/providers/ConsultaServicio_Provider.dart';
import 'package:sorfwms/providers/Empleado_Provider.dart';
import 'package:sorfwms/providers/Firmas_Provider.dart';
import 'package:sorfwms/providers/Insumo_Provider.dart';
import 'package:sorfwms/providers/Login_Form_Provider.dart';
import 'package:sorfwms/providers/MaquinariaProvider.dart';
import 'package:sorfwms/providers/PendientesUbicarProvider.dart';
import 'package:sorfwms/providers/Servicio_Provider.dart';
import 'package:sorfwms/screens/anexo_screen.dart';
import 'package:sorfwms/screens/busquedaServicio_screen.dart';
import 'package:sorfwms/screens/detalleServicio_screen.dart';
import 'package:sorfwms/screens/empleado_screen.dart';
import 'package:sorfwms/screens/firma_screen.dart';
import 'package:sorfwms/screens/fotografia_screen.dart';
import 'package:sorfwms/screens/home_screen.dart';
import 'package:sorfwms/screens/ingresosLCL_IMO.dart';
import 'package:sorfwms/screens/ingresosLCL_Medidas.dart';
import 'package:sorfwms/screens/ingresosLCL_matriculas.dart';
import 'package:sorfwms/screens/ingresosLCL_partidas.dart';
import 'package:sorfwms/screens/ingresosLCL_Filtros.dart';
import 'package:sorfwms/screens/ingresos_screen.dart';
import 'package:sorfwms/screens/insumo_screen.dart';
import 'package:sorfwms/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sorfwms/screens/maquinaria_screen.dart';
import 'package:sorfwms/screens/pendientesUbicar_Screen.dart';
import 'package:sorfwms/screens/servicios_screen.dart';
import 'package:sorfwms/screens/settings_screen.dart';
import 'package:sorfwms/utilities/logging.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Ajustes.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  AppStates createState() => AppStates();
}

class AppStates extends State<MyApp> {
  final _log = logger;
  var _loginStatus = 0;

  @override
  void initState() {
    super.initState();
    _log.i('initState');
    getSharedPrefences();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AlmacenServices()),
        ChangeNotifierProvider(create: (_) => LoginFormProvider("", "", "1")),
        ChangeNotifierProvider(create: (_) => InsumoProvider()),
        ChangeNotifierProvider(create: (_) => EmpleadoProvider()),
        ChangeNotifierProvider(create: (_) => MaquinariaProvider()),
        ChangeNotifierProvider( create: (_) => ServicioProvider()),
        ChangeNotifierProvider( create: (_) => ConsultaServicioProvider()),
        ChangeNotifierProvider( create: (_) => FotografiaServices()),             
        ChangeNotifierProvider( create: (_) => FirmasProvider()),        
        ChangeNotifierProvider( create: (_) => PendientesUbicarProvider()),
      ],
      child: MaterialApp(
          title: 'SORF WMS Móvil',
          debugShowCheckedModeBanner: false,
          home: Stack(
            children: [(_loginStatus == 0) ? LoginScreen() : HomeScreen()],
          ),
          theme: ThemeData(
            primarySwatch: Colors.blue, 
          ),
          routes: <String, WidgetBuilder>{
            '/login': (BuildContext context) => LoginScreen(),
            '/home': (BuildContext context) => HomeScreen(),
            'setting': (BuildContext context) => SettingsScreen(),
            '/servicio': (BuildContext context) => ServiciosScreen(),
            '/detalleServicio': (BuildContext context) => DetalleServicioScreen(), 
            '/anexo': (BuildContext context) => AnexoScreen(), 
            '/insumo': (BuildContext context) => InsumoScreen(), 
            '/personal': (BuildContext context) => EmpleadoScreen(), 
            '/maquinaria': (BuildContext context) => MaquinariaScreen(), 
            '/firma': (BuildContext context) => FirmaScreen(),
            '/fotografia': (BuildContext context) => FotografiaScreen(),     
            '/buscarServicio': (BuildContext context) => BusquedaServicioScreen(),
            '/pendientesUbicar': (BuildContext context) => PendientesUbicarScreen(),
            '/ingresoScreen': (BuildContext context) => IngresosScreen(),
            '/ingresosFiltros': (BuildContext context) => IngresosLCL(),
            '/ingresosPartidas': (BuildContext context) => IngresosPartidas(),
            '/ingresosMatriculas': (BuildContext context) => IngresosMatriculas(),
            '/ingresosIMO' : (BuildContext context) => IngresosIMO(),
            '/ingresosMedidas' : (BuildContext context) => IngresosMedidas()
          }),
    );
  }

  getSharedPrefences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _log.i('getSharedPrefences');
    setState(() {
      _loginStatus = preferences.getInt("idUsuario") ?? 0;
    });
  }
}
