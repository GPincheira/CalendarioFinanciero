//Archivo que mostrará un tutorial, en este caso para navegar por la App.
//La explicación de este código es igual para las otras páginas de tutoriales.

import 'package:flutter/material.dart';


class Tuto1 extends StatelessWidget { //clase sin estado
  
  static const String routeName = "/Tuto1"; //registra una ruta llamada Tuto1

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: new AppBar(       //se muestra un texto en la barra 
        title: new Text("Navegando por la App"),
      ),
      body: new Container(  //contenedor que lleva un padding utilizado para poner bordes.
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(  //Columna que tiene como hijo un expanded.
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Column(  //el expanded tiene como hijo una columna que llevará diferentes textos
                  children: <Widget> [
                    Text("Al entrar en la App, se puede apreciar un calendario donde se pueden registrar eventos, con un espacio bajo el para visualizar registros."+
                          "\nEn la parte inferior de la pagina principal hay acceso a 3 secciones diferentes:",
                          style: TextStyle(fontSize: 15)),
                    Image.asset("lib/assets/1.png"),  //también se incluyen imágenes entregando su ruta en el proyecto.
                    Text("\nSi se presiona en la parte izquierda (Calendario), la APP nos lleva hacia el calendario donde se pueden ver o eliminar registros, que es la sección en que nos encontramos actualmente."+
                          "\nSi se presiona en la parte derecha (Balance), la APP nos lleva a una sección que resume los ingresos y gastos durante el mes en curso"+
                          "\nSi se presiona el botón central (+) la APP nos lleva hacia una nueva página donde se pueden registrar nuevos ingresos o egresos.",
                          style: TextStyle(fontSize: 15)),
                          Image.asset("lib/assets/2.png"),
                    Text("\nPor otra parte, en la barra superior, en la parte izquierda se pueden ver 3 líneas, que al presionar desplega un menú con el que se puede ir hacia diferentes secciones:"+
                          "\n- Principal: es la sección en que nos encontramos actualmente, la que incluye el calendario, balance y el ingreso de nuevos registros."+
                          "\n- Historial: Muestra en orden todos los ingresos y egresos que se han registrando, indicando con color verde y rojo según corresponda"+
                          "\n- Tutoriales: Muestra tutoriales para realizar diferentes acciones."+
                          "\n- Preguntas frecuentes y ayuda.",
                          style: TextStyle(fontSize: 15)),
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