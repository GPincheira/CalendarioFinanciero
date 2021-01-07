import 'package:flutter/material.dart';

class Tutoriales extends StatelessWidget {  //clase Tutoriales, sin estado, que mostrará el listado de tutoriales
  
  static const String routeName = "/Tutoriales";  //ruta de la pagina

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: new AppBar( 
          title: new Text("Preguntas frecuentes y ayuda"),  //titulo de la barra de app
        ),
        body: Container(  //en el cuerpo se muestra un container, este lleva como hijo un center y luego columna
          child: Center(
            child: Column(
              children: <Widget>[
                new Divider(),  //dentro de la columna se utilizan divider para dividir espacios
                new ListTile(   //lisTile que presentará un titulo e ícono para un tutorial
                  title: new Text("Navegar por las distintas secciones de la APP"),
                  trailing: new Icon(Icons.keyboard_arrow_right),
                  onTap: () { //si se presiona sobre esta barra para el tutorial, se va hacia este y se pone en el navigator.
                    Navigator.of(context).pushNamed("/Tuto1");
                  }),
                new Divider(),  //se repite lo anterior para los otros tutoriales.
                new ListTile(
                  title: new Text("Registrar un nuevo ingreso"),
                  trailing: new Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).pushNamed("/Tuto2");
                  }),
                new Divider(),
                new ListTile(
                  title: new Text("Registrar un nuevo egreso"),
                  trailing: new Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).pushNamed("/Tuto3");
                  }),
                new Divider(),
                new ListTile(
                  title: new Text("Visualizar registros en el calendario"),
                  trailing: new Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).pushNamed("/Tuto4");
                  }),
                new Divider(),
                new ListTile(
                  title: new Text("Revisar el balance mensual"),
                  trailing: new Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).pushNamed("/Tuto5");
                  }),
                new Divider(),
                new ListTile(
                  title: new Text("Revisar historial financiero"),
                  trailing: new Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).pushNamed("/Tuto6");
                  }),
                new Divider(), 
              ],
            ),
          ),
        ),
      );
  }
}
