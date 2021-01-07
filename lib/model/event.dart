import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem{
  final String id;
  final String tipo;
  final String categoria;
  final String descripcion;
  final DateTime fecha;
  final String monto;

  EventModel({this.id,this.tipo,this.categoria, this.descripcion, this.fecha, this.monto}):super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      tipo: data['tipo'],
      categoria: data['categoria'],
      descripcion: data['descripcion'],
      fecha: data['fecha'],
      monto: data['monto'],
    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    return EventModel(
      id: id,
      tipo: data['tipo'],
      categoria: data['categoria'],
      descripcion: data['descripcion'],
      fecha: data['fecha'].toDate(),
      monto: data['monto'],
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "tipo":tipo,
      "categoria":categoria,
      "descripcion": descripcion,
      "fecha":fecha,
      "monto":monto,
      "id":id,
    };
  }
}