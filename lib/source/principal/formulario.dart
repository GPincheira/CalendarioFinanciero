/* Archivo de página que se abre al presionar el botón "+" en la parte inferior de la pantalla principal. 
Este solo incluye una barra de opciones en que el usuario decidirá si ingresa o egresa dinero.
Según su decisión en la AppBar se mostrará un formulario diferente (ingreso.dart o egreso.dart)*/
import 'package:flutter/material.dart';
import 'package:flutter_finanzascal/source/principal/ingreso.dart'; //formularios que se incluirán
import 'package:flutter_finanzascal/source/principal/egreso.dart';

class Formulario extends StatelessWidget {  //clase Formulario sin estado
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(  //DefaultTabController donde se podrá decidir entre un ingreso o egreso
      length: 2,  //incluirá dos opciones
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text("Registro de flujo de dinero"), //titulo de la appBar
          bottom: new TabBar(           
            indicatorColor: Colors.red, //color que indicará en que opción se está
            tabs: <Widget>[
              new Tab(    //para la opción Ingreso se muestra un icono y un texto
                text: "Ingreso",
                icon: Icon(Icons.north_east, color: Colors.green[700]),
              ),
              new Tab(
                icon: Icon(Icons.south_east, color: Colors.red[700]),
                text: "Egreso",
              ),
            ],
          ),
        ),
        body: new TabBarView( //vista de la tabBar
          children: <Widget>[
            new Container(  //existe un container para cada opción, si se está en Ingreso se muestra lo de esta clase.
              child: Ingreso(),
            ),
            new Container(  //mismo caso anterior para el egreso
              child: Egreso(),
            ),
          ],
        ),
      ),
    );
  }
}

