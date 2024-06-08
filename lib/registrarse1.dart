// ignore_for_file: prefer_final_fields, prefer_const_constructors, avoid_print, unused_element, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/registrarse2.dart';
import 'package:flutter_application_1/newRegistro.dart';

class Registrarse1 extends StatefulWidget {
  @override
  _Registrarse1State createState() => _Registrarse1State();
}

class _Registrarse1State extends State<Registrarse1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreEditingController = TextEditingController();
  TextEditingController apellidoPEditingController = TextEditingController();
  TextEditingController apellidoMEditingController = TextEditingController();
  TextEditingController rutEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController telefonoEditingController = TextEditingController();
  TextEditingController patenteEditingController = TextEditingController();

  List<bool> camposValidos = [false, false, false, false, false, false, false]; // Lista de validación de campos
    bool _isButtonDisabled = false;


  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  RegExp get _numerosRegex => RegExp(r'^[0-9]*$');
  RegExp get _rutRegex => RegExp(r'^\d{1,2}\.\d{3}\.\d{3}[-][0-9kK]{1}$');
  RegExp get _patenteRegex => RegExp(r'^[a-zA-Z]{2}\d{2,4}$');
  RegExp get _telefonoRegex => RegExp(r'^9[0-9]{8}$');
  RegExp get _nombreApellidoRegex => RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$');


  bool valido = false;
  late String valueDropdown;

  @override
  void initState() {
    super.initState();
    valueDropdown = 'Estudiante';
  }

  @override
  Widget build(BuildContext context) {
    const List<String> list = ['Estudiante', 'Externo', 'Funcionario'];
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Align(
        alignment: Alignment.center,
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
                    //IMAGEN
                    FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 30),
                        child: Image.asset(
                          "assets/img/ULAGOS.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    // Texto ESTACIONAMIENTOS ULAGOS
                    const Text(
                      "ESTACIONAMIENTOS ULAGOS",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //BOTONES
                    FractionallySizedBox(
                      widthFactor: 0.85,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const MyApp()),
                                    );
                                    print('Iniciar');
                                  },
                                  child: const Text(
                                    "Iniciar sesión",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.center,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                                    backgroundColor: MaterialStatePropertyAll(
                                      Colors.blue.shade700,
                                    ),
                                  ),
                                  onPressed: () {
                                    print('Registrarse');
                                  },
                                  child: const Text(
                                    'Registrarse',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //CAJA COMPLETAR DATOS
                    FractionallySizedBox(
                      widthFactor: 0.85,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(color: Colors.blue.shade700),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //CIRCULO
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade500,
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                "1",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Text(
                              "Completar datos",
                              style: TextStyle(
                                color: Colors.white,                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Form(
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: FractionallySizedBox(
                        widthFactor: 0.85,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "DATOS PERSONALES",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textFields('Nombres(s)', 'Ingrese su nombre', nombreEditingController, TextInputType.name, _nombreApellidoRegex, 'Ingrese un nombre válido', 0),
                            textFields('Apellido Paterno', 'Ingrese su apellido paterno', apellidoPEditingController, TextInputType.name, _nombreApellidoRegex, 'Ingrese un apellido válido', 1),
                            textFields('Apellido Materno', 'Ingrese su apellido materno', apellidoMEditingController, TextInputType.name, _nombreApellidoRegex, 'Ingrese un apellido válido', 2),
                            textFields('RUT', 'Ej: 20545267-1', rutEditingController, TextInputType.text, _rutRegex, 'Ingrese un RUT válido', 3),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Tipo de Usuario",
                                  ),
                                  DropdownButtonFormField(
                                    value: valueDropdown,
                                    style: TextStyle(color: Colors.grey.shade800, fontSize: 16),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                      ),
                                    ),
                                    itemHeight: kMinInteractiveDimension + 14,
                                    isExpanded: true,
                                    items: list
                                        .map<DropdownMenuItem<String>>(
                                          (value) => DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (String? value) {
                                      setState(() {
                                        valueDropdown = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            textFields('Correo electrónico', 'Ej: correo@dominio.cl', emailEditingController, TextInputType.emailAddress, _emailRegex, 'Ingrese un email válido', 4),
                            textFields('Teléfono', 'Ej: 958472045', telefonoEditingController, TextInputType.phone, _telefonoRegex, 'Ingrese un teléfono válido', 5),
                            const Text(
                              'DATOS VEHÍCULO',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textFields('Patente', 'Ej: GGXX20', patenteEditingController, TextInputType.text, _patenteRegex, 'Ingrese una patente válida', 6),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 15,
                                ),
                                child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                backgroundColor: MaterialStatePropertyAll(Colors.blue.shade700),
              ),
              onPressed: _isButtonDisabled ? null : () {
                if (camposValidos.every((campoValido) => campoValido)) {
                  llenarRegistro(rutEditingController.text, valueDropdown, nombreEditingController.text, apellidoPEditingController.text, apellidoMEditingController.text,
                      emailEditingController.text, telefonoEditingController.text);
                  llenarAuto(patenteEditingController.text);
                  print(getRegistro());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registrarse2()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Por favor, complete todos los campos antes de continuar.'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Text(
                '> Cree su contraseña',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
                              ),
                            ),
                          ],
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

  Container textFields(String entrada, String entradaField, TextEditingController controller, TextInputType tipoInput, RegExp regExp, String invalido, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entrada),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            keyboardType: tipoInput,
            validator: (value) {
              if (value == null || !regExp.hasMatch(value)) {
                camposValidos[index] = false; // Marcar el campo como inválido
                return invalido;
              }
              camposValidos[index] = true; // Marcar el campo como válido
              return null;
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: const OutlineInputBorder(),
              labelText: entradaField,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1.0),
              ),
            ),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}