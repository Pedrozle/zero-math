import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import 'package:zeromath/models/equacao_data.dart';
import 'package:zeromath/models/request.dart';

class Metodos {
  List<double> linspace(double inicio, double fim, int qtd) {
    double range = (fim - inicio).abs();
    double parte = range / qtd;

    List<double> intervalo = [];

    for (double i = inicio; i <= fim; i += parte) {
      intervalo.add(i);
    }

    return intervalo;
  }

  List<EquacaoData> geraGrafico(MyRequest equacao) {
    List<double> intervalo = linspace(equacao.pontoA!, equacao.pontoB!, 100);

    List<double> y = [];

    for (var i in intervalo) {
      y.add(evaluateExpression(equacao.equacao!, i));
    }

    List<EquacaoData> dataGraphic = [];

    for (final (index, item) in intervalo.indexed) {
      EquacaoData dado = EquacaoData(item, y.elementAt(index));
      dataGraphic.add(dado);
    }
    return dataGraphic;
  }

  calculate(MyRequest equacao) {
    double inicio = 0;
    double fim = 0;

    if (equacao.tipoEquacao == 2 || equacao.tipoEquacao == 5) {
      inicio = -5;
      fim = 5;
    } else {
      inicio = equacao.pontoA!;
      fim = equacao.pontoB!;
    }

    List<double> intervalo = linspace(inicio, fim, 100);

    var y = [];

    for (var i in intervalo) {
      y.add(evaluateExpression(equacao.equacao!, i));
    }

    dynamic res;
    List<List<double>> raizes = [];
    List<EquacaoData> dataGraphic = [];
    List<EquacaoData> dataRaizes = [];

    switch (equacao.tipoEquacao) {
      case 1:
        res = metBissecao(equacao.equacao!, equacao.pontoA!, equacao.pontoB!, equacao.nroReps, equacao.precisao);
        break;
      case 2:
        res = metNewtonRaph(
            equacao.equacao!, equacao.equacaoDerivada!, equacao.pontoA!, equacao.nroReps, equacao.precisao);
        break;
      case 3:
        res = metSecante(equacao.equacao!, equacao.pontoA!, equacao.pontoB!, equacao.nroReps, equacao.precisao);
        break;
      case 4:
        res = metFalsaPos(equacao.equacao!, equacao.pontoA!, equacao.pontoB!, equacao.nroReps, equacao.precisao);
        break;
      case 5:
        res = metPontoFixo(equacao.equacao!, equacao.pontoA!, equacao.nroReps, equacao.precisao);
        break;
    }

    raizes = res[0];

    for (final (index, item) in intervalo.indexed) {
      EquacaoData dado = EquacaoData(item, y.elementAt(index));
      dataGraphic.add(dado);
    }

    for (final (_, item) in raizes.indexed) {
      EquacaoData dado = EquacaoData(item[0], item[1]);
      dataRaizes.add(dado);
    }

    List<double> raiz = raizes.map((e) => e[0]).toList();

    return [dataGraphic, dataRaizes, raiz, res[1]];
  }

  evaluateExpression(String equacao, double valX) {
    Parser p = Parser();
    Variable x = Variable('x');
    ContextModel cm = ContextModel()..bindVariable(x, Number(valX));
    Expression exp = p.parse(equacao);

    return exp.evaluate(EvaluationType.REAL, cm);
  }

  metBissecao(String eq, double A, double B, int N, double p) {
    int i = 0;
    double x = 0;
    double x0 = 0;
    double a = A;
    double b = B;
    List<List<double>> raizes = [];
    List<List<double>> tabela = [];

    double erro = double.infinity;

    while (erro > p && i < N) {
      List<double> tableRow = [];
      x = (a + b) / 2;
      tableRow.add(a);
      tableRow.add(b);
      tableRow.add(x);
      double exp = evaluateExpression(eq, x);
      if (exp.abs() < p) {
        raizes.add([x, exp]);
        a = x + 0.1;
        b = B;
        i = 1;
        continue;
      }

      double eqa = evaluateExpression(eq, a);
      double eqb = evaluateExpression(eq, x);

      if ((eqa * eqb) < 0) {
        b = x;
      } else {
        a = x;
      }
      x0 = x;
      x = (a + b) / 2;
      erro = (x - x0).abs();
      tableRow.add(erro);
      tabela.add(tableRow);
      i += 1;
    }
    return [raizes, tabela];
  }

  List<List<double>> metNewtonRaph(String eq, String deriv, double A, int N, double p) {
    int i = 1;
    double xant = A;
    double xi = 0;
    List<List<double>> raizes = [];

    while (i < N) {
      double f = evaluateExpression(eq, xant);
      double df = evaluateExpression(deriv, xant);
      double dx = df != 0 ? f / df : 1;
      xi = xant - dx;

      if ((xi - xant).abs() < p || (xi - xant).abs() == 0) {
        raizes.add([xi, f]);
        xant = xi;
        i = 0;
        if ((xi - xant).abs() == 0) break;
      }
      xant = xi;
      i += 1;
    }

    return raizes;
  }

  List<List<double>> metSecante(String eq, double A, double B, int N, double p) {
    int i = 0;
    double a = A;
    double b = B;
    List<List<double>> raizes = [];

    while (i < N) {
      double fa = evaluateExpression(eq, a);
      double fb = evaluateExpression(eq, b);
      double x = ((b * fa) - (a * fb)) / (fa - fb);

      double compare = ((x - a) / x).abs();
      if (compare < p) {
        raizes.add([x, compare]);
        return raizes;
      }
      b = a;
      a = x;
      i += 1;
    }

    return raizes;
  }

  List<List<double>> metFalsaPos(String eq, double A, double B, int N, double p) {
    int i = 0;
    double er = 1;
    double a = A;
    double b = B;
    double x = A;
    List<List<double>> raizes = [];

    while (er > p || i <= N) {
      double x0 = x;
      double fa = evaluateExpression(eq, a);
      double fb = evaluateExpression(eq, b);
      x = a - (fa * (b - a)) / (fb - fa);

      double fx = evaluateExpression(eq, x);
      if ((fx * a) < 0) {
        b = x;
      } else {
        a = x;
      }

      er = ((x - x0).abs() / x.abs());
      i += 1;
    }

    return raizes;
  }

  List<List<double>> metPontoFixo(String eq, double A, int N, double p) {
    List<List<double>> raizes = [];

    double x = A;

    for (int i = 0; i < N; i++) {
      double x_prox = evaluateExpression(eq, x);
      double err = (x_prox - x).abs();
      if (err < p) {
        raizes.add([x_prox, err]);
        break;
      }

      x = x_prox;
    }

    return raizes;
  }
}
