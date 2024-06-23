// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/actualizarVehiculo1.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:flutter_application_1/sesion.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActualizarVehiculo2 extends StatefulWidget {
  final String rut, nombreUsuario, patente;
  const ActualizarVehiculo2({super.key, required this.rut, required this.nombreUsuario, required this.patente});

  @override
  _ActualizarVehiculo2 createState() => _ActualizarVehiculo2();
}

class _ActualizarVehiculo2 extends State<ActualizarVehiculo2> {
  late String nombreUsuario, rut, patente;
  TextEditingController patenteController = TextEditingController();
  bool correcto = false, existe = false;
  List<bool> editar = [false];

  @override
  void initState() {
    rut = widget.rut;
    nombreUsuario = widget.nombreUsuario;
    patente = widget.patente;
    super.initState();
  }

  Future<void> editarVehiculo() async {
    db = DatabaseHelper().connection;
    await db.execute("DELETE FROM registrousuariovehiculo WHERE regi_vehi_patente='$patente' and regi_usua_rut = '$rut'");
    try {
      await db.execute("UPDATE vehiculo SET vehi_patente='${patenteController.text}' where vehi_patente = '$patente'");
    } catch (e) {
      await db.execute("INSERT INTO vehiculo(vehi_patente) VALUES ('${patenteController.text}')");
    }
    await db.execute("INSERT INTO registrousuariovehiculo(regi_usua_rut, regi_vehi_patente, regi_estado) VALUES('$rut','${patenteController.text}','inactivo')");
    Navigator.of(context, rootNavigator: true).pop('dialog');
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
            builder: (context) => MenuUsuario(RUT: rut, nombreUsuario: nombreUsuario),
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
                        'Editar un vehiculo',
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(
                              flex: 0,
                              fit: FlexFit.loose,
                              child: Text('Patente'),
                            ),
                            if (!editar[0])
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    editar[0] = true;
                                  });
                                },
                                child: Text(patente),
                              )
                            else
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      flex: 0,
                                      fit: FlexFit.loose,
                                      child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            editar[0] = false;
                                          });
                                        },
                                        icon: const Icon(Icons.close_rounded),
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      fit: FlexFit.tight,
                                      child: TextFormField(
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
                                        decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                          floatingLabelBehavior: FloatingLabelBehavior.never,
                                          border: const OutlineInputBorder(),
                                          labelText: patente,
                                          enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue),
                                          ),
                                          focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                      if (existe)
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
                                elevation: 24,
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
                              ),
                            );
                            editarVehiculo();
                          }
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Confirmar',
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
                              builder: (context) => ActualizarVehiculo(RUT: rut, nombreUsuario: widget.nombreUsuario),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'VOLVER',
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
