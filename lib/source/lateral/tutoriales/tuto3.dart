import 'package:flutter/material.dart';

class Tuto3 extends StatelessWidget {
  
  static const String routeName = "/Tuto3";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Registrando un egreso"),
      ),
     body: new Container(
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Column(
                  children: <Widget> [
                    Text("Para registrar un egreso, debemos encontrarnos en la pagina principal de la App (donde se encuentra el calendario, y pulsar el boton + en la parte inferior."+
                    "\nLuego se mostrará una nueva ventana con un formulario, y se debe presionar en la parte superior derecha la opción Egreso.\n",
                    style: TextStyle(fontSize: 15)),
                    Image.asset("lib/assets/7.png"),
                    Text("\nPosteriormente se debe completar el formulario seleccionando una categoría del listado, un monto, descripción y fecha, y finalmente pulsar el botón guardar."+
                    "\nSi no hubo problemas, el nuevo registro se podrá ver en el calendario.",
                    style: TextStyle(fontSize: 15)),
                    Image.asset("lib/assets/8.png"),
                  ]
                ),
              ),
            ]
          )
        )
     ),
    );
  }
}