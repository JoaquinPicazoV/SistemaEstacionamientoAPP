// ignore_for_file: file_names, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/GuardiaMapa.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/menuGuardia.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:flutter_application_1/sesion.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminGuardia1 extends StatefulWidget {
  final String rut, nombreUsuario;
  const AdminGuardia1({super.key, required this.rut, required this.nombreUsuario});

  @override
  _AdminGuardia1State createState() => _AdminGuardia1State();
}

class _AdminGuardia1State extends State<AdminGuardia1> {
  late String RUT, nombreUsuario;
  TextEditingController patente1Controller = TextEditingController();
  TextEditingController patente2Controller = TextEditingController();
  TextEditingController rutController = TextEditingController();
  bool correcto = false;

  @override
  void initState() {
    RUT = widget.rut;
    nombreUsuario = widget.nombreUsuario;
    super.initState();
  }

  Future<void> hacerReserva() async {}

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        dispose();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MenuGuardia(RUT: RUT, nombreUsuario: nombreUsuario),
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
                      const SizedBox(height: 20),
                      const Text(
                        'Otorgar estacionamiento',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade700,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade500,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "1",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Completar datos",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "DATOS CONDUCTOR",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "RUT",
                              textAlign: TextAlign.start,
                            ),
                            TextFormField(
                              controller: rutController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || !validarRut(value)) {
                                  correcto = false;
                                  return 'Ingrese un RUT valido';
                                } else {
                                  correcto = true;
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                border: OutlineInputBorder(),
                                labelText: '20545267-1',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                ),
                                counterText: '',
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "DATOS VEHÍCULO",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Patente",
                              textAlign: TextAlign.start,
                            ),
                            TextFormField(
                              controller: patente1Controller,
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
                                labelText: 'GGXR32',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                ),
                                counterText: '',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'RESERVAR',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GuardiaMapa(),
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.6,
                        child: Container(
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Liberar estacionamiento',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade700,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade500,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "1",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Completar datos",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "DATOS",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              "Patente",
                              textAlign: TextAlign.start,
                            ),
                            TextFormField(
                              controller: patente2Controller,
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
                                labelText: 'GGXR32',
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                ),
                                counterText: '',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'LIBERAR ESTACIONAMIENTO',
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
                      const SizedBox(
                        height: 20,
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

  bool validarRut(String input) {
    RegExp regex = RegExp(r'^\d{7,8}-[\dkK]$');

    if (regex.hasMatch(input)) {
      List<String> rutSplit = input.split('-');
      String rut = rutSplit[0];
      String digV = rutSplit[1];
      int sum = 0;
      int j = 2;

      if (digV == 'K') {
        digV = 'k';
      }

      for (int i = rut.length - 1; i >= 0; i--) {
        sum += int.parse(rut[i]) * j;
        j++;
        if (j > 7) {
          j = 2;
        }
      }

      int vDiv = sum ~/ 11;
      int vMult = vDiv * 11;
      int vRes = sum - vMult;
      int vFinal = 11 - vRes;

      if (digV == 'k' && vFinal == 10) {
        return true;
      } else if (digV == '0' && vFinal == 11) {
        return true;
      } else if (int.parse(digV) == vFinal) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
