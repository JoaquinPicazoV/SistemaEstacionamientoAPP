// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/actualizarVehiculo1.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:flutter_application_1/sesion.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnadirVehiculo extends StatefulWidget {
  final String RUT, nombreUsuario;
  const AnadirVehiculo({super.key, required this.RUT, required this.nombreUsuario});

  @override
  _AnadirVehiculo createState() => _AnadirVehiculo();
}

class _AnadirVehiculo extends State<AnadirVehiculo> {
  late String nombreUsuario, RUT;
  TextEditingController patenteController = TextEditingController();
  bool correcto = false, existe = false, existe2 = false;

  @override
  void initState() {
    RUT = widget.RUT;
    nombreUsuario = widget.nombreUsuario;
    super.initState();
  }

  Future<void> nuevoVehiculo() async {
    db = DatabaseHelper().connection;
    try {
      await db.execute("INSERT INTO vehiculo(vehi_patente) VALUES ('${patenteController.text}')");
    } catch (e) {
      setState(() {
        existe = true;
      });
      Navigator.of(context, rootNavigator: true).pop('dialog');
      return;
    }
    try {
      await db.execute("INSERT INTO registrousuariovehiculo(regi_usua_rut, regi_vehi_patente, regi_estado) VALUES('$RUT','${patenteController.text}','inactivo')");
    } catch (e) {
      setState(() {
        existe2 = true;
      });
    }

    Navigator.of(context, rootNavigator: true).pop('dialog');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ActualizarVehiculo(RUT: RUT, nombreUsuario: nombreUsuario),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        dispose();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuUsuario(RUT: RUT, nombreUsuario: nombreUsuario),
          ),
        );
      },
      child: Scaffold(
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
                    children: [
                      //Inicio barra superior
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: SvgPicture.asset('assets/img/logo.87d5c665 1.svg', semanticsLabel: 'Logo Ulagos'),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    nombreUsuario,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(padding: EdgeInsets.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap, alignment: Alignment.centerRight),
                                    onPressed: () {
                                      clearSession();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const MyApp(),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.exit_to_app,
                                      color: Colors.red,
                                    ),
                                    label: const Text(
                                      'Cerrar Sesión',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      //Final barra superior
                      const SizedBox(
                        height: 15,
                        width: 15,
                      ),
                      const Text(
                        'Añadir un nuevo vehiculo',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                        width: 15,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Patente'),
                            TextFormField(
                              controller: patenteController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || !RegExp(r'^[a-zA-Z]{4}\d{2}$').hasMatch(value)) {
                                  correcto = false;
                                  return 'Ingrese una patente valida';
                                } else {
                                  correcto = true;
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                border: OutlineInputBorder(),
                                labelText: 'GGXX20',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (existe || existe2)
                        const Column(
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                            ),
                            Text(
                              'Esta patente ya esta en uso.',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (correcto) {
                            showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) => const AlertDialog(
                                content: SizedBox(
                                  height: 250,
                                  child: Center(
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 7,
                                        semanticsLabel: 'Circular progress indicator',
                                      ),
                                    ),
                                  ),
                                ),
                                elevation: 24,
                              ),
                            );
                            await nuevoVehiculo();
                          }
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Añadir',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                        width: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MenuUsuario(RUT: RUT, nombreUsuario: widget.nombreUsuario),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'VOLVER AL MENÚ',
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
      ),
    );
  }
}
