import 'package:flutter/material.dart';

import 'package:zeromath/apps/equacao.dart';

import '../constants/cores.constants.dart' as cores;

class Methods extends StatefulWidget {
  const Methods({super.key, required this.title});

  final String title;

  @override
  State<Methods> createState() => _MethodsState();
}

class _MethodsState extends State<Methods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/img/methods.png'),
            fit: BoxFit.fitWidth,
            opacity: 0.2,
          )),
          child: Column(
            children: [
              const Spacer(),
              Container(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: const Text(
                  "Selecione qual método deseja aplicar à equação",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, fontFamily: 'Palanquin'),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: cores.babyBlue,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                                height: 100,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      maximumSize: const Size(170, 150),
                                      foregroundColor: Colors.white,
                                      backgroundColor: cores.orangish,
                                      padding: const EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Equacao(
                                                typeScreen: 1,
                                              )),
                                    );
                                  },
                                  child: const Expanded(
                                    child: Text('Método da bisseção',
                                        style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 150,
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                    elevation: 5,
                                    maximumSize: const Size(170, 100),
                                    foregroundColor: Colors.white,
                                    backgroundColor: cores.blueish,
                                    padding: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Equacao(
                                              typeScreen: 3,
                                            )),
                                  );
                                },
                                child: const Text('Método da secante',
                                    style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                              ),
                            )
                          ],
                        ),
                        const Spacer(),
                        Column(
                          children: [
                            SizedBox(
                                height: 150,
                                child: ElevatedButton(
                                  style: TextButton.styleFrom(
                                      elevation: 5,
                                      maximumSize: const Size(170, 100),
                                      foregroundColor: Colors.white,
                                      backgroundColor: cores.greenish,
                                      padding: const EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const Equacao(
                                                typeScreen: 2,
                                              )),
                                    );
                                  },
                                  child: const Text('Método de Newton-Raphson',
                                      style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 100,
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                    elevation: 5,
                                    maximumSize: const Size(170, 150),
                                    foregroundColor: Colors.white,
                                    backgroundColor: cores.yellish,
                                    padding: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Equacao(
                                              typeScreen: 4,
                                            )),
                                  );
                                },
                                child: const Text('Método da falsa posição',
                                    style: TextStyle(
                                      fontSize: 24,
                                    ),
                                    textAlign: TextAlign.center),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: TextButton.styleFrom(
                            elevation: 5,
                            foregroundColor: Colors.white,
                            backgroundColor: cores.redish,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Equacao(
                                      typeScreen: 5,
                                    )),
                          );
                        },
                        child: const Text('Método do ponto fixo',
                            style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
