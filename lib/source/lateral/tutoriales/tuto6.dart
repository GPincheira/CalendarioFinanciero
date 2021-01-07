import 'package:flutter/material.dart';

class Tuto6 extends StatelessWidget {
  
  static const String routeName = "/Tuto6";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Revisar historial financiero"),
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
                    Text("Al presionar las 3 lineas en la parte superior izquierda, se abre el menú lateral que tiene la opción Historial"+
                    "\nAl pulsar en él se muestra el historial de transacciones, que está ordenado por fecha (desde lo más antiguo a lo más reciente"+
                    "\nSe muestran con fondo rojo los egresos y con fondo verde los ingresos.\n",
                    style: TextStyle(fontSize: 15)),
                    Image.asset("lib/assets/12.png"),
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