//Ingreso está inserto dentro de formulario, se muestra si en la Tab superior está seleccionada esta opcion

import 'package:flutter_finanzascal/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_finanzascal/res/event_firestore_service.dart';
//se utilizará firestore

class Egreso extends StatefulWidget {   //clase con estado
  final EventModel note;              //se crea note que será de tipo EventModel

  const Egreso({Key key, this.note}) : super(key: key);   //constante Ingreso incluirá una key y un EventModel

  @override
  _EgresoState createState() => _EgresoState();
}

class _EgresoState extends State<Egreso> {  //clase que extiende la anterior
  String _tipo;             //variables que se utilizarán pra almacenar las opciones del usuario
  TextEditingController _descripcion;   //variables para poder ingresar texto
  TextEditingController _monto;
  DateTime _fecha;
  //se agrega una lista de string con las diferentes categorías que se pueden seleccionar como Egresar
  List<String> categorias = <String>['Pago Luz', 'Pago Agua', 'Pago/Compra de Gas', 'Planes Televisión', 'Planes/Recargas Telefonía', 'Pago a trabajador', 'Pago Tarjetas', 'Cuotas', 'Compras Supermercado', 'Transporte', 'Educación', 'Salud', 'Entretención', 'Regalos', 'Otro'];
  String _categoria = 'Pago Luz';
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;  //booleano para mostrar si está o no procesando

  @override
  void initState() {  //initState, metodo utilizado para inicializar algunas variables
    super.initState();
    _tipo = "Egreso";   //como es un egreso, el tipo no será modificado por el usuario
    _categoria = "Pago Luz";  //categoria se selecciona de una lista, se inicializa en la primera opción
    //los string que se completarán por teclado se manejan con un TextEditingController
    _descripcion = TextEditingController(text:  widget.note != null ? widget.note.descripcion : "");
    _monto = TextEditingController(text:  widget.note != null ? widget.note.monto : "");
    _fecha = DateTime.now();  //fecha se inicializa en el día actual
    processing = false;
  }

  @override
  Widget build(BuildContext context) {  //constructor del formulario
    return Scaffold(
      key: _key,
      body: Form(
        key: _formKey,
        child: Container( //formulario con un contenedor alineado al centro
          alignment: Alignment.center,
          child: ListView(  //se utilizará una vista de lista
            children: <Widget>[
              Padding(  //tiene como hijos diferentes padding con simetría
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
                child: Column( //padding tiene como hijo una columna
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Registrar Egreso", style: TextStyle(fontSize: 28),), //mostrará un texto como título
                  ],
                ),
              ),
              Padding(  //se agrega un nuevo padding para cada elemento del formulario
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: new FormField( //incluye un campo de formulario que tiene estado
                  builder: (FormFieldState state) {
                    return InputDecorator(  //aspecto del campo de formulario, con icono, texto, color y borde
                      decoration: InputDecoration(
                        icon: new Icon(Icons.category),
                        labelText: 'Categoría', 
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      isEmpty: _categoria == '',
                      child: new DropdownButtonHideUnderline( //desplegable con opciones para elegir como categoría
                        child: new DropdownButton(
                          value: _categoria,  //se pondrá en value la elección en el Dropdown
                          isDense: true,
                          onChanged: (String newValue) {  //cuando hay cambio de categoría hay un cambia el estado 
                            setState(() {
                              _categoria = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: categorias.map((String value) {  //se muestran los textos de las diferentes categorias
                            return new DropdownMenuItem(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(  //padding para campo de ingreso de monto
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _monto, //controller para determinar el valor de monto
                  validator: (value) => (value.isEmpty) ? "Ingrese el monto" : null, //validacion por si no se ingresa monto
                  keyboardType: TextInputType.number, //se mostrará un teclado numérico
                  decoration: InputDecoration(
                    icon: new Icon(Icons.monetization_on),
                    labelText: "Monto",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding( //padding para campo de ingreso de descripción
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: TextFormField(
                  controller: _descripcion,
                  minLines: 2,  //se mostrará un campo de minimo 2 y maximo 4 líneas
                  maxLines: 4,
                  validator: (value) => (value.isEmpty) ? "Ingrese una descripcion" : null,
                  decoration: InputDecoration(
                    icon: new Icon(Icons.description),
                    labelText: "Descripcion",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(  //padding para fecha
                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                child: ListTile(  //se mostrará esta vez un lisTile, con un icono
                  leading: Icon(Icons.calendar_today),
                  title: Text("Fecha"), //el titulo será fecha, y subtitulo la fecha que se eligió
                  subtitle: Text("${_fecha.day} - ${_fecha.month} - ${_fecha.year}"),
                  onTap: ()async{ //al presionar, se muestra un calendario para seleccionar el día que se quiera
                    DateTime picked = await showDatePicker(context: context, initialDate: _fecha, firstDate: DateTime(_fecha.year-10), lastDate: DateTime(_fecha.year+10));
                    if(picked != null) {
                      setState(() {       //si hay cambios se registan en fecha
                        _fecha = picked;
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 10.0),
              processing  //circulo girando se mostrará solo si se está procesando
                ? Center(child: CircularProgressIndicator())
                : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),  //padding para botón guardar
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(30.0),
                    color: Theme.of(context).primaryColor,
                    child: MaterialButton(
                      onPressed: () async { //al presionar se valida antes de guardar
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            processing = true;
                          });
                          final data = {  //se compone la data con lo ingresado por el usuario
                            "tipo" : _tipo,
                            "categoria": _categoria,
                            "descripcion": _descripcion.text,
                            "fecha": _fecha,
                            "monto": _monto.text,
                          };
                          if (widget.note != null) {  //se actualiza o se crea según corresponda
                            await eventDBS.updateData(widget.note.id, data);
                          } else {
                            await eventDBS.create(data);
                          }
                          Navigator.pop(context); //se quita del navegador
                          setState(() {
                            processing = false;
                          });
                        }
                      },
                      child: Text("Guardar", style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descripcion.dispose();
    _monto.dispose();
    super.dispose();
  }
}

