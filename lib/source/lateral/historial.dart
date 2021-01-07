import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
//se incluyen paquetes para el uso de BD y fechas

class Historial extends StatelessWidget{  //clase Historial sin estado

  static const String routeName = "/Historial"; //ruta utilizada

  @override 
  Widget build(BuildContext context) {  //constructor de clase que tiene como hijo a la clase ListHistorial
    return Scaffold(
      body: new Container(
        child: ListHistorial(),
      ),
    );
  }
}

class ListHistorial extends StatefulWidget{ //clase que mostrará el cuerpo de la pagina, con estado
  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<ListHistorial>{ //extiende el estado de la clase anterior

  @override
  Widget build(BuildContext context) {

    //consulta con la que se trae desde la coleccion "events" de firebase todo los elementos ordenados por fecha
    Query query = FirebaseFirestore.instance.collection('events').orderBy('fecha');
    
    return Scaffold(
      appBar: new AppBar(
        title: new Text ("Historial de registros"), //titulo de la barra de la app
      ),
      body: Column(   //cuerpo de la app que tiene una columna con un extend en su interior
        children: <Widget>[
          Expanded(   
            flex: 10,
            child: StreamBuilder<QuerySnapshot>(  //elemento para manipular el query de firebase
              stream: query.snapshots(),
              builder: (context, stream) {
                if (stream.connectionState == ConnectionState.waiting) {  //se espera si aún no finaliza de obtener datos
                  return Center(child: CircularProgressIndicator());
                }
                if (stream.hasError) {  //si hay un error se genera un texto
                  return Center(child: Text(stream.error.toString()));
                }

                QuerySnapshot querySnapshot = stream.data;

                return ListView(  //vista de lista en que mediante un for se recorrera lo obtenido de la consulta 
                  children: <Widget>[
                    for(var Docs in querySnapshot.docs) 
                      _buildItem((Docs.data()['monto']),(Docs.data()['tipo']),(Docs.data()['categoria']),(Docs.data()['fecha']).toDate()),
                      //se llama a un Widget que se creo para mostrar la información. Se le pasan los campos que se quieran del query.
                  ]
                );
              },
            )
          )
        ]
      ),
    );

  }
}

//Widget que recibe diferentes campos y mostrará la información de cada registro
Widget _buildItem(String monto, String tipo, String categoria, DateTime fecha) {
  if (tipo == "Ingreso")  //si el tipo es Ingreso, significa que entró dinero y se mostrará de una manera particular
  return new ListTile(  //se retorna un LisTile donde se mostrará la información
      isThreeLine: true,  //se habilita el uso de tercera línea
      tileColor: Colors.green[100], //se le da verde como color de fondo
      //se mostrará el monto como título, otros campos como subtitulo y un ícono de dinero.
      title: new Text("CLP "+monto, style: TextStyle(color: Colors.black, fontSize: 22)),
      subtitle: new Text("Tipo: "+tipo+" ("+categoria+")"+
      "\nFecha: "+(DateFormat("dd-MM-yyyy").format(fecha)), style: TextStyle(color: Colors.black, fontSize: 15)),
      leading: new Icon(Icons.attach_money, color: Colors.green),     
  );
  else //si el tipo es Egresp, significa que salió dinero y se mostrará de una manera particular
  return new ListTile(
      isThreeLine: true,
      tileColor: Colors.red[100], //color de fondo será rojo
      title: new Text("CLP -"+monto, style: TextStyle(color: Colors.black, fontSize: 22)), 
      subtitle: new Text("Tipo: "+tipo+" ("+categoria+")"+
      "\nFecha: "+(DateFormat("dd-MM-yyyy").format(fecha)), style: TextStyle(color: Colors.black, fontSize: 15)),
      leading: new Icon(Icons.money_off, color: Colors.red),   //icono de salida de dinero   
  );
}