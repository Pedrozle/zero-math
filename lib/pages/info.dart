import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Definição"),
      ),
      body: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Zero de Funções",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "v1.0.3",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const Text(
                  "Zero de uma função, também chamado de raiz, é todo valor da variável independente x que tem por  imagem o valor 0",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Como obter as raízes de uma equação?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Métodos numéricos iterativos são utilizados para aproximar a solução de x. Nesses métodos é dada uma solução inicial e a partir dela calculamos diversas vezes até que encontramos a solução correta. \nObter uma raiz pode ser dividido em dois passos:",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  "assets/img/zero_details/primeiro.png",
                  scale: 3,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  "assets/img/zero_details/analise.png",
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  "assets/img/zero_details/segundo.png",
                  scale: 3,
                  fit: BoxFit.fitWidth,
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  "assets/img/zero_details/refinamento.png",
                  fit: BoxFit.fitWidth,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
