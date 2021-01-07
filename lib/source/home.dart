//paquetes utilizados y referencias a las distintas rutas que se llevará
import 'package:flutter/material.dart';
import 'package:flutter_finanzascal/source/lateral/historial.dart';
import 'package:flutter_finanzascal/source/lateral/simulador.dart';
import 'package:flutter_finanzascal/source/lateral/ayuda.dart';
import 'package:flutter_finanzascal/source/lateral/tutoriales.dart';
import 'package:flutter_finanzascal/source/principal/calendario.dart';
import 'package:flutter_finanzascal/source/principal/balance.dart';
import 'package:flutter_finanzascal/source/principal/formulario.dart';
import 'package:flutter_finanzascal/source/lateral/tutoriales/tuto1.dart';
import 'package:flutter_finanzascal/source/lateral/tutoriales/tuto2.dart';
import 'package:flutter_finanzascal/source/lateral/tutoriales/tuto3.dart';
import 'package:flutter_finanzascal/source/lateral/tutoriales/tuto4.dart';
import 'package:flutter_finanzascal/source/lateral/tutoriales/tuto5.dart';
import 'package:flutter_finanzascal/source/lateral/tutoriales/tuto6.dart';

class MyApp extends StatelessWidget { //clase MyApp, sin estado. Se llama desde main
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //para ocultar el banner de Debug.
      home: Home(), //se muestra en la pagina lo que se incluye en la clase Home
      routes: <String, WidgetBuilder>{    //rutas a las que se llevará desde esta página
        Historial.routeName: (BuildContext context) => new Historial(),
 //       Simulador.routeName: (BuildContext context) => new Simulador(),
        Tutoriales.routeName: (BuildContext context) => new Tutoriales(),
        Ayuda.routeName: (BuildContext context) => new Ayuda(),
        Tuto1.routeName: (BuildContext context) => new Tuto1(),
        Tuto2.routeName: (BuildContext context) => new Tuto2(),
        Tuto3.routeName: (BuildContext context) => new Tuto3(),
        Tuto4.routeName: (BuildContext context) => new Tuto4(),
        Tuto5.routeName: (BuildContext context) => new Tuto5(),
        Tuto6.routeName: (BuildContext context) => new Tuto6(),
      },
    );
  }
}

class Home extends StatefulWidget{  //clase con estado, es llamada desde la clase anterior.
  @override 
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> { //clase que extiende estado de home
  Drawer _getDrawer(BuildContext context){    //drawer (barra lateral izquierda)
    ListTile _getPage(Icon icon, String title, String route){
      return new ListTile(
        leading: icon,
        title: new Text(title), //se utiliza el titulo de la opción a elegir
        onTap: (){
          setState(() {
            Navigator.of(context).pushNamed(route); //al presionar, se hace un push con la ruta de la clase que se elegirá
          });
        },
      );
    }

    ListView listView = new ListView(children: <Widget>[  //vista en lista de las opciones que tendrá el drawe
      _getPage(new Icon(Icons.home), "Principal", "/"),   //cada opcion muestra un icono y titulo, y lleva una ruta
      _getPage(new Icon(Icons.history), "Historial", "/Historial"), 
   //   _getPage(new Icon(Icons.timeline), "Simulador", "/Simulador"),
      _getPage(new Icon(Icons.tour), "Tutoriales", "/Tutoriales"),
      _getPage(new Icon(Icons.help), "Preguntas frecuentes y ayuda", "/Ayuda"),
    ]);

    return new Drawer(  //el drawer tiene como hijo la lista de opciones
      child: listView,
    );
  }  

  @override
  Widget build(BuildContext context) {  //se construye la vista principal de home
    return Scaffold(
      appBar: new AppBar(   //barra con titulo
        title: new Text("Calendario de Finanzas"),
      ),
      body: Center(
        child: Dashboard(), //en su interior mostrará un dashboard
      ),
      drawer: _getDrawer(context) //incluye el drawer
    );
  }
}

class Dashboard extends StatefulWidget {  //clase sin estado para el dashboard (parte inferior)
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {  //clase que extiende la clase anterior
  int _selectedPage = 0;
  final _pageOptions = [  //opciones disponibles para mostrar
    Calendario(),
    Balance(),
  ];

  Widget build(BuildContext context) {  //constructor del dashboard

    final _bottomNav = BottomAppBar(
      shape: CircularNotchedRectangle(),  //aspectos graficos
      notchMargin: 6,
      clipBehavior: Clip.antiAlias,
      child: BottomNavigationBar( //tiene como hijo una barra con botones para las 2 posibles rutas
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedPage,  //se pone la pagina seleccionada en currentIndex  
        onTap: (int index) {
          setState(() {     //si se presiona sobre una opcion se cambia el estado 
            _selectedPage = index;
          });
        },
        items: [    //cada boton incluye un icono y texto
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: new Text("Calendario")),
          BottomNavigationBarItem(
              icon: Icon(Icons.title),title: new Text("Balance Mes")),
        ],
      ),
    );

    final _fab = FloatingActionButton(  //se agrega ademas un boton flotante que se utilizará para agregar registros
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.push( //si se presiona s ehace Push en el navegador
          context,
          MaterialPageRoute(builder: (context) => Formulario()),
        );
      },
    );

    return Scaffold(  //el body del Home incluirá la barra con opciones y el botón flotante.
      body: _pageOptions[_selectedPage],
      floatingActionButton: _fab,
      bottomNavigationBar: _bottomNav,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}