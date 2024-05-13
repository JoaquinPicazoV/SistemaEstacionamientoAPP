// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/registrarse1.dart';

const List<String> list = <String>['Estudiante', 'Invitado'];
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String dropdownValue = list.first;
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController contraEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Align(
        alignment: Alignment.center,
        // Tamaño Caja blanca
        child: SafeArea(
          child: FractionallySizedBox(
            widthFactor: 0.81,
            heightFactor: 0.7,
            //Caja Blanca
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
                    SizedBox(height: 30),
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
                                  onPressed: () {
                                    print('Iniciar sesión');
                                  },
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
                                    print('Registrarse');
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
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                style: TextStyle(fontSize: 12),
                                controller: emailEditingController,
                                decoration: InputDecoration(
                                  labelText: 'Correo electrónico',
                                  suffixIcon: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200, 
                                      border: Border.all(
                                          color: Colors
                                              .blue), 
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.email,
                                          color: Colors.black),
                                      onPressed: () {},
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: contraEditingController,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  suffixIcon: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                      border: Border.all(
                                          color: Colors
                                              .blue), 
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.lock,
                                          color: Colors.black), 
                                      onPressed: () {},
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 1.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),

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
                                          print('Ingresar');
                                        },
                                        icon: Icon(Icons.login,
                                            color:
                                                Colors.white), 
                                        label: Text(
                                          'INGRESAR',
                                          style: TextStyle(
                                              color:
                                                  Colors.white), 
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue.shade700,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10),
                                          ),
                                        ),
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    TextButton(
                                      onPressed: () {
                                        print('¿Olvidaste tu contraseña?');
                                      },
                                      child: Text(
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
