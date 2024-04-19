import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';
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
        title = "Método da Bisseção";
        definicao =
            "O método da bisseção consiste em dividir o intervalo [a, b] ao meio, obtendo os subintervalos [a, x] e [x, b], e considerar como intervalo de busca o subintervalo em que f tem sinais opostos nos extremos. Em seguida  repete-se o procedimento com o subintervalo de interesse. Após um número finito de subdivisões ou encontramos uma solução ou sabemos que a raiz encontra-se em algum subintervalo [ak, bk].";
        explicacao =
            "Se considerarmos os seguintes dados e aplicá-los ao método da bisseção, temos";
        break;
      case 2:
        title = "Método de Newton-Raphson";
        definicao =
            "O método de Newton, desenvolvido por Isaac Newton e Joseph Raphson, tem o objetivo de estimar as raízes de uma função. Para isso, escolhe-se uma aproximação inicial para esta";
        explicacao =
            "Se considerarmos os seguintes dados e aplicá-los ao método de Newton-Raphson, temos";
        break;
      case 3:
        title = "Método da Secante";
        definicao =
            "O método das secantes é um algoritmo de busca de raízes que usa uma sequência de raízes de linhas secantes para aproximar cada vez melhor a raiz de uma função f";
        explicacao =
            "Se considerarmos os seguintes dados e aplicá-los ao método da Secante, temos";
        break;
      case 4:
        title = "Método da falsa Posição";
        definicao =
            "O método da posição falsa ou regula falsi é um método numérico usado para resolver equações lineares definidas em um intervalo [a, b], partindo do pressuposto de que haja uma solução em um subintervalo contido em [a, b";
        explicacao =
            "Se considerarmos os seguintes dados e aplicá-los ao método da Falsa Posição, temos";
        break;
      case 5:
        title = "Método do Ponto Fixo";
        definicao =
            "O método do ponto fixo é um método de se calcular pontos fixos de funções.  O ponto fixo p de uma função g(x) é simplesmente um ponto tal que  g(p)=p. Ou sejam é um ponto onde a função g(x) encontra a reta x=y";
        explicacao =
            "Se considerarmos os seguintes dados e aplicá-los ao método do Ponto Fixo, temos";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Função"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 8),
              child: Text(
                definicao,
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            const SizedBox(
              height: 8,
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
                  Text(
                    explicacao,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    // tabela
                    width: double.infinity,
                    child: Center(
                      child: Column(children: [
                        const Text(
                          "Dados",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        DataTable(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          columnSpacing: 20.0,
                          columns: [
                            DataColumn(label: Text(widget.data.tabela[0][0])),
                            DataColumn(label: Text(widget.data.tabela[0][1])),
                            DataColumn(label: Text(widget.data.tabela[0][2])),
                            DataColumn(label: Text(widget.data.tabela[0][3])),
                            DataColumn(label: Text(widget.data.tabela[0][4])),
                          ],
                          rows: [
                            DataRow(cells: [
                              DataCell(
                                  Text(widget.data.tabela[1][0].toString())),
                              DataCell(
                                  Text(widget.data.tabela[1][1].toString())),
                              DataCell(
                                  Text(widget.data.tabela[1][2].toString())),
                              DataCell(
                                  Text(widget.data.tabela[1][3].toString())),
                              DataCell(
                                  Text(widget.data.tabela[1][4].toString())),
                            ]),
                          ],
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    // tabela
                    width: double.infinity,
                    child: Center(
                      child: Column(children: [
                        const Text(
                          "Tabela",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: DataTable(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                border: TableBorder.symmetric(
                                    inside: BorderSide(
                                        width: 1,
                                        color: Colors.black.withOpacity(0.5))),
                                columnSpacing: 10.0,
                                columns: [
                                  DataColumn(
                                      label: Text(widget.data.tabela[2][0])),
                                  DataColumn(
                                      label: Text(widget.data.tabela[2][1])),
                                  DataColumn(
                                      label: Text(widget.data.tabela[2][2])),
                                  DataColumn(
                                      label: Text(widget.data.tabela[2][3])),
                                  DataColumn(
                                      label: Text(widget.data.tabela[2][4])),
                                ],
                                rows: [
                                  for (int i = 3;
                                      i < widget.data.tabela.length;
                                      i++)
                                    DataRow(
                                        color: WidgetStateProperty.resolveWith<
                                            Color?>((Set<WidgetState> states) {
                                          // All rows will have the same selected color.
                                          if (states
                                              .contains(WidgetState.selected)) {
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.08);
                                          }
                                          // Even rows will have a grey color.
                                          if (i.isEven) {
                                            return Colors.grey.withOpacity(0.2);
                                          }
                                          return null; // Use default value for other states and odd rows.
                                        }),
                                        cells: [
                                          DataCell(Text(widget.data.tabela[i][0]
                                              .toString())),
                                          DataCell(Text(widget.data.tabela[i][1]
                                              .toString())),
                                          DataCell(Text(widget.data.tabela[i][2]
                                              .toString())),
                                          DataCell(Text(widget.data.tabela[i][3]
                                              .toString())),
                                          DataCell(Text(widget.data.tabela[i][4]
                                              .toString())),
                                        ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Gráfico",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                      // GRAFICO
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
                          const SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: SfTheme(
                              data: SfThemeData(
                                  chartThemeData: SfChartThemeData(
                                      plotAreaBackgroundColor: Theme.of(context)
                                          .colorScheme
                                          .surface)),
                              child: SfCartesianChart(
                                  primaryXAxis: const NumericAxis(crossesAt: 0),
                                  primaryYAxis: const NumericAxis(crossesAt: 0),
                                  series: <CartesianSeries>[
                                    LineSeries<EquacaoData, double>(
                                        dataSource: widget.data.dataGraph,
                                        xValueMapper: (EquacaoData data, _) =>
                                            data.x,
                                        yValueMapper: (EquacaoData data, _) =>
                                            data.y,
                                        animationDuration: 5000,
                                        // Enable data label
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true)),
                                    ScatterSeries<EquacaoData, double>(
                                        dataSource: widget.data.dataRaizes,
                                        xValueMapper: (EquacaoData data, _) =>
                                            data.x,
                                        yValueMapper: (EquacaoData data, _) =>
                                            0,
                                        animationDuration: 1000,
                                        // Enable data label
                                        dataLabelSettings:
                                            const DataLabelSettings(
                                                isVisible: true,
                                                useSeriesColor: true)),
                                  ]),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
