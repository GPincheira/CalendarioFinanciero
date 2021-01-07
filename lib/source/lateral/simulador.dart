import 'package:flutter/material.dart';

class Simulador extends StatelessWidget {
  
  static const String routeName = "/Simulador";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Simulador"),
      ),
      body: new Container(
        child: new Center(
          child: new Text("Simulador para saber cuanto ahorrar para llegar a cierta cantidad en un tiempo")
        ) 
      ),
    );
  }
}