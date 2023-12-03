import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:zeromath/ad_state.dart';
import 'package:zeromath/apps/equacao_details.dart';
import 'package:zeromath/models/details_data.dart';
import 'package:zeromath/models/equacao_data.dart';
import 'package:zeromath/models/request.dart';
import 'package:zeromath/services/metodos.dart';

import '../constants/cores.constants.dart' as cores;

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
  String equacao = "";
  List<EquacaoData> dataGraph = [];
  List<EquacaoData> dataRaizes = [];
  List<double> raizes = [];
  List<List<dynamic>> tabela = [];

  Metodos metodosService = Metodos();

  TooltipBehavior _tooltipBehavior = TooltipBehavior();
  ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior();
  CrosshairBehavior _crooshairBehavior = CrosshairBehavior();

  BannerAd banner =
      BannerAd(size: AdSize.banner, adUnitId: "", listener: const BannerAdListener(), request: const AdRequest())
        ..load();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) => {
          setState(() {
            banner = BannerAd(
              adUnitId: adState.bannerAdUnitId,
              size: AdSize.banner,
              request: const AdRequest(),
              listener: adState.adListener,
            )..load();
          })
        });
  }

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
                  if (!vazio)
                    ElevatedButton(
                      style: TextButton.styleFrom(
                          elevation: 1,
                          foregroundColor: Colors.black,
                          backgroundColor: cores.background,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
                      onPressed: () async {
                        DetailsData data = DetailsData(widget.typeScreen, equacao, dataGraph, dataRaizes, tabela);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EquacaoDetails(
                                    data: data,
                                  )),
                        );
                      },
                      child: const Text('Exibir passo a passo',
                          style: TextStyle(fontSize: 12), textAlign: TextAlign.center),
                    )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 8),
                child: Text(
                  definicao,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(
                height: 16,
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
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: maxRepsController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                              fillColor: Theme.of(context).colorScheme.tertiary,
                              filled: true,
                              labelText: 'Nº max de iterações',
                              hintText: "25",
                            ),
                          )),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                              child: TextFormField(
                            controller: precisaoController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                              fillColor: Theme.of(context).colorScheme.tertiary,
                              filled: true,
                              labelText: 'Precisão do Cálculo',
                              hintText: "0.001",
                            ),
                          )),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
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
                            fillColor: Theme.of(context).colorScheme.tertiary,
                            filled: true,
                            labelText: widget.typeScreen == 4
                                ? 'Equação Derivada'
                                : widget.typeScreen == 5
                                    ? 'Função de Iteração'
                                    : 'Limite  inicial',
                            hintText: widget.typeScreen == 4
                                ? '2*x + 1'
                                : widget.typeScreen == 5
                                    ? '6-x^2'
                                    : '-5',
                          ),
                        )),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: TextFormField(
                          controller: bController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(15)), borderSide: BorderSide.none),
                            fillColor: Theme.of(context).colorScheme.tertiary,
                            filled: true,
                            labelText:
                                widget.typeScreen == 4 || widget.typeScreen == 5 ? 'Chute Inicial' : 'Limite Final',
                            hintText: widget.typeScreen == 4
                                ? "2.5"
                                : widget.typeScreen == 5
                                    ? '1.5'
                                    : "5",
                          ),
                        ))
                      ]),
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
                              int reps = 0;
                              double precisao = 0;
                              String equacao = '';
                              String funcao = '';
                              double chute = 0;
                              double pontoA = 0;
                              double pontoB = 0;

                              MyRequest obj = MyRequest(1, "equacao", "equacaoDerivada", 1, 1, 1, 1);

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
                                _showModal(context, "Faltando informações", "Não é possível calcular sem a equação.");
                                return;
                              }

                              equacao = equacaoController.text;

                              switch (widget.typeScreen) {
                                case 4:
                                  if (aController.text.isEmpty) {
                                    _showModal(context, "Faltando informações",
                                        "O método de Newton-Raphson exige uma equação derivada");
                                    return;
                                  }

                                  funcao = aController.text;

                                  if (bController.text.isEmpty) {
                                    _showModal(
                                        context, "Faltando informações", "É necessário informar o chute inicial.");
                                    return;
                                  }
                                  chute = double.parse(bController.text);

                                  obj = MyRequest(4, equacao, funcao, chute, 0, precisao, reps);
                                  break;

                                case 5:
                                  if (aController.text.isEmpty) {
                                    _showModal(context, "Faltando informações",
                                        "O método do Ponto Fixo exige uma função de Iteração");
                                    return;
                                  }

                                  funcao = aController.text;

                                  if (bController.text.isEmpty) {
                                    _showModal(
                                        context, "Faltando informações", "É necessário informar o chute inicial.");
                                    return;
                                  }
                                  chute = double.parse(bController.text);

                                  obj = MyRequest(5, equacao, funcao, chute, 0, precisao, reps);
                                  break;

                                default:
                                  if (aController.text.isEmpty) {
                                    _showModal(
                                        context, "Faltando informações", "É necessário inserir o intervalo inicial");
                                    return;
                                  }

                                  pontoA = double.parse(aController.text);

                                  if (bController.text.isEmpty) {
                                    _showModal(
                                        context, "Faltando informações", "É necessário inserir o intervalo final");
                                    return;
                                  }
                                  pontoB = double.parse(bController.text);

                                  obj = MyRequest(widget.typeScreen, equacao, '', pontoA, pontoB, precisao, reps);
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
                        child: !vazio
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.typeScreen == 2)
                                    const Text(
                                        "O método de Newton-Raphson encontra somente uma raíz a partir da aproximação inicial!"),
                                  Text(
                                    "A equação fornecida contém ${raizes.length} raízes:",
                                    style: const TextStyle(color: Colors.black),
                                  ),
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
                                                        style: const TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
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
                                    child: SfTheme(
                                      data: SfThemeData(
                                          chartThemeData: SfChartThemeData(plotAreaBackgroundColor: Colors.white)),
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
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text("Experimente alterar os valores informados!"),
                                ],
                              )
                            : Column(
                                children: [
                                  const Text("Insira os dados acima para visualizar o gráfico"),
                                  SizedBox(
                                    height: 60,
                                    child: AdWidget(ad: banner),
                                  ),
                                ],
                              ),
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
