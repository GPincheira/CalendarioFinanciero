import 'package:flutter/material.dart';
import 'package:getflutter/components/accordian/gf_accordian.dart';
//se incluye un paquete para poder utilizar acordeones.

class Ayuda extends StatelessWidget { //clase sin estado

  static const String routeName = "/Ayuda"; //ruta que incorporará al ingresar a esta página

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: new AppBar(
          title: new Text("Preguntas frecuentes y ayuda"),  //titulo en la barra superior
        ),   
        body: Container(  //en el cuerpo se pone un contenedor, en el interior de este un center y luego columna
          child: Center(
            child: Column(  //en la columna se ingresan los diferentes acordeones con preguntas y respuestas.
              children: <Widget>[
                //cada acordeón inicia cerrado, solo muestra el título y un botón para abrir.
                //Al presionarlo se abre el contenido (respuesta) y el botón cambia a uno para cerrar.
                GFAccordion(                 
                  collapsedTitlebackgroundColor: Colors.blueGrey[50],   //colores para cuando está abierto y cerrado.
                  expandedTitlebackgroundColor: Colors.blueGrey[200],
                  collapsedIcon: Text('Ver'),     //iconos, que en este caso es texto.
                  expandedIcon: Text('Esconder'),
                  title: '¿Qué me permite hacer esta APP?', //titulo y contenido para el primer acordeón
                  content: 'Esta APP llamada Calendario Financiero te permite registrar todos tus flujos de dinero (ingresos y egresos), seleccionando las diferentes categorías a las que pertenecen. En la pantalla principal tendrás un calendario donde podrás ver todo lo que registres a diario, además de una pestaña que resume tu balance del presente mes, mostrando tu utilidad o perdida.\n Además, posee funciones extras como un historial de meses anteriores y un simulador para que fijes una meta y puedas saber cuanto debes ahorrar mensualmente para llegar a ella.',
                ),
                GFAccordion(    //se repite lo anterior para los siguientes acordeones.
                  collapsedTitlebackgroundColor: Colors.blueGrey[50],
                  expandedTitlebackgroundColor: Colors.blueGrey[200],               
                  collapsedIcon: Text('Ver'),
                  expandedIcon: Text('Esconder'),
                  title: '¿La información que ingreso en la APP, corre algún peligro?',
                  content: 'La información que ingreses en esta APP no corre ningún peligro, ninguna persona externa a tu dispositivo podrá acceder a ella.',
                ),
                GFAccordion(                 
                  collapsedTitlebackgroundColor: Colors.blueGrey[50],
                  expandedTitlebackgroundColor: Colors.blueGrey[200],
                  collapsedIcon: Text('Ver'),
                  expandedIcon: Text('Esconder'),
                  title: '¿Puedo ver mi información en mas de un dispositivo?',
                  content: 'Momentaneamente esta aplicación solo funciona de manera local, por lo que no puedes trabajar en dos dispositivos a la vez.\nDe todos modos, siempre estará la posibilidad de agregar esto en una futura versión.',
                ),
                GFAccordion(                
                  collapsedTitlebackgroundColor: Colors.blueGrey[50],
                  expandedTitlebackgroundColor: Colors.blueGrey[200], 
                  collapsedIcon: Text('Ver'),
                  expandedIcon: Text('Esconder'),
                  title: '¿Esta es la versión definitiva de la APP?',
                  content: 'No, esta APP está aun en desarrollo, por lo que sus funciones aún no están implementadas al 100%.',
                ),
                GFAccordion(                 
                  collapsedTitlebackgroundColor: Colors.blueGrey[50],
                  expandedTitlebackgroundColor: Colors.blueGrey[200],
                  collapsedIcon: Text('Ver'),
                  expandedIcon: Text('Esconder'),
                  title: '¿Que tán exacta serán los resultados que la APP entregue sobre mi dinero?',
                  content: 'La exactitud que entregue esta APP en tu balance mensual depende de lo constante que seas ingresando los diferentes movimientos de dinero que tengas. Si no ingresas todos tus flujos de dinero el resultado que el balance entregará no reflejará el dinero que realmente tienes de utilidad o perdida en el mes.',
                ),
              ],
            ),
          ),
        ),
      );
  }
}