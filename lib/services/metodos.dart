import 'dart:math' as math;
import 'package:math_expressions/math_expressions.dart';
import 'package:zeromath/models/request.dart';

class Metodos {
  List<double> linspace(double inicio, double fim, int qtd) {
    double range = fim - inicio;
    double parte = range / qtd;

    List<double> intervalo = [];

    for (double i = inicio; i <= fim; i += parte) {
      intervalo.add(i);
    }

    return intervalo;
  }

  geraGrafico(MyRequest equacao) {
    var intervalo = linspace(equacao.pontoA!, equacao.pontoB!, 100);

    var y = [];

    for (var i in intervalo) {
      y.add(evaluateExpression(equacao.equacao!, i));
    }


    var resultado = {"x": intervalo, "y": y};
    return resultado;
  }

  calculate(MyRequest equacao) {
    var intervalo = linspace(equacao.pontoA!, equacao.pontoB!, 100);

    var y = [];

    for (var i in intervalo) {
      y.add(evaluateExpression(equacao.equacao!, i));
    }

    var res = metBissecao(equacao.equacao!, equacao.pontoA!, equacao.pontoB!, equacao.nroReps!, equacao.precisao!);

    var resultado = {"x": intervalo, "y": y, "raizes": res};
    return resultado;
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
    var a = A;
    var b = B;
    List<List<double>> raizes = [];

    while (i < N) {
      x = (a + b) / 2;
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

      i += 1;
    }
    return raizes;
  }
}
