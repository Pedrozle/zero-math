import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:zeromath/components/my_button.dart';
import 'package:zeromath/components/my_text_input.dart';
import 'package:zeromath/models/details_data.dart';
import 'package:zeromath/models/equacao.dart';
import 'package:zeromath/models/equacao_data.dart';
import 'package:zeromath/pages/equation_details.dart';
import 'package:zeromath/services/metodos.dart';

class EquationPage extends StatefulWidget {
  const EquationPage({super.key, required this.type});

  final int type;

  @override
  State<EquationPage> createState() => _EquationPageState();
}

class _EquationPageState extends State<EquationPage> {
  String title = "";
  String definicao = "";
  String aControllerText = "Limite inicial";
  String aControllerHint = "-5";
  String bControllerText = "Limite final";
  String bControllerHint = "5";

  final equacaoController = TextEditingController();
  final aController = TextEditingController();
  final bController = TextEditingController();
  final maxRepsController = TextEditingController();
  final precisaoController = TextEditingController();

  bool vazio = true;
  bool buscando = false;
  String equacao = "";
  List<EquacaoData> dataGraph = [];
  List<EquacaoData> dataRaizes = [];
  List<double> raizes = [];
  List<List<dynamic>> tabela = [];

  Metodos metodosService = Metodos();

