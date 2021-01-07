import 'package:flutter/material.dart';

class Tuto2 extends StatelessWidget {
  
  static const String routeName = "/Tuto2";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Registrando un ingreso"),
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
                    Text("Para registrar un ingreso, debemos encontrarnos en la pagina principal de la App (donde se encuentra el calendario, y pulsar el boton + en la parte inferior."+
                    "\nLuego se mostrará una nueva ventana con un formulario. Debemos estar seguros que en la parte superior estemos ubicados en ingreso y no en egreso.\n",
                    style: TextStyle(fontSize: 15)),
                    Image.asset("lib/assets/4.png"),
                    Text("\nPosteriormente se debe completar el formulario seleccionando una categoría del listado, un monto, descripción y fecha, y finalmente pulsar el botón guardar."+
                    "\nSi no hubo problemas, el nuevo registro se podrá ver en el calendario.",
                    style: TextStyle(fontSize: 15)),
                    Image.asset("lib/assets/5.png"),
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