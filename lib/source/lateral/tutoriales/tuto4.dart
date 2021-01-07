import 'package:flutter/material.dart';

class Tuto4 extends StatelessWidget {
  
  static const String routeName = "/Tuto4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Visualizar y eliminar registros"),
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
                    Text("Si se habia guardado algún o algunos registros, estos se pueden visualizar recorriendo el calendario."+
                    "\nAl estar en el calendario, este indicará con puntos bajo los días según la cantidad de registros que se hicieron. Al presionar sobre uno de estos días se mostrará bajo el calendario el listado de registros del día.",
                    style: TextStyle(fontSize: 15)),
                    Image.asset("lib/assets/9.png"),
                    Text("\nPara cada registro se indica el monto (en color verde si es ingreso y rojo si es egreso), y la categoría a la que pertenece."+
                    "\nSi se desea ver más información se puede pulsar sobre uno de estos registros y se mostrará un recuadro que incluye también la descripcion de dicho registro.",
                    style: TextStyle(fontSize: 15)),
                    Image.asset("lib/assets/10.png"),
                    Text("\nFinalmente, si se quiere eliminar un registro, se presiona sobre el icono de un basurero al lado derecho del registro, y se abre un cuadro donde se debe indicar si se está seguro de la decisión o no.",
                    style: TextStyle(fontSize: 15)),
                    Image.asset("lib/assets/11.png"),
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

