import 'package:flutter/material.dart';
import 'package:zeromath/apps/graphic.dart';
import 'package:zeromath/apps/zero_definition.dart';
import '../constants/cores.constants.dart' as cores;

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Zero de Funções",
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Palanquin'),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ZeroDetails()),
                          );
                        },
                        icon: const Icon(Icons.info_outline)),
                  ],
                )),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 15),
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                  color: cores.babyBlue,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))),
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
                                MaterialPageRoute(
                                    builder: (context) => Graphic(
                                          title: "Gráfico da equação"
                                        )),
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
                      const Text(
                        "Desenvolvido por:\nJoão Pedro & Gianluca",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
