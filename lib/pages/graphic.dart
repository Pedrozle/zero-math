import 'dart:math';

import 'package:flutter/material.dart';
import 'package:zeromath/components/my_button.dart';
import 'package:zeromath/components/my_text_input.dart';
import 'package:zeromath/models/equacao.dart';
import 'package:zeromath/pages/methods.dart';
import 'package:zeromath/services/equacao_data.dart';
import 'package:zeromath/services/metodos.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class GraphicPage extends StatefulWidget {
  const GraphicPage({super.key});

  @override
  State<GraphicPage> createState() => _GraphicPageState();
}

class _GraphicPageState extends State<GraphicPage> {
  final equacaoController = TextEditingController();

  bool vazio = true;

  Metodos metodosService = Metodos();
  List<EquacaoData> dataGraph = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    equacaoController.dispose();
    super.dispose();
  }

  Widget returnGrafico() {
    return vazio == true
        ? const SizedBox(
            height: 10,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                child: SfTheme(
                  data: SfThemeData(
                      chartThemeData: SfChartThemeData(
                          plotAreaBackgroundColor:
                              Theme.of(context).colorScheme.surface)),
                  child: SfCartesianChart(
                      primaryXAxis: const NumericAxis(crossesAt: 0),
                      primaryYAxis: const NumericAxis(crossesAt: 0),
                      title: const ChartTitle(text: "Gráfico da Equação"),
                      series: <CartesianSeries>[
                        LineSeries<EquacaoData, double>(
                            dataSource: dataGraph,
                            xValueMapper: (EquacaoData data, _) => data.x,
                            yValueMapper: (EquacaoData data, _) => data.y,
                            animationDuration: 5000,
                            // Enable data label
                            dataLabelSettings:
                                const DataLabelSettings(isVisible: true)),
                      ]),
                ),
              )
            ],
          );
  }

  geraGraph(Equacao equacao) async {
    var result = metodosService.geraGrafico(equacao);
    setState(() {
      vazio = false;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Zero de Funções",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ButtonComponent(
                    radius: 30,
                    onClick: () {
                      var equacoes = [
                        'x^2-10',
                        '3*x^3 -2',
                        'x^3 + x^2 -5',
                        '-2*x^2 + 3*x +2',
                        'sin(x)',
                        'cos(x)',
                        'x^2 + x-6'
                      ];
                      var equacaoCtrl =
                          equacoes[Random().nextInt(equacoes.length)];
                      equacaoController.text = equacaoCtrl;
                      var obj = Equacao(1, equacaoCtrl, "", -5, 5, 0, 0);
                      geraGraph(obj);
                    },
                    label: "Inserir Modelo")
              ],
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15.0),
                    topLeft: Radius.circular(15.0))),
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextInputComponent(
                    onChange: (value) => {
                          setState(() {
                            vazio = true;
                          })
                        },
                    controller: equacaoController,
                    hint: "Insira uma equação"),
                returnGrafico(),
                Row(
                  children: [
                    Expanded(
                      child: ButtonComponent(
                          radius: 10,
                          onClick: () {
                            var equacaoCtrl = "";
                            if (equacaoController.text.isEmpty) {
                              _showModal(context, "Faltando informações",
                                  "Não é possível calcular sem a equação.");
                              return;
                            }
                            equacaoCtrl = equacaoController.text;
                            var obj = Equacao(1, equacaoCtrl, "", -5, 5, 0, 0);

                            geraGraph(obj);
                          },
                          label: "Exibir o gráfico"),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: ButtonComponent(
                          radius: 10,
                          onClick: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MethodsPage()),
                                )
                              },
                          label: "Aplicar os métodos"),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
