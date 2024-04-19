import 'package:flutter/material.dart';
import 'package:zeromath/components/my_button.dart';
import 'package:zeromath/pages/equation.dart';
import '../constants/cores.constants.dart' as cores;

class MethodsPage extends StatefulWidget {
  const MethodsPage({super.key});

  @override
  State<MethodsPage> createState() => _MethodsPageState();
}

class _MethodsPageState extends State<MethodsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img/methods.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "Selecione qual método deseja aplicar à equação",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15.0),
                      topLeft: Radius.circular(15.0))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ButtonComponent(
                        style: TextButton.styleFrom(
                            elevation: 5,
                            foregroundColor: Colors.white,
                            backgroundColor: cores.redish,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        radius: 10,
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EquationPage(type: 1)));
                        },
                        label: "Método da Bisseção"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonComponent(
                        style: TextButton.styleFrom(
                            elevation: 5,
                            foregroundColor: Colors.white,
                            backgroundColor: cores.orangish,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        radius: 10,
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EquationPage(type: 2)));
                        },
                        label: "Método da Secante"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonComponent(
                        style: TextButton.styleFrom(
                            elevation: 5,
                            foregroundColor: Colors.white,
                            backgroundColor: cores.blueish,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        radius: 10,
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EquationPage(type: 3)));
                        },
                        label: "Método da Falsa Posição"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonComponent(
                        style: TextButton.styleFrom(
                            elevation: 5,
                            foregroundColor: Colors.white,
                            backgroundColor: cores.yellish,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        radius: 10,
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EquationPage(type: 4)));
                        },
                        label: "Método da Newton-Raphson"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonComponent(
                        style: TextButton.styleFrom(
                            elevation: 5,
                            foregroundColor: Colors.white,
                            backgroundColor: cores.greenish,
                            padding: const EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        radius: 10,
                        onClick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EquationPage(type: 5)));
                        },
                        label: "Método da Ponto Fixo"),
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