  TooltipBehavior _tooltipBehavior = TooltipBehavior();
  ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior();
  CrosshairBehavior _crooshairBehavior = CrosshairBehavior();

  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
    _zoomPanBehavior = ZoomPanBehavior(
        enablePinching: true,
        enableSelectionZooming: true,
        enablePanning: true);
    _crooshairBehavior = CrosshairBehavior(enable: true);
    switch (widget.type) {
      case 1:
        title = "Método da bisseção";
        definicao =
            "O método da bisseção ou método da bissecção é um método de busca de raízes que bissecta repetidamente um intervalo e então seleciona um subintervalo contendo a raiz para processamento adicional.";
        break;
      case 2:
        title = "Método da secante";
        definicao =
            "O método das secantes é um algoritmo de busca de raízes que usa uma sequência de raízes de linhas secantes para aproximar cada vez melhor a raiz de uma função f";
        break;
      case 3:
        title = "Método da falsa posição";
        definicao =
            "O método da posição falsa ou regula falsi é um método numérico usado para resolver equações lineares definidas em um intervalo [a, b], partindo do pressuposto de que haja uma solução em um subintervalo contido em [a, b";
        break;
      case 4:
        title = "Método de Newton-Raphson";
        definicao =
            "O método de Newton, desenvolvido por Isaac Newton e Joseph Raphson, tem o objetivo de estimar as raízes de uma função. Para isso, escolhe-se uma aproximação inicial para esta equação e informa sua equação derivada.";
        aControllerText = "Equação derivada";
        aControllerHint = "2*x + 1";
        bControllerText = "Chute inicial";
        bControllerHint = "2.5";
        break;
      case 5:
        title = "Método do ponto fixo";
        definicao =
            "O método do ponto fixo é um método de se calcular pontos fixos de funções.";
        aControllerText = "Função de iteração";
        aControllerHint = "6 - x^2";
        bControllerText = "Chute inicial";
        bControllerHint = "1.5";
        break;
    }
  }

  calculate(obj) {
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

  Widget returnGrafico() {
    return vazio == true
        ? const SizedBox(
            height: 10,
          )
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                if (widget.type == 4)
                  const Text(
                      "O método de Newton-Raphson encontra somente uma raíz a partir da aproximação inicial!"),
                raizes.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            "A equação fornecida contém ${raizes.length} ${raizes.length > 1 ? 'raízes' : 'raiz'}:",
                          ),
                          SizedBox(
                            height: 50,
                            child: ListView(
                              // This next line does the trick.
                              scrollDirection: Axis.horizontal,
                              children: raizes
                                  .map((e) => Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          e.toStringAsFixed(2),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          )
                        ],
                      )
                    : const Text("O intervalo atual não possui raízes"),
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
                        title: ChartTitle(text: title),
                        tooltipBehavior: _tooltipBehavior,
                        zoomPanBehavior: _zoomPanBehavior,
                        crosshairBehavior: _crooshairBehavior,
                        series: <CartesianSeries>[
                          LineSeries<EquacaoData, double>(
                              dataSource: dataGraph,
                              xValueMapper: (EquacaoData data, _) => data.x,
                              yValueMapper: (EquacaoData data, _) => data.y,
                              animationDuration: 5000,
                              // Enable data label
                              dataLabelSettings:
                                  const DataLabelSettings(isVisible: true)),
                          ScatterSeries<EquacaoData, double>(
                              dataSource: dataRaizes,
                              xValueMapper: (EquacaoData data, _) => data.x,
                              yValueMapper: (EquacaoData data, _) => 0,
                              animationDuration: 1000,
                              // Enable data label
                              dataLabelSettings: const DataLabelSettings(
                                  isVisible: true, useSeriesColor: true)),
                        ]),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text("Experimente alterar os valores informados!"),
              ],
            ));
  }

  calcular() {
    int reps = 0;
    double precisao = 0;
    String equacao = '';
    String funcao = '';
    double chute = 0;
    double pontoA = 0;
    double pontoB = 0;

    Equacao obj = Equacao(1, "equacao", "equacaoDerivada", 1, 1, 1, 1);

    if (maxRepsController.text.isEmpty) {
      reps = 50;
      maxRepsController.text = reps.toString();
    } else {
      reps = int.parse(maxRepsController.text);
    }

    if (precisaoController.text.isEmpty) {
      precisao = 0.001;
      precisaoController.text = precisao.toString();
    } else {
      precisao = double.parse(precisaoController.text);
    }

    if (equacaoController.text.isEmpty) {
      _showModal(context, "Faltando informações",
          "Não é possível calcular sem a equação.");
      return;
    }

    equacao = equacaoController.text;

    switch (widget.type) {
      case 4:
        if (aController.text.isEmpty) {
          _showModal(context, "Faltando informações",
              "O método de Newton-Raphson exige uma equação derivada");
          return;
        }

        funcao = aController.text;

        if (bController.text.isEmpty) {
          _showModal(context, "Faltando informações",
              "É necessário informar o chute inicial.");
          return;
        }
        chute = double.parse(bController.text);

        obj = Equacao(4, equacao, funcao, chute, 0, precisao, reps);
        break;

      case 5:
        if (aController.text.isEmpty) {
          _showModal(context, "Faltando informações",
              "O método do Ponto Fixo exige uma função de Iteração");
          return;
        }

        funcao = aController.text;

        if (bController.text.isEmpty) {
          _showModal(context, "Faltando informações",
              "É necessário informar o chute inicial.");
          return;
        }
        chute = double.parse(bController.text);

        obj = Equacao(5, equacao, funcao, chute, 0, precisao, reps);
        break;

      default:
        if (aController.text.isEmpty) {
          _showModal(context, "Faltando informações",
              "É necessário inserir o intervalo inicial");
          return;
        }

        pontoA = double.parse(aController.text);

        if (bController.text.isEmpty) {
          _showModal(context, "Faltando informações",
              "É necessário inserir o intervalo final");
          return;
        }
        pontoB = double.parse(bController.text);

        obj = Equacao(widget.type, equacao, '', pontoA, pontoB, precisao, reps);
        break;
    }

    setState(() {
      buscando = true;
      vazio = true;
    });

    calculate(obj);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Definição",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!vazio)
                    ButtonComponent(
                        radius: 10,
                        onClick: () {
                          DetailsData data = DetailsData(widget.type, equacao,
                              dataGraph, dataRaizes, tabela);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EquacaoDetails(
                                      data: data,
                                    )),
                          );
                        },
                        label: "Exibir passo a passo")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                definicao,
                style: const TextStyle(fontStyle: FontStyle.italic),
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
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                            label: "Nº max de iterações",
                            controller: maxRepsController,
                            hint: '25'),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextInputComponent(
                            label: "Precisão do Cálculo",
                            controller: precisaoController,
                            hint: '0.001'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextInputComponent(
                      label: "Equação",
                      onChange: (value) => {
                            setState(() {
                              vazio = true;
                            })
                          },
                      controller: equacaoController,
                      hint: "Insira uma equação"),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextInputComponent(
                            label: aControllerText,
                            controller: aController,
                            hint: aControllerHint),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextInputComponent(
                            label: bControllerText,
                            controller: bController,
                            hint: bControllerHint),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonComponent(
                            radius: 10, onClick: calcular, label: "Calcular"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  returnGrafico(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
