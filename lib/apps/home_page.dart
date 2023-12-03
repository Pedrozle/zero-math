import 'package:flutter/material.dart';
import 'package:zeromath/apps/graphic.dart';
import 'package:zeromath/apps/zero_definition.dart';
import '../constants/cores.constants.dart' as cores;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/img/homepage.png'),
            fit: BoxFit.cover,
          )),
          child: Column(
            children: [
              const Spacer(),
              Container(
                  decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))),
                  padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Zero de Funções",
                        style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Palanquin'),
                      ),
                      ElevatedButton(
                        style: TextButton.styleFrom(
                            elevation: 1,
                            foregroundColor: Colors.black,
                            backgroundColor: cores.background,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ZeroDetails()),
                          );
                        },
                        child: const Text('O que é?', style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                      )
                    ],
                  )),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: Theme.of(context).colorScheme.secondary,
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                              style: TextButton.styleFrom(
                                  elevation: 5,
                                  foregroundColor: Colors.white,
                                  backgroundColor: cores.primaryColor,
                                  padding: const EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Graphic(title: "Gráfico da equação")),
                                );
                              },
                              child: const Text('Exibir gráfico da equação',
                                  style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    )
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
