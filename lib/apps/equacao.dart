import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zeromath/apps/equacao_details.dart';
import 'package:zeromath/models/details_data.dart';
import 'package:zeromath/models/equacao_data.dart';
import 'package:zeromath/models/request.dart';
import 'package:zeromath/services/metodos.dart';

import '../constants/cores.constants.dart' as cores;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Equacao extends StatefulWidget {
  const Equacao({super.key, required this.typeScreen});
  final int typeScreen;

  @override
  State<Equacao> createState() => _EquacaoState();
}

class _EquacaoState extends State<Equacao> {
  String title = "";
  String definicao = "";

  final equacaoController = TextEditingController();
  final aController = TextEditingController();
  final bController = TextEditingController();
  final maxRepsController = TextEditingController();
  final precisaoController = TextEditingController();

  bool vazio = true;
  bool buscando = false;

  List<EquacaoData> dataGraph = [];
  List<EquacaoData> dataRaizes = [];
  List<double> raizes = [];
  List<List<double>> tabela = [];

  Metodos metodosService = Metodos();

  TooltipBehavior _tooltipBehavior = TooltipBehavior();
  ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior();
  CrosshairBehavior _crooshairBehavior = CrosshairBehavior();

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(enablePinching: true, enableSelectionZooming: true, enablePanning: true);
    _crooshairBehavior = CrosshairBehavior(enable: true);
    switch (widget.typeScreen) {
      case 1:
        title = "Método da bisseção";
        definicao =
            "O método da bisseção ou método da bissecção é um método de busca de raízes que bissecta repetidamente um intervalo e então seleciona um subintervalo contendo a raiz para processamento adicional.";
        break;
      case 2:
        title = "Método de Newton-Raphson";
        definicao =
            "O método de Newton, desenvolvido por Isaac Newton e Joseph Raphson, tem o objetivo de estimar as raízes de uma função. Para isso, escolhe-se uma aproximação inicial para esta equação e informa sua equação derivada.";
        break;
      case 3:
        title = "Método da secante";
        definicao =
            "O método das secantes é um algoritmo de busca de raízes que usa uma sequência de raízes de linhas secantes para aproximar cada vez melhor a raiz de uma função f";
        break;
      case 4:
        title = "Método da falsa posição";
        definicao =
            "O método da posição falsa ou regula falsi é um método numérico usado para resolver equações lineares definidas em um intervalo [a, b], partindo do pressuposto de que haja uma solução em um subintervalo contido em [a, b";
        break;
      case 5:
        title = "Método do ponto fixo";
        definicao = "O método do ponto fixo é um método de se calcular pontos fixos de funções.";
        break;
    }
  }

  calculate(obj) async {
    var result = metodosService.calculate(obj);
    setState(() {
      vazio = false;
      buscando = false;
      dataGraph = result[0];
      dataRaizes = result[1];
      raizes = result[2];
      tabela = result[3];
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    equacaoController.dispose();
    aController.dispose();
    bController.dispose();
    maxRepsController.dispose();
    precisaoController.dispose();
    super.dispose();
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  const Text("Definição:"),
                  IconButton(
                      onPressed: () {
                        DetailsData data = DetailsData(widget.typeScreen, dataGraph, dataRaizes, tabela);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EquacaoDetails(
                                    data: data,
                                  )),
                        );
                      },
                      icon: const Icon(Icons.info_outline)),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 8),
                child: Text(
                  definicao,
                  style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
                ),
              ),
              const SizedBox(
                height: 16,
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
                        height: 8,
                      ),
                      Row(children: [
                        Expanded(
                            child: TextFormField(
                          controller: aController,
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: widget.typeScreen == 2 ? 'Equação Derivada' : 'Limite Inicial',
                              hintText: widget.typeScreen == 2 ? "3*x^2 + 3" : "-5",
                              labelStyle: const TextStyle(color: Colors.black)),
                        )),
                        const SizedBox(
                          width: 8,
                        ),
                        widget.typeScreen == 5
                            ? const Text("")
                            : Expanded(
                                child: TextFormField(
                                controller: bController,
                                decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        borderSide: BorderSide.none),
                                    fillColor: Colors.white,
                                    filled: true,
                                    labelText: widget.typeScreen == 2 ? 'Chute Inicial' : 'Limite Final',
                                    hintText: widget.typeScreen == 2 ? "2.5" : "5",
                                    labelStyle: const TextStyle(color: Colors.black)),
                              ))
                      ]),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: maxRepsController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Nº max de iterações',
                                hintText: "25",
                                labelStyle: TextStyle(color: Colors.black)),
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: precisaoController,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Precisão do Cálculo',
                                hintText: "0.001",
                                labelStyle: TextStyle(color: Colors.black)),
                          )),
                        ],
                      ),
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
                              var equacaoCtrlr = "";
                              var derivadaCtrlr = "";
                              var inicialCtrlr = 0.0;
                              var finalCtrlr = 0.0;
                              var chuteInicialCtrlr = 0.0;
                              var precisaoCtrlr = 0.0;
                              var maxRepsCtrlr = 0;

                              if (equacaoController.text.isEmpty) {
                                _showModal(context, "Faltando informações", "Não é possível calcular sem a equação.");
                                return;
                              }
                              equacaoCtrlr = equacaoController.text;

                              if (widget.typeScreen == 2) {
                                if (aController.text.isEmpty) {
                                  _showModal(context, "Faltando informações",
                                      "O método de Newton-Raphson exige uma equação derivada.");
                                  return;
                                }
                                derivadaCtrlr = aController.text;

                                if (bController.text.isEmpty) {
                                  _showModal(context, "Faltando informações", "É necessário informar o chute inicial.");
                                  return;
                                }
                                chuteInicialCtrlr = double.parse(bController.text);
                              } else {
                                if (aController.text.isEmpty) {
                                  _showModal(
                                      context, "Faltando informações", "É necessário informar um limite inicial.");
                                  return;
                                }
                                inicialCtrlr = double.parse(aController.text);

                                if (bController.text.isEmpty && widget.typeScreen != 5) {
                                  _showModal(context, "Faltando informações", "É necessário informar um limite final.");
                                  return;
                                }
                                if (widget.typeScreen != 5) finalCtrlr = double.parse(bController.text);
                              }

                              if (precisaoController.text.isEmpty) {
                                precisaoController.text = "0.001";
                                precisaoCtrlr = 0.001;
                              } else {
                                precisaoCtrlr = double.parse(precisaoController.text);
                              }

                              if (maxRepsController.text.isEmpty) {
                                maxRepsController.text = "50";
                                maxRepsCtrlr = 50;
                              } else {
                                maxRepsCtrlr = int.parse(maxRepsController.text);
                              }

                              MyRequest obj = MyRequest(1, "equacao", "equacaoDerivada", 1, 1, 1, 1);

                              switch (widget.typeScreen) {
                                case 2:
                                  obj = MyRequest(widget.typeScreen, equacaoCtrlr, derivadaCtrlr, chuteInicialCtrlr,
                                      finalCtrlr, precisaoCtrlr, maxRepsCtrlr);
                                  break;

                                default:
                                  obj = MyRequest(widget.typeScreen, equacaoCtrlr, derivadaCtrlr, inicialCtrlr,
                                      finalCtrlr, precisaoCtrlr, maxRepsCtrlr);
                                  break;
                              }

                              setState(() {
                                buscando = true;
                                vazio = true;
                              });

                              calculate(obj);
                            },
                            child: const Text('Calcular', style: TextStyle(fontSize: 24), textAlign: TextAlign.center),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
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
                                      if (widget.typeScreen == 2)
                                        const Text(
                                            "O método de Newton-Raphson encontra somente uma raíz a partir da aproximação inicial!"),
                                      Text("A equação fornecida contém ${raizes.length} raízes:"),
                                      raizes.isNotEmpty
                                          ? SizedBox(
                                              height: 50,
                                              child: ListView(
                                                // This next line does the trick.
                                                scrollDirection: Axis.horizontal,
                                                children: raizes
                                                    .map((e) => Padding(
                                                          padding: const EdgeInsets.all(12),
                                                          child: Text(
                                                            e.toStringAsFixed(2),
                                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                                          ),
                                                        ))
                                                    .toList(),
                                              ),
                                            )
                                          : const Text("O intervalo atual não possui raízes"),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: SfCartesianChart(
                                            primaryXAxis: NumericAxis(crossesAt: 0),
                                            primaryYAxis: NumericAxis(crossesAt: 0),
                                            title: ChartTitle(text: title),
                                            tooltipBehavior: _tooltipBehavior,
                                            zoomPanBehavior: _zoomPanBehavior,
                                            crosshairBehavior: _crooshairBehavior,
                                            series: <ChartSeries>[
                                              LineSeries<EquacaoData, double>(
                                                  dataSource: dataGraph,
                                                  xValueMapper: (EquacaoData data, _) => data.x,
                                                  yValueMapper: (EquacaoData data, _) => data.y,
                                                  animationDuration: 5000,
                                                  // Enable data label
                                                  dataLabelSettings: const DataLabelSettings(isVisible: true)),
                                              ScatterSeries<EquacaoData, double>(
                                                  dataSource: dataRaizes,
                                                  xValueMapper: (EquacaoData data, _) => data.x,
                                                  yValueMapper: (EquacaoData data, _) => 0,
                                                  animationDuration: 1000,
                                                  // Enable data label
                                                  dataLabelSettings:
                                                      const DataLabelSettings(isVisible: true, useSeriesColor: true)),
                                            ]),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      const Text("Experimente alterar os valores informados!"),
                                    ],
                                  )
                                : const Text("Insira os dados acima para visualizar o gráfico"),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
