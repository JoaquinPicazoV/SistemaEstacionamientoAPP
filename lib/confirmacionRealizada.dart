// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, camel_case_types, non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/menuGuardia.dart';
import 'package:postgres/postgres.dart';
import 'package:intl/intl.dart';

class ConfirmacionRealizada extends StatefulWidget {
  final String RUT, nombreUsuario;
  const ConfirmacionRealizada({super.key, required this.RUT, required this.nombreUsuario});

  @override
  _confirmacionRealizada createState() => _confirmacionRealizada();
}

class _confirmacionRealizada extends State<ConfirmacionRealizada> {
  @override
  void initState() {
    RUT = widget.RUT;
    super.initState();
    buscarDatos(RUT);
  }

  late String RUT = '';
  String nombre = "Buscando...";
  String rol = 'Buscando...';
  String nEstacionamiento = 'Buscando...';

  Future<void> buscarDatos(RUT) async {
    Connection _db = DatabaseHelper().connection;

    final datosUsuario = await _db.execute("SELECT usua_nombre, usua_apellido_paterno, usua_apellido_materno, usua_tipo FROM USUARIO WHERE usua_rut='$RUT'");
    if (datosUsuario.toString() == '[]') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('AVISO'),
            content: const Text(
                'No tiene reserva. ¿Qué pudo pasar?. Quizás no realizó su reserva correctamente, ingresó mal el RUT o se presentó después de que pasaron los 30 min desde que hizo la reserva, el cual es el tiempo límite para presentarse, de caso contrario se cancela su reserva automáticamente. Si está seguro que estos motivos no son la causa, notifique el error al administrador para enviar reporte al grupo de desarrollo.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuGuardia(RUT: RUT, nombreUsuario: widget.nombreUsuario),
                    ),
                  );
                },
                child: const Text('¡Entendido!'),
              ),
            ],
          );
        },
      );
    } else {
      final reserva = await _db.execute("SELECT rese_esta_id FROM RESERVA WHERE rese_usua_rut='$RUT' AND rese_estado='EN ESPERA'");
      final ID = reserva[0][0].toString();
      final nEsta = await _db.execute("SELECT esta_numero FROM ESTACIONAMIENTO WHERE esta_id='$ID'");

      setState(() {
        nombre = '${datosUsuario[0][0]} ${datosUsuario[0][1]} ${datosUsuario[0][2]}';
        rol = datosUsuario[0][3].toString();
        nEstacionamiento = nEsta[0][0].toString();
      });
      DateTime actual = DateTime.now();
      String fechaFormato = DateFormat('dd-MM-yy').format(actual);

      String horaFormato = DateFormat('HH:mm:ss').format(actual);
      final actualizarReserva = await _db.execute("UPDATE RESERVA SET rese_estado='CONFIRMADA', rese_hora_llegada='$horaFormato' WHERE rese_usua_rut='$RUT' AND rese_estado='EN ESPERA'");
      final actualizarEstacionamiento = await _db.execute("UPDATE ESTACIONAMIENTO SET esta_estado='OCUPADO' WHERE esta_id='$ID'");
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
                    const SizedBox(height: 20),
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.blue.shade700,
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 150,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'CONFIRMACIÓN REALIZADA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Text(
                          'NOMBRE:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            nombre,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'RUT:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          RUT,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'ROL:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          rol,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Text(
                          'ESTACIONAMIENTO:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          nEstacionamiento,
                          overflow: TextOverflow.visible,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MenuGuardia(RUT: RUT, nombreUsuario: widget.nombreUsuario),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      label: const Text(
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
