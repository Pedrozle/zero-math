import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zeromath/apps/methods.dart';
import 'package:zeromath/models/equacao_data.dart';
import 'package:zeromath/services/metodos.dart';
import 'package:zeromath/models/request.dart';

import '../constants/cores.constants.dart' as cores;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class Graphic extends StatefulWidget {
  const Graphic({super.key, required this.title});

  final String title;

  @override
  State<Graphic> createState() => _GraphicState();
}

class _GraphicState extends State<Graphic> {
  final equacaoController = TextEditingController();

  Metodos metodosService = Metodos();
  bool vazio = true;
  bool buscando = false;

  List<EquacaoData> dataGraph = [];

  geraGraph(obj) async {
    var result = metodosService.geraGrafico(obj);
    setState(() {
      vazio = false;
      buscando = false;
      dataGraph = result;
    });
  }

  void _showModal(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    equacaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Zero de Funções",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'Palanquin'),
                  )),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))),
                child: Column(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if (equacaoController.text.isEmpty)
                                ElevatedButton(
                                  style: TextButton.styleFrom(
                                      elevation: 5,
                                      foregroundColor: Colors.white,
                                      backgroundColor: cores.primaryColor,
                                      padding: const EdgeInsets.all(5),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                                  onPressed: () async {
                                    var equacoes = [
                                      'x^2-10',
                                      '3*x^3 -2',
                                      'x^3 + x^2 -5',
                                      '-2*x^2 + 3*x +2',
                                      'sin(x)',
                                      'cos(x)',
                                      'x^2 + x-6'
                                    ];

                                    var equacaoCtrl = equacoes[Random().nextInt(equacoes.length)];
                                    equacaoController.text = equacaoCtrl;
                                    var obj = MyRequest(1, equacaoCtrl, "", -5, 5, 0, 0);

                                    geraGraph(obj);
                                  },
                                  child: const Text('Inserir modelo',
                                      style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                                ),
                              TextFormField(
                                onChanged: (value) => {
                                  if (value.isEmpty)
                                    {
                                      setState(() {
                                        vazio = true;
                                      })
                                    }
                                  else
                                    {
                                      setState(() {
                                        vazio = false;
                                      })
                                    }
                                },
                                controller: equacaoController,
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                                  fillColor: Theme.of(context).colorScheme.tertiary,
                                  filled: true,
                                  labelText: 'Equação',
                                  hintText: "x^2 + x-6",
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15.0))),
                          child: !vazio
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: SfTheme(
                                        data: SfThemeData(
                                            chartThemeData: SfChartThemeData(plotAreaBackgroundColor: Colors.white)),
                                        child: SfCartesianChart(
                                            primaryXAxis: NumericAxis(crossesAt: 0),
                                            primaryYAxis: NumericAxis(crossesAt: 0),
                                            title: ChartTitle(text: "Gráfico da Equação"),
                                            // crosshairBehavior: _crooshairBehavior,
                                            series: <ChartSeries>[
                                              LineSeries<EquacaoData, double>(
                                                  dataSource: dataGraph,
                                                  xValueMapper: (EquacaoData data, _) => data.x,
                                                  yValueMapper: (EquacaoData data, _) => data.y,
                                                  animationDuration: 5000,
                                                  // Enable data label
                                                  dataLabelSettings: const DataLabelSettings(isVisible: true)),
                                            ]),
                                      ),
                                    )
                                  ],
                                )
                              : const Text("Insira os dados acima para visualizar o gráfico"),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Expanded(
                                child: ElevatedButton(
                              style: TextButton.styleFrom(
                                  elevation: 5,
                                  foregroundColor: Colors.white,
                                  backgroundColor: cores.primaryColor,
                                  padding: const EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                              onPressed: () async {
                                var equacaoCtrl = "";
                                if (equacaoController.text.isEmpty) {
                                  _showModal(context, "Faltando informações", "Não é possível calcular sem a equação.");
                                  return;
                                }
                                equacaoCtrl = equacaoController.text;
                                var obj = MyRequest(1, equacaoCtrl, "", -5, 5, 0, 0);

                                geraGraph(obj);
                              },
                              child: const Text('Exibir o gráfico da função',
                                  style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                            )),
                            const SizedBox(
                              width: 8,
                            ),
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
                                      builder: (context) => const Methods(
                                            title: "Métodos",
                                          )),
                                );
                              },
                              child: const Text('Aplicar os métodos',
                                  style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
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
