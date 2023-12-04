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
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                          elevation: 5,
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
                      child: const Text('Método da Bisseção',
                          style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                          elevation: 5,
                          foregroundColor: Colors.white,
                          backgroundColor: cores.blueish,
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
                      child: const Text('Método da Secante',
                          style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                          elevation: 5,
                          foregroundColor: Colors.white,
                          backgroundColor: cores.yellish,
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
                      child: const Text('Método da Falsa Posição',
                          style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 70,
                    width: double.infinity,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                          elevation: 5,
                          foregroundColor: Colors.white,
                          backgroundColor: cores.greenish,
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
                      child: const Text('Método de Newton-Raphson',
                          style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 70,
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
                      child: const Text('Método do Ponto Fixo',
                          style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
