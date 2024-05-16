// ignore_for_file: avoid_print, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/registrarse2.dart';
import 'package:flutter_application_1/newRegistro.dart';

class Registrarse1 extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreEditingController = TextEditingController();
  TextEditingController apellidoPEditingController = TextEditingController();
  TextEditingController apellidoMEditingController = TextEditingController();
  TextEditingController rutEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController telefonoEditingController = TextEditingController();
  TextEditingController patenteEditingController = TextEditingController();
  TextEditingController marcaEditingController = TextEditingController();
  TextEditingController modeloEditingController = TextEditingController();
  TextEditingController aEditingController = TextEditingController();

  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  RegExp get _numerosRegex => RegExp(r'^[^\d]*$');
  RegExp get _todo => RegExp(r'^.*$');
  @override
  Widget build(BuildContext context) {
    const List<String> list = ['Estudiante', 'Invitado'];
    late String valueDropdown = list[0];
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
                                      MaterialPageRoute(builder: (context) => MyApp()),
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
                                color: Colors.white,
                                fontSize: 20,
                              ),
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
                            textFields('Nombres(s)', 'Ingrese su nombre', nombreEditingController, TextInputType.name, _numerosRegex, 'Ingrese un nombre valido'),
                            textFields('Apellido Paterno', 'Ingrese su apellido paterno', apellidoPEditingController, TextInputType.name, _numerosRegex, 'Ingrese un apellido valido'),
                            textFields('Apellido Materno', 'Ingrese su apellido materno', apellidoMEditingController, TextInputType.name, _numerosRegex, 'Ingrese un apellido valido'),
                            textFields('RUT', 'Ej: 20545267-1', rutEditingController, TextInputType.text, _todo, 'Ingrese un RUT valido'),
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
                                    decoration: const InputDecoration(border: OutlineInputBorder()),
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
                                      valueDropdown = value!;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            textFields('Correo electrónico', 'Ej: correo@dominio.cl', emailEditingController, TextInputType.emailAddress, _emailRegex, 'Ingrese un email valido'),
                            textFields('Teléfono', 'Ej: 958472045', telefonoEditingController, TextInputType.phone, _todo, 'Ingrese un telefono valido'),
                            const Text(
                              'DATOS VEHÍCULO',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textFields('Patente', 'Ej: GGXX20', patenteEditingController, TextInputType.text, _todo, 'Ingrese una patente valido'),
                            textFields('Marca', 'Ej: Chevrolet', marcaEditingController, TextInputType.text, _todo, 'Ingrese una marca valido'),
                            textFields('Modelo', 'Ej: Sali', modeloEditingController, TextInputType.text, _todo, 'Ingrese un modelo valido'),
                            textFields('Año', 'Ej: 2014', aEditingController, TextInputType.datetime, _todo, 'Ingrese un año valido'),
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
                                  onPressed: () {
                                    llenarRegistro(nombreEditingController.text, apellidoPEditingController.text, apellidoMEditingController.text, rutEditingController.text, valueDropdown,
                                        emailEditingController.text, patenteEditingController.text, marcaEditingController.text, modeloEditingController.text, aEditingController.text);

                                    print(getRegistro());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Registrarse2()),
                                    );
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

  Container textFields(String entrada, String entradaField, TextEditingController controller, TextInputType tipoInput, RegExp regExp, String invalido) {
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
                return invalido;
              }
              return null;
            },
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: const OutlineInputBorder(),
              labelText: entradaField,
            ),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
}
