import 'package:postgres/postgres.dart';

Future<Result> getEstacionamiento(Connection db) async {
  final result = await db.execute('SELECT * FROM estacionamiento');
  return result;
}

Future<Result> getEdificio(Connection db) async {
  final result = await db.execute('SELECT * FROM edificio');
  return result;
}

Future<Result> getGuardia(Connection db) async {
  final result = await db.execute('SELECT * FROM guardia');
  return result;
}

Future<Result> getRegistrousuariovehiculo(Connection db) async {
  final result = await db.execute('SELECT * FROM registrousuariovehiculo');
  return result;
}

Future<Result> getReserva(Connection db) async {
  final result = await db.execute('SELECT * FROM reserva');
  return result;
}

Future<Result> getSeccion(Connection db) async {
  final result = await db.execute('SELECT * FROM seccion');
  return result;
}

Future<Result> getUsuario(Connection db) async {
  final result = await db.execute('SELECT * FROM usuario');
  return result;
}

Future<Result> getVehiculo(Connection db) async {
  final result = await db.execute('SELECT * FROM vehiculo');
  return result;
}

//Future<Result> insertEstacionamiento(Connection db) async {}
