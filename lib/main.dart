// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, use_build_context_synchronously, non_constant_identifier_names, use_super_parameters

import 'package:flutter/material.dart';
import 'package:flutter_application_1/menuGuardia.dart';
import 'package:flutter_application_1/menuUsuario.dart';
import 'package:flutter_application_1/registrarse1.dart';
import 'package:postgres/postgres.dart';
import 'package:flutter_application_1/newRegistro.dart';

const List<String> list = <String>['Estudiante', 'Invitado'];

late Connection db;
void main() async {
  runApp(const MyApp());

  db = await Connection.open(
    Endpoint(
      host: 'ep-sparkling-dream-a5pwwhsb.us-east-2.aws.neon.tech',
      database: 'estacionamientosUlagos',
      username: 'estacionamientosUlagos_owner',
      password: 'D7HQdX0nweTx',
    ),
    settings: const ConnectionSettings(sslMode: SslMode.require),
  );
  print('has connection!');
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
  late Connection _db;
  int coincidencias = 0;
  String RUT = '';
  Future<void> buscarRut(correo, pswrd) async {
    

    final results = await _db.execute(
        "SELECT usua_rut FROM USUARIO WHERE usua_correo='" +
            correo +
            "' AND usua_clave='" +
            pswrd +
            "'");
    RUT = results[0][0].toString();
    while (RUT == '') {}
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => menuUsuario(RUT:RUT)),
    );
  }

  Future<void> AnalizarCredenciales(correo, pswrd) async {
    print('inicio funcion');
    _db = await Connection.open(
      Endpoint(
        host: 'ep-sparkling-dream-a5pwwhsb.us-east-2.aws.neon.tech',
        database: 'estacionamientosUlagos',
        username: 'estacionamientosUlagos_owner',
        password: 'D7HQdX0nweTx',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.require),
    );

    final results = await _db.execute(
        "SELECT COUNT(*) FROM usuario WHERE usua_correo='" +
            correo +
            "' AND usua_clave='" +
            pswrd +
            "'");
    print(results[0][0]);
    coincidencias = int.parse(results[0][0].toString());
    if (coincidencias == 1) {
      print("CONTRASEÑA CORRECTA");
      buscarRut(controladorCorreo.text.trim(), controladorContrasena.text.trim());
      /* FALTA REDIRECCIONAR A INTERFACES SEGUN EL  DOMINIO
                                            @ULAGOS.CL O @ALUMNOS.ULAGOS.CL PERO ES SENCILLO */

      /* TAMBIEN FALTA CREAR SESIONES Y ASI TRABAJAR MAS FACIL CON 
                                            LAS INTERFACES SIGUIENTES PARA NO INICIAR SESION MUCHAS VECES*/
    } else {
      print("CONTRASEÑA INCORRECTA");
    }
  }

  @override
  Widget build(BuildContext context) {
    vaciarRegistro();
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Align(
        alignment: Alignment.center,
        child: SafeArea(
          child: FractionallySizedBox(
            widthFactor: 0.81,
            heightFactor: 0.7,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.blue.shade700),
                                    alignment: Alignment.center,
                                  ),
                                  onPressed: () {},
                                  child: const Text(
                                    'Iniciar sesión',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
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
                                      MaterialPageRoute(
                                          builder: (context) => Registrarse1()),
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
                                      icon: const Icon(Icons.email,
                                          color: Colors.black),
                                      onPressed: () {},
                                    ),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1.0),
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
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.0),
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
                                          obscurePassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
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
                                        icon: const Icon(Icons.lock,
                                            color: Colors.black),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Form(
                                child: Column(
                                  children: [
                                    FractionallySizedBox(
                                      widthFactor: 0.85,
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          String email =
                                              controladorCorreo.text.trim();
                                          String clave =
                                              controladorContrasena.text.trim();
                                          AnalizarCredenciales(email, clave);
                                        },
                                        icon: const Icon(Icons.login,
                                            color: Colors.white),
                                        label: const Text(
                                          'INGRESAR',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue.shade700,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        print('¿Olvidaste tu contraseña?');
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
}
