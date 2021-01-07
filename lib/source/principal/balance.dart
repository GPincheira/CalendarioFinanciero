import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getflutter/components/accordian/gf_accordian.dart';

class Balance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BalancePage(),
    );
  }
}

class BalancePage extends StatefulWidget {
  @override
  _BalancePageState createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {

  var cantidad = FirebaseFirestore.instance.collection('events').where('fecha', isLessThanOrEqualTo : DateTime(DateTime.now().year, DateTime.now().month, 31)).
    where('fecha', isGreaterThanOrEqualTo : DateTime(DateTime.now().year, DateTime.now().month, 01));



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
               child: Center(
            child: Column(
              children: <Widget>[
                GFAccordion(
                  collapsedTitlebackgroundColor: Colors.green[200],
                  expandedTitlebackgroundColor: Colors.green[200],
                  collapsedIcon: Text('Ver'),
                  expandedIcon: Text('Esconder'),
                  title: 'Ingresos',
                  content: "Salario : "+
                           "\nIngreso por Ventas : "+
                           "\nDevolución de Dinero : "+
                           "\nPrestamo Solicitado : "+
                           "\nOtro"),
                GFAccordion(
                  collapsedTitlebackgroundColor: Colors.red[200],
                  expandedTitlebackgroundColor: Colors.red[200],
                  collapsedIcon: Text('Ver'),
                  expandedIcon: Text('Esconder'),
                  title: 'Egresos',
                  content: "Pago Luz : "+
                           "\nPago Agua : "+
                           "\nPago/Compra de Gas: "+
                           "\nPlanes Televisión: "+
                           "\nPlanes/Recargas Telefonía: "+
                           "\nPago a trabajador: "+
                           "\nPago Tarjetas: "+
                           "\nCuotas: "+
                           "\nCompra Supermercado: "+
                           "\nTransporte: "+
                           "\nEducación: "+
                           "\nSalud: "+
                           "\nEntretención: "+
                           "\nRegalos: "+
                           "\nOtro"),
              ]
            )
        )
      )
    );
  }
}

/*Widget _buildItem(int cantidad, String monto) {
  
  return new ListTile(
      isThreeLine: false,
      tileColor: Colors.green[100],
      title: new Text("CLP "+cantidad.toString(), style: TextStyle(color: Colors.black, fontSize: 22)),  
  );
}

int Calculo(int suma, String monto) {
  suma = suma + int.parse(monto);
  return suma;
} */