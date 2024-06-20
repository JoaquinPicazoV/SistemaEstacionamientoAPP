// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_application_1/recuperarClave3.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_application_1/utils.dart';
import 'dart:async';

class RecuperarClave2 extends StatefulWidget {
  String codigo;
  final String email;
  RecuperarClave2({required this.codigo, required this.email, super.key});

  @override
  _RecuperarClave2State createState() => _RecuperarClave2State();
}

class _RecuperarClave2State extends State<RecuperarClave2> {
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
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
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
            widthFactor: 0.95,
            child: Container(
              padding: const EdgeInsets.only(top: 40, bottom: 40),
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
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          '¡ENVIAMOS UN MAIL DE CONFIRMACIÓN A SU CORREO ELECTRÓNICO!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
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
                        const Text(
                          'Tiempo restante',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Center(
                          child: Text(
                            '$minutesStr:$secondsStr',
                            style: const TextStyle(fontSize: 24, color: Colors.black),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          RecuperarClave3(email: widget.email),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'El código ingresado no es correcto.'),
                                    ),
                                  );
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
                                    const SnackBar(
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
