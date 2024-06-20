// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/registrarse2.dart';
import 'package:flutter_application_1/newRegistro.dart';
import 'package:postgres/postgres.dart';

class Registrarse1 extends StatefulWidget {
  const Registrarse1({super.key});

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

  List<bool> camposValidos = [false, false, false, false, false, false, false];
  final bool _isButtonDisabled = false;

  RegExp get _emailRegex => RegExp(r'^\S+@\S+$');
  RegExp get _patenteRegex => RegExp(r'^[a-zA-Z]{4}\d{2}$');
  RegExp get _telefonoRegex => RegExp(r'^9[0-9]{8}$');
  RegExp get _nombreApellidoRegex => RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚüÜñÑ\s]+$');

  bool valido = true;

  late String valueDropdown;

  late Connection _db;

  @override
  void initState() {
    super.initState();
    valueDropdown = 'Estudiante';
  }

  Future<void> buscarCorreo(String correo) async {
    _db = DatabaseHelper().connection;
    final existe = await _db
        .execute("SELECT COUNT(*) FROM USUARIO WHERE usua_correo='$correo'");
    final existeCorreo = existe[0][0] == 1;
    setState(() {
      valido = !existeCorreo;
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<String> list = ['Estudiante', 'Profesor', 'Funcionario'];
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
                                      MaterialPageRoute(
                                          builder: (context) => const MyApp()),
                                    );
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
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    backgroundColor: MaterialStateProperty.all(
                                      Colors.blue.shade700,
                                    ),
                                  ),
                                  onPressed: () {
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
                            textFields(
                                'Nombres(s)',
                                'Ingrese su nombre',
                                nombreEditingController,
                                TextInputType.name,
                                _nombreApellidoRegex.hasMatch,
                                'Ingrese un nombre válido',
                                30,
                                0),
                            textFields(
                                'Apellido Paterno',
                                'Ingrese su apellido paterno',
                                apellidoPEditingController,
                                TextInputType.name,
                                _nombreApellidoRegex.hasMatch,
                                'Ingrese un apellido válido',
                                30,
                                1),
                            textFields(
                                'Apellido Materno',
                                'Ingrese su apellido materno',
                                apellidoMEditingController,
                                TextInputType.name,
                                _nombreApellidoRegex.hasMatch,
                                'Ingrese un apellido válido',
                                30,
                                2),
                            textFields(
                                'RUT',
                                'Ej: 20545267-1',
                                rutEditingController,
                                TextInputType.text,
                                validarRut,
                                'Ingrese un RUT válido',
                                10,
                                3),
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
                                    style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 16),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      border: OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.0),
                                      ),
                                    ),
                                    itemHeight: kMinInteractiveDimension + 14,
                                    isExpanded: true,
                                    items: list
                                        .map<DropdownMenuItem<String>>(
                                            (value) => DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                ))
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
                            textFields(
                                'Correo electrónico',
                                'Ej: correo@dominio.cl',
                                emailEditingController,
                                TextInputType.emailAddress,
                                _emailRegex.hasMatch,
                                valido
                                    ? 'Ingrese un email válido'
                                    : 'Este correo ya existe',
                                50,
                                4),
                            textFields(
                                'Teléfono',
                                'Ej: 958472045',
                                telefonoEditingController,
                                TextInputType.phone,
                                _telefonoRegex.hasMatch,
                                'Ingrese un teléfono válido',
                                9,
                                5),
                            const Text(
                              'DATOS VEHÍCULO',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            textFields(
                                'Patente',
                                'Ej: GGXX20',
                                patenteEditingController,
                                TextInputType.text,
                                _patenteRegex.hasMatch,
                                'Ingrese una patente válida',
                                6,
                                6),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.only(
                                  bottom: 15,
                                ),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blue.shade700),
                                  ),
                                  onPressed: _isButtonDisabled
                                      ? null
                                      : () {
                                          if (camposValidos.every(
                                              (campoValido) => campoValido)) {
                                            llenarRegistro(
                                                rutEditingController.text,
                                                valueDropdown,
                                                nombreEditingController.text,
                                                apellidoPEditingController.text,
                                                apellidoMEditingController.text,
                                                emailEditingController.text,
                                                telefonoEditingController.text);
                                            llenarAuto(
                                                patenteEditingController.text);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Registrarse2()),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Por favor, complete todos los campos antes de continuar.'),
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

  Container textFields(
      String entrada,
      String entradaField,
      TextEditingController controller,
      TextInputType tipoInput,
      bool Function(String) validatorFunction,
      String invalido,
      int maxLength,
      int index) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entrada),
          TextFormField(
            maxLength: maxLength,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            keyboardType: tipoInput,
            validator: (value) {
              if (value == null || !validatorFunction(value)) {
                camposValidos[index] = false;
                return invalido;
              }
              camposValidos[index] = true;
              return null;
            },
            onChanged: (value) {
              if (entrada == 'Correo electrónico') {
                if (value.isEmpty) {
                  setState(() {
                    valido = true;
                  });
                } else {
                  buscarCorreo(value);
                }
              }
            },
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: const OutlineInputBorder(),
              labelText: entradaField,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 1.0),
              ),
              counterText: '',
              errorText: entrada == 'Correo electrónico' && !valido
                  ? 'Este correo ya existe.'
                  : null,
            ),
            textInputAction: TextInputAction.done,
          ),
        ],
      ),
    );
  }
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
