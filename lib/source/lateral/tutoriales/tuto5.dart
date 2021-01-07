import 'package:flutter/material.dart';

class Tuto5 extends StatelessWidget {
  
  static const String routeName = "/Tuto5";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Revisar el balance mensual"),
      ),
      body: new Container(
        child: new Center(
          child: new Text("Revisar el balance mensual")
        ) 
      ),
    );
  }
}