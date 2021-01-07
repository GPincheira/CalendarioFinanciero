//Se presenta un calendario en que se podrán mostrar Eventos (en este caso registros de ingreso y egreso)
import 'package:flutter/material.dart';
import 'package:flutter_finanzascal/res/event_firestore_service.dart';  //para bd de firebase
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_finanzascal/model/event.dart';
import 'package:intl/intl.dart';  //para utilizar fechas

class Calendario extends StatelessWidget {  //Clase sin estado
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  //no se muestra banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarioPage(), //se llama como home a la clase CalendarioPage
    );
  }
}

class CalendarioPage extends StatefulWidget { //clase con estado
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {  //Clase extiende el estado de clase anterior
  CalendarController _controller;   //se utiliza un controlador de calendario, mapa con fecha y lista, y una lista
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  @override
  void initState() {  //se inicializa el estado, y el mapa y lista se ponen vacíos
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

//mapa con fecha y lista en que se almacenaran los diferentes eventos con una fecha asociada
  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) { //se recorren los eventos dando formato de fecha
      DateTime date = DateTime(
        event.fecha.year, event.fecha.month, event.fecha.day, 12);
      if (data[date] == null) data[date] = [];  
      data[date].add(event);
    });
    return data;  //Se retorna la data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<EventModel>>(  //en el body se presenta un streambuilder con una lista para presentar los eventos
        stream: eventDBS.streamList(),  //stream viene incluido por la clase anterior
        builder: (context, snapshot) {
          if (snapshot.hasData) { //si snapshot tiene datos, se almacenan estos en una lista llamada allEvents
            List<EventModel> allEvents = snapshot.data;
            if (allEvents.isNotEmpty) {   //si hay datos se llama para almacenar los datos en lista y mapa
              _events = _groupEvents(allEvents);  
            } else {  //si esta lista es vacía si inicializan las listas como vacías
              _events = {};
              _selectedEvents = [];
            }
          }
          return SingleChildScrollView( //Vista con Scroll para ir recorriendo los diferentes meses
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[ //se tienen coo hijos un container
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: TableCalendar( //como hijo se presenta TableCalendar, donde se mostrará el calendario
                    locale: 'es_ES',  //se pone en formato español
                    events: _events,  
                    initialCalendarFormat: CalendarFormat.month,  //calendario se inicializa con vista de mes
                    availableCalendarFormats: const { //2 formatos de vista disponible, mensual y semanal
                      CalendarFormat.month: 'Mensual',
                      CalendarFormat.week: 'Semanal',
                    },
                    calendarStyle: CalendarStyle( //estilos visuales para el calendario (letra, colores, etc)
                      canEventMarkersOverflow: true,
                      todayColor: Colors.black,
                      selectedColor: Theme.of(context).primaryColor,
                      todayStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white)),
                    headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false,
                    ),
                    startingDayOfWeek: StartingDayOfWeek.monday,  //se pone en formato en que semana comienza en Lunes
                    onDaySelected: (date, events, holidays) { //cambio de estado para el día seleccionado con sus eventos
                      setState(() {
                        _selectedEvents = events;
                      });
                    },
                    builders: CalendarBuilders( //constructor del calendario y sus estilos y decoraciones
                      selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(2.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                      todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),  //se pasa la fecha a string para imprimirla
                        )),
                    ),
                    calendarController: _controller,  //calendarController recibe el valor de controller (privado)
                  ),
                ),
                Padding(  //Padding en que se presenta un título para parte inferior de la pantalla principal
                  padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[ //se presenta un título
                      Text("Registros del día", textAlign: TextAlign.center, style: TextStyle(fontSize: 22)),
                      if (_controller.selectedDay != null)  //si hay un día seleccionado se muestra cuál es
                        Text(DateFormat("dd-MM-yyyy").format(_controller.selectedDay), style: TextStyle(fontSize: 18)),
                      if (_selectedEvents.length == 0)  //y si no hay eventos para este día se muestra un mensaje
                        Text("\nNo hay registros para este día"),
                    ],
                  ),
                ),
                ..._selectedEvents.map((event) => Container(  //mapa con eventos del día seleccionado
                  width: 370, 
                  decoration: BoxDecoration(  
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListTile(    //se presentan como un listado dentro de un contenedor
                  //si se presiona en un evento se abrirá una ventana de dialogo que mostrará detalles del registro
                    onTap: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Row(
                            children:[
                              if (event.tipo == "Ingreso")   //si el evento es un ingreso irá con un logo color verde
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Icon(
                                    Icons.attach_money,
                                    color: Colors.green,
                                  ))
                              else  //si es un egreso el logo será de color rojo
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Icon(
                                    Icons.money_off,
                                    color: Colors.red,
                                  )),
                              Text(event.categoria+" ("+event.tipo+")"),
                            ]
                          ), 
                          content:  //se presenta en el contenido del cuadro la información sobre el registro
                            Text("Descripción: "+event.descripcion+
                            "\nMonto: CLP "+event.monto+
                            "\nFecha: "+ (DateFormat("dd-mm-yyyy").format(event.fecha))),
                          actions: [
                            TextButton( //e incluye un botón para cerrar el cuadro de dialogo
                              onPressed: () => Navigator.pop(context, false), //se desapila el contenido al cerrar
                              child: Text("Cerrar",
                                style: TextStyle(color: Colors.grey.shade700),
                              )),
                          ],
                        ),
                      );
                    },
                    title: new Row( //corresponde a una fila por cada registro que se muestre para un día
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(event.categoria),  //si la categoría es Ingreso se muestra el monto en verde, sino en rojo
                        if (event.tipo == "Ingreso") 
                          Text("CLP "+event.monto, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold))
                        else
                          Text("CLP - "+event.monto, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)), 
                      ],
                    ),
                    trailing: IconButton( //dentro del listTile se agrega un trailing que contiene un icono
                      icon: Icon(Icons.delete), //correspondiente a un basurero para eliminar el registro
                      onPressed: () async { //si el icono se presiona se abre un cuadro de dialogo para preguntar si está seguro
                        final confirm = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Eliminar Registro"), //titulo y texto del cuadro de diálogo
                            content: Text("¿Está seguro de eliminar este registro?"),
                            actions: [
                              TextButton( 
                                  onPressed: () => Navigator.pop(context, true),  //si se presiona Si, se hace un pop en el contenido
                                  child: Text("Si",
                                    style: TextStyle(color: Colors.red),  
                                  )),
                              TextButton(
                                onPressed: () => Navigator.pop(context, false), //opcion No, para volver atrás
                                child: Text("No",
                                  style: TextStyle(color: Colors.grey.shade700),
                                )),
                            ],
                          ),
                        ) ?? false;
                        if (confirm) {  //si se confirma la eliminación, se elimina de la BD con removeItem y su identificador
                          await eventDBS.removeItem(event.id);
                        }
                      },
                    )
                )),)
              ],
            ),
          );
        }),
    );
  }
}
