import 'package:flutter/material.dart';
import 'package:zeromath/apps/methods.dart';
import 'package:zeromath/models/equacao_data.dart';
import 'package:zeromath/services/requests.dart';
import 'package:zeromath/services/metodos.dart';
import 'package:zeromath/models/request.dart';

import '../constants/cores.constants.dart' as cores;
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class Graphic extends StatefulWidget {
  const Graphic({super.key, required this.title});

  final String title;

  @override
  State<Graphic> createState() => _GraphicState();
}

class _GraphicState extends State<Graphic> {
  final equacaoController = TextEditingController();

  Requests requestsService = Requests();
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
                decoration: const BoxDecoration(
                    color: cores.babyBlue,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0))),
                child: Column(
                  children: [
                    Column(
                      children: [
                        TextFormField(
                          controller: equacaoController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: 'Equação',
                              hintText: "x^3 + 3*x",
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                              color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15.0))),
                          child: buscando
                              ? Center(
                                  child: LoadingAnimationWidget.prograssiveDots(color: cores.primaryColor, size: 100),
                                )
                              : !vazio
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
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
                                var obj = MyRequest(1, equacaoCtrl, "", 0, 0, 0, 0);

                                await geraGraph(obj);
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
      ),
    );
  }
}
