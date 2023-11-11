import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:zeromath/models/details_data.dart';
import 'package:zeromath/models/equacao_data.dart';

class EquacaoDetails extends StatefulWidget {
  const EquacaoDetails({super.key, required this.data});
  final DetailsData data;

  @override
  State<EquacaoDetails> createState() => _EquacaoDetails();
}

class _EquacaoDetails extends State<EquacaoDetails> {
  String title = "";
  String definicao = "";
  String explicacao = "";

  @override
  void initState() {
    super.initState();
    switch (widget.data.typeScreen) {
      case 1:
        title = "Método da bisseção";
        definicao =
            "O método da bisseção consiste em dividir o intervalo [a, b] ao meio, obtendo os subintervalos [a, x] e [x, b], e considerar como intervalo de busca o subintervalo em que f tem sinais opostos nos extremos. Em seguida  repete-se o procedimento com o subintervalo de interesse. Após um número finito de subdivisões ou encontramos uma solução ou sabemos que a raiz encontra-se em algum subintervalo [ak, bk].";
        explicacao =
            "Se considerarmos a equação: ${widget.data.equacao}, a = ${widget.data.tabela[1][1]}, b = ${widget.data.tabela[1][2]}, critério de parada = (b-a)/2 < precisão, ao aplicarmos estes dados na função da bisseção encontramos a tabela e o gráfico abaixo";
        break;
      case 2:
        title = "Método de Newton-Raphson";
        definicao =
            "O método de Newton, desenvolvido por Isaac Newton e Joseph Raphson, tem o objetivo de estimar as raízes de uma função. Para isso, escolhe-se uma aproximação inicial para esta";
        explicacao = "";
        break;
      case 3:
        title = "Método da secante";
        definicao =
            "O método das secantes é um algoritmo de busca de raízes que usa uma sequência de raízes de linhas secantes para aproximar cada vez melhor a raiz de uma função f";
        explicacao = "";
        break;
      case 4:
        title = "Método da falsa posição";
        definicao =
            "O método da posição falsa ou regula falsi é um método numérico usado para resolver equações lineares definidas em um intervalo [a, b], partindo do pressuposto de que haja uma solução em um subintervalo contido em [a, b";
        explicacao = "";
        break;
      case 5:
        title = "Método do ponto fixo";
        definicao =
            "O método do ponto fixo é um método de se calcular pontos fixos de funções.  O ponto fixo p de uma função g(x) é simplesmente um ponto tal que  g(p)=p. Ou sejam é um ponto onde a função g(x) encontra a reta x=y";
        explicacao = "";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Detalhes da Função"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 8),
              child: Text(
                definicao,
                style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                explicacao,
                style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Column(children: [
                    const Text(
                      "Tabela",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 300,
                      width: MediaQuery.sizeOf(context).width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columnSpacing: 20.0,
                          columns: [
                            DataColumn(label: Text(widget.data.tabela[0][0])),
                            DataColumn(label: Text(widget.data.tabela[0][1])),
                            DataColumn(label: Text(widget.data.tabela[0][2])),
                            DataColumn(label: Text(widget.data.tabela[0][3])),
                            DataColumn(label: Text(widget.data.tabela[0][4])),
                          ],
                          rows: [
                            for (int i = 1; i < widget.data.tabela.length; i++)
                              DataRow(cells: [
                                DataCell(Text(widget.data.tabela[i][0].toString())),
                                DataCell(Text(widget.data.tabela[i][1].toString())),
                                DataCell(Text(widget.data.tabela[i][2].toString())),
                                DataCell(Text(widget.data.tabela[i][3].toString())),
                                DataCell(Text(widget.data.tabela[i][4].toString())),
                              ]),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: SfCartesianChart(
                    primaryXAxis: NumericAxis(crossesAt: 0),
                    primaryYAxis: NumericAxis(crossesAt: 0),
                    title: ChartTitle(text: title),
                    series: <ChartSeries>[
                      LineSeries<EquacaoData, double>(
                          dataSource: widget.data.dataGraph,
                          xValueMapper: (EquacaoData data, _) => data.x,
                          yValueMapper: (EquacaoData data, _) => data.y,
                          animationDuration: 5000,
                          // Enable data label
                          dataLabelSettings: const DataLabelSettings(isVisible: true)),
                      ScatterSeries<EquacaoData, double>(
                          dataSource: widget.data.dataRaizes,
                          xValueMapper: (EquacaoData data, _) => data.x,
                          yValueMapper: (EquacaoData data, _) => 0,
                          animationDuration: 1000,
                          // Enable data label
                          dataLabelSettings: const DataLabelSettings(isVisible: true, useSeriesColor: true)),
                    ]),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
