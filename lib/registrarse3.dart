// ignore_for_file: avoid_print, must_be_immutable, use_build_context_synchronously, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/newRegistro.dart';
import 'package:flutter_application_1/registrarse4.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'dart:async';

class Registrarse3 extends StatefulWidget {
  String codigo;
  final String email;
  Registrarse3({required this.codigo, required this.email, Key? key})
      : super(key: key);

  @override
  _Registrarse3State createState() => _Registrarse3State();
}

class _Registrarse3State extends State<Registrarse3> {
  TextEditingController pinTextEditingController = TextEditingController();
  bool mostrarBotonConfirmar = true;
  int secondsLeft = 300; // 5 minutos en segundos
  late StreamSubscription<int> timerSubscription;

  @override
  void initState() {
    super.initState();
    timerSubscription = startTimer();
  }

  StreamSubscription<int> startTimer() {
    final StreamController<int> controller = StreamController<int>();
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      controller.add(--secondsLeft);
      if (secondsLeft == 0) {
        timer.cancel();
        setState(() {
          mostrarBotonConfirmar = false;
        });
      }
    });
    return controller.stream.listen((int newSeconds) {
      setState(() {
        secondsLeft = newSeconds;
      });
    });
  }

  @override
  void dispose() {
    timerSubscription
        .cancel(); // Cancelar la suscripción al stream cuando se destruye el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = secondsLeft ~/ 60;
    int seconds = secondsLeft % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
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
                    Column(
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
                                              builder: (context) =>
                                                  const MyApp()),
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
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
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
                        FractionallySizedBox(
                          widthFactor: 0.85,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration:
                                BoxDecoration(color: Colors.blue.shade700),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade500,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Text(
                                    "3",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const Text(
                                  "Confirmar cuenta",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          '¡ENVIAMOS UN MAIL DE CONFIRMACIÓN A SU CORREO ELECTRÓNICO!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.85,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 50),
                            height: 40,
                            child: Pinput(
                              controller: pinTextEditingController,
                              length: 6,
                              defaultPinTheme: PinTheme(
                                textStyle: const TextStyle(fontSize: 20),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        const Color.fromRGBO(234, 239, 243, 1),
                                  ),
                                ),
                              ),
                              onCompleted: (pin) {
                                print(pin);
                              },
                            ),
                          ),
                        ),
                        Text(
                          'Tiempo restante',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Center(
                          child: Text(
                            '$minutesStr:$secondsStr',
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                        ),
                        const Icon(
                          Icons.mail_outline_rounded,
                          size: 36,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: mostrarBotonConfirmar
                          ? ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.shade700),
                              ),
                              onPressed: () async {
                                if (pinTextEditingController.text ==
                                    widget.codigo) {
                                  await db.execute(
                                    r'INSERT INTO usuario VALUES ($1,$2,$3,$4,$5,$6,$7,$8)',
                                    parameters: getRegistro(),
                                  );
                                  await db.execute(
                                    r'INSERT INTO vehiculo VALUES($1)',
                                    parameters: getAuto(),
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const registrarse4(),
                                    ),
                                  );
                                } else {
                                  print('Código incorrecto');
                                }
                              },
                              child: const Text(
                                'Confirmar',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(
                                    horizontal: 30,
                                    vertical: 10,
                                  ),
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                    Colors.blue.shade700),
                              ),
                              onPressed: () async {
                                setState(() {
                                  widget.codigo = generarCodigo();
                                });
                                bool enviado = await sendEmail(
                                    widget.email, widget.codigo);
                                if (enviado) {
                                  setState(() {
                                    mostrarBotonConfirmar = true;
                                    secondsLeft = 300;
                                  });
                                  timerSubscription
                                      .cancel(); // Cancela el temporizador actual
                                  timerSubscription = startTimer();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Error al enviar el correo electrónico.'),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                }
                              },
                              child: const Text(
                                'Reenviar código',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
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
