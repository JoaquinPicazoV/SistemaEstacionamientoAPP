// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, non_constant_identifier_names, use_key_in_widget_constructors, unused_local_variable, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, camel_case_types, use_super_parameters, use_build_context_synchronously, file_names, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/menuGuardia.dart';
import 'package:postgres/postgres.dart';
import 'package:intl/intl.dart';

class confirmacionRealizada extends StatefulWidget {
  final String RUT;

  const confirmacionRealizada({Key? key, required this.RUT}) : super(key: key);
  @override
  _confirmacionRealizada createState() => _confirmacionRealizada();
}

class _confirmacionRealizada extends State<confirmacionRealizada> {
  @override
  void initState() {
    RUT = widget.RUT;
    super.initState();
    BuscarDatos(RUT);
  }

  late String RUT = '';
  String nombre = "Buscando...";
  String rol = 'Buscando...';
  String nEstacionamiento = 'Buscando...';

  late Connection _db;
  Future<void> BuscarDatos(RUT) async {
    Connection _db = DatabaseHelper().connection;

    final datosUsuario = await _db.execute(
        "SELECT usua_nombre, usua_apellido_paterno, usua_apellido_materno, usua_tipo FROM USUARIO WHERE usua_rut='$RUT'");
    if (datosUsuario.toString() == '[]') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('AVISO'),
            content: Text(
                'No tiene reserva. ¿Qué pudo pasar?. Quizás no realizó su reserva correctamente, ingresó mal el RUT o se presentó después de que pasaron los 30 min desde que hizo la reserva, el cual es el tiempo límite para presentarse, de caso contrario se cancela su reserva automáticamente. Si está seguro que estos motivos no son la causa, notifique el error al administrador para enviar reporte al grupo de desarrollo.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => menuGuardia(RUT : RUT),
                    ),
                  );
                },
                child: Text('¡Entendido!'),
              ),
            ],
          );
        },
      );
    } else {
      final reserva = await _db.execute(
          "SELECT rese_esta_id FROM RESERVA WHERE rese_usua_rut='$RUT' AND rese_estado='EN ESPERA'");
      final ID = reserva[0][0].toString();
      final nEsta = await _db.execute(
          "SELECT esta_numero FROM ESTACIONAMIENTO WHERE esta_id='$ID'");

      setState(() {
        nombre = datosUsuario[0][0].toString() +
            datosUsuario[0][1].toString() +
            '' +
            datosUsuario[0][2].toString();
        rol = datosUsuario[0][3].toString();
        nEstacionamiento = nEsta[0][0].toString();
      });
      DateTime actual = DateTime.now();
      String fechaFormato = DateFormat('dd-MM-yy').format(actual);

      String horaFormato = DateFormat('HH:mm:ss').format(actual);
      final actualizarReserva = await _db.execute(
          "UPDATE RESERVA SET rese_estado='CONFIRMADA', rese_hora_llegada='$horaFormato' WHERE rese_usua_rut='$RUT' AND rese_estado='EN ESPERA'");
      final actualizarEstacionamiento = await _db.execute(
          "UPDATE ESTACIONAMIENTO SET esta_estado='OCUPADO' WHERE esta_id='$ID'");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: SafeArea(
          child: FractionallySizedBox(
            widthFactor: 0.81,
            heightFactor: 0.95,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: Image.asset(
                          "assets/img/LogoSolo.png",
                          fit: BoxFit.fitHeight,
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.blue.shade700,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 150,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'CONFIRMACIÓN REALIZADA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Text(
                          'NOMBRE:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            '$nombre',
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'RUT:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$RUT',
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'ROL:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$rol',
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          'ESTACIONAMIENTO:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '$nEstacionamiento',
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => menuGuardia(RUT : RUT),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: Text(
                        'VOLVER AL MENÚ PRINCIPAL',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
