// ignore_for_file: avoid_print, use_build_context_synchronously, non_constant_identifier_names, use_super_parameters, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:flutter_application_1/menuGuardia.dart';
import 'package:flutter_application_1/recuperarClave.dart';
import 'package:flutter_application_1/registrarse1.dart';
import 'package:flutter_application_1/testSeesion.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_application_1/newRegistro.dart';
import 'package:flutter_application_1/database.dart';

const List<String> list = <String>['Estudiante', 'Invitado'];

late Connection db;
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Asegura la inicialización
  await DatabaseHelper().initialize();
  runApp(const MyApp());
}

Future<void> funcionSession(context) async {
  Connection _db = DatabaseHelper().connection;
  String? correo = await getSessionCorreo();
  if (await getExistSession() && RegExp(r'@ulagos.cl').hasMatch(correo.toString())) {
    final testRut = await _db.execute("SELECT guar_rut FROM guardia WHERE guar_correo='${correo.toString()}'");
    String stringRut = testRut[0][0].toString();
    print(stringRut);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => menuGuardia(RUT: stringRut),
      ),
    );
  } else if (await getExistSession() && RegExp(r'@alumnos.ulagos.cl').hasMatch(correo.toString())) {
    final testRut = await _db.execute("SELECT usua_rut FROM usuario WHERE usua_correo='${correo.toString()}'");
    String stringRut = testRut[0][0].toString();
    String? authNombreFuture = await getSessionNombre();
    String authNombre = authNombreFuture.toString();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => menuUsuario(
          RUT: stringRut,
          nombreUsuario: authNombre,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = list.first;
  TextEditingController controladorCorreo = TextEditingController();
  TextEditingController controladorContrasena = TextEditingController();
  bool obscurePassword = true;
  int coincidencias = 0;
  String RUT = '';
  late String authNombre;
  late Connection _db;

  Future<void> buscarRut(correo, pswrd, bool alumno) async {
    _db = DatabaseHelper().connection;

    if (alumno) {
      final results = await _db.execute("SELECT usua_rut, usua_nombre, usua_apellido_paterno FROM USUARIO WHERE usua_correo='$correo'");
      RUT = results[0][0].toString();
      authNombre = '${results[0][1].toString()} ${results[0][2].toString()}';
      saveSession(correo, authNombre);
      while (RUT == '') {}
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => menuUsuario(RUT: RUT, nombreUsuario: authNombre)),
      );
    } else {
      final results = await _db.execute("SELECT guar_rut, guar_nombre, guar_apellido_paterno, guar_apellido_materno FROM guardia WHERE guar_correo='$correo'");
      RUT = results[0][0].toString();
      authNombre = '${results[0][1].toString()} ${results[0][2].toString()} ${results[0][3].toString()}';
      while (RUT == '') {}
      saveSession(correo, authNombre);
      Navigator.of(context, rootNavigator: true).pop('dialog');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => menuGuardia(RUT: RUT)),
      );
    }
  }

  Future<void> AnalizarCredenciales(correo, pswrd) async {
    print('inicio funcion');
    _db = DatabaseHelper().connection;

    final results = await _db.execute(
        "SELECT COUNT(*) FROM (SELECT usua_correo FROM usuario WHERE usua_correo = '$correo' AND usua_clave = '$pswrd' UNION SELECT guar_correo FROM guardia WHERE guar_correo = '$correo'AND guar_clave = '$pswrd') AS combined_emails");
    print(results[0][0]);
    coincidencias = int.parse(results[0][0].toString());
    if (coincidencias == 1 && RegExp(r'@alumnos.ulagos.cl').hasMatch(correo)) {
      print("CONTRASEÑA CORRECTA alumno");
      buscarRut(controladorCorreo.text.trim(), controladorContrasena.text.trim(), true);
    } else if (coincidencias == 1 && RegExp(r'@ulagos.cl').hasMatch(correo)) {
      print("CONTRASEÑA CORRECTA guardia");
      buscarRut(controladorCorreo.text.trim(), controladorContrasena.text.trim(), false);
    } else {
      print("CONTRASEÑA INCORRECTA");
      Navigator.of(context, rootNavigator: true).pop('dialog');
    }
  }

  @override
  Widget build(BuildContext context) {
    funcionSession(context);
    vaciarRegistro();
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.blue.shade900,
        body: Center(
          child: SafeArea(
            child: FractionallySizedBox(
              widthFactor: 0.81,
              heightFactor: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        FractionallySizedBox(
                          widthFactor: 0.6,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: Image.asset(
                              "assets/img/ULAGOS.png",
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                        const Text(
                          "ESTACIONAMIENTOS ULAGOS",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        FractionallySizedBox(
                          widthFactor: 0.85,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Center(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                        ),
                                        backgroundColor: MaterialStateProperty.all(Colors.blue.shade700),
                                        alignment: Alignment.center,
                                      ),
                                      onPressed: () {},
                                      child: const Text(
                                        'Iniciar sesión',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Registrarse1()),
                                        );
                                      },
                                      child: const Text(
                                        "Registrarse",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 40,
                                  child: TextFormField(
                                    style: const TextStyle(fontSize: 12),
                                    controller: controladorCorreo,
                                    decoration: InputDecoration(
                                      labelText: 'Correo electrónico',
                                      suffixIcon: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          border: Border.all(
                                            color: Colors.blue,
                                          ),
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.email, color: Colors.black),
                                          onPressed: () {},
                                        ),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  height: 40,
                                  child: Stack(
                                    children: [
                                      TextFormField(
                                        obscureText: obscurePassword,
                                        controller: controladorContrasena,
                                        decoration: const InputDecoration(
                                          labelText: 'Contraseña',
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 50,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: IconButton(
                                            icon: Icon(
                                              obscurePassword ? Icons.visibility_off : Icons.visibility,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                obscurePassword = !obscurePassword;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade200,
                                            borderRadius: BorderRadius.circular(4),
                                            border: Border.all(
                                              color: Colors.blue,
                                            ),
                                          ),
                                          child: IconButton(
                                            icon: const Icon(Icons.lock, color: Colors.black),
                                            onPressed: () {},
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Form(
                                  child: Column(
                                    children: [
                                      FractionallySizedBox(
                                        widthFactor: 0.85,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            String email = controladorCorreo.text.trim();
                                            String clave = controladorContrasena.text.trim();
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
                                            AnalizarCredenciales(email, clave);
                                          },
                                          icon: const Icon(Icons.login, color: Colors.white),
                                          label: const Text(
                                            'INGRESAR',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue.shade700,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                        height: 10,
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => RecuperarClave(),
                                              ));
                                        },
                                        child: const Text(
                                          "¿Olvidaste tu contraseña?",
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
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
        ),
      ),
    );
  }
}
