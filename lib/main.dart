//Germán Pincheira Leiva (19.387.547-5) - ICI (malla por objetivos)

//diferentes paquetes utilizados, incluidos para el uso de firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finanzascal/source/home.dart';
import 'package:intl/date_symbol_data_local.dart' ;
import 'package:flutter_localizations/flutter_localizations.dart';
 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();  //para el funcionamiento de firebase
  await Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(MyApp())); //initializeDateFormatting para edición de calendario.
}


