import 'package:math_expressions/math_expressions.dart';
import 'package:zeromath/models/equacao.dart';
import 'package:zeromath/models/equacao_data.dart';

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

  List<EquacaoData> geraGrafico(Equacao equacao) {
    List<double> intervalo = linspace(equacao.pontoA!, equacao.pontoB!, 100);

    List<double> y = [];

    for (var i in intervalo) {
      y.add(evaluateExpression(equacao.equacao, i));
    }

    List<EquacaoData> dataGraphic = [];

    for (final (index, item) in intervalo.indexed) {
      EquacaoData dado = EquacaoData(item, y.elementAt(index));
      dataGraphic.add(dado);
    }
    return dataGraphic;
  }

  calculate(Equacao equacao) {
    double inicio = 0;
    double fim = 0;

    if (equacao.tipoEquacao == 4 || equacao.tipoEquacao == 5) {
      inicio = -5;
      fim = 5;
    } else {
      inicio = equacao.pontoA!;
      fim = equacao.pontoB!;
    }

    List<double> intervalo = linspace(inicio, fim, 100);

    var y = [];

    for (var i in intervalo) {
      y.add(evaluateExpression(equacao.equacao, i));
    }

    dynamic res;
    List<List<double>> raizes = [];
    List<List<dynamic>> tabela = [];
    List<EquacaoData> dataGraphic = [];
    List<EquacaoData> dataRaizes = [];

    switch (equacao.tipoEquacao) {
      case 1:
        res = metBissecao(equacao.equacao, equacao.pontoA!, equacao.pontoB!, equacao.nroReps, equacao.precisao);
        break;
      case 2:
        res = metSecante(equacao.equacao, equacao.pontoA!, equacao.pontoB!, equacao.nroReps, equacao.precisao);
        break;
      case 3:
        res = metFalsaPos(equacao.equacao, equacao.pontoA!, equacao.pontoB!, equacao.nroReps, equacao.precisao);
        break;
      case 4:
        res = metNewtonRaph(
            equacao.equacao, equacao.equacaoDerivada!, equacao.pontoA!, equacao.nroReps, equacao.precisao);
        break;
      case 5:
        res =
            metPontoFixo(equacao.equacao, equacao.equacaoDerivada!, equacao.pontoA!, equacao.nroReps, equacao.precisao);
        break;
    }

    raizes = res[0];
    tabela = res[1];

    for (final (index, item) in intervalo.indexed) {
      EquacaoData dado = EquacaoData(item, y.elementAt(index));
      dataGraphic.add(dado);
    }

    for (final (_, item) in raizes.indexed) {
      EquacaoData dado = EquacaoData(item[0], item[1]);
      dataRaizes.add(dado);
    }

    List<double> raiz = raizes.map((e) => e[0]).toList();

    return [dataGraphic, dataRaizes, raiz, tabela];
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
    double x = 0, a = A, b = B;
    List<List<double>> raizes = [];
    List<List<dynamic>> tabela = [];

    tabela.add(['Equação', 'a', 'b', '', 'parada']);
    tabela.add([eq, A, B, '', '(b - a) / 2 < p']);

    tabela.add(['i', 'a', 'b', 'x', 'parada']);
    while (i < N && (a < B - 1 || b < A - 1)) {
      List<dynamic> tableRow = [];
      x = (a + b) / 2;
      tableRow.add(i);
      tableRow.add(a.toStringAsFixed(3));
      tableRow.add(b.toStringAsFixed(3));
      tableRow.add(x.toStringAsFixed(3));
      double fx = evaluateExpression(eq, x);
      bool parada = (b - a) / 2 < p;
      tableRow.add(parada ? 'verdadeiro' : 'falso');
      tabela.add(tableRow);
      if (fx == 0 || parada) {
        raizes.add([x, fx]);
        a = x + 0.1;
        b = B;
        i = 0;
        tabela.add(['Raiz', 'encontrada', '', 'x:', x.toStringAsFixed(3)]);
        continue;
      }
      double fa = evaluateExpression(eq, a);
      double fb = evaluateExpression(eq, x);
      if ((fa * fb) < 0) {
        b = x;
      } else {
        a = x;
      }
      i += 1;
    }
    return [raizes, tabela];
  }

  metNewtonRaph(String eq, String deriv, double A, int N, double p) {
    int i = 0;
    double xant = A;
    double xi = 0;
    List<List<double>> raizes = [];
    List<List<dynamic>> tabela = [];

    tabela.add(['Equação', 'Derivada', 'a', '', 'parada']);
    tabela.add([eq, deriv, A, '', 'abs(xi - xant) < p']);

    tabela.add(['i', 'xant', 'xi', '', 'parada']);

    while (i < N) {
      List<dynamic> tableRow = [];
      double f = evaluateExpression(eq, xant);
      double df = evaluateExpression(deriv, xant);
      double dx = df != 0 ? f / df : 1;
      xi = xant - dx;
      tableRow.add(i);
      tableRow.add(xant.toStringAsFixed(3));
      tableRow.add(xi.toStringAsFixed(3));
      tableRow.add('');
      bool parada = (xi - xant).abs() < p;
      tableRow.add(parada ? 'verdadeiro' : 'falso');
      tabela.add(tableRow);
      if (parada || (xi - xant).abs() == 0) {
        raizes.add([xi, f]);
        xant = xi;
        i = 0;
        tabela.add(['Raiz', 'encontrada', '', 'x:', xi.toStringAsFixed(3)]);
        if ((xi - xant).abs() == 0) break;
      }
      xant = xi;
      i += 1;
    }

    return [raizes, tabela];
  }

  metSecante(String eq, double A, double B, int N, double p) {
    int i = 0;
    double a = A;
    double b = B;
    List<List<double>> raizes = [];
    List<List<dynamic>> tabela = [];

    tabela.add(['Equação', 'a', 'b', '', 'parada']);
    tabela.add([eq, A, B, '', 'abs((x - a) / x) < p']);
    tabela.add(['i', 'xant', 'xantant', 'xi', 'parada']);
    while (i < N) {
      List<dynamic> tableRow = [];
      double fa = evaluateExpression(eq, a);
      double fb = evaluateExpression(eq, b);
      double x = ((b * fa) - (a * fb)) / (fa - fb);
      tableRow.add(i);
      tableRow.add(a.toStringAsFixed(3));
      tableRow.add(b.toStringAsFixed(3));
      tableRow.add(x.toStringAsFixed(3));

      double compare = ((x - a) / x).abs();
      tableRow.add(compare < p ? 'verdadeiro' : 'falso');
      tabela.add(tableRow);
      if (compare < p) {
        raizes.add([x, compare]);
        tabela.add(['Raiz', 'encontrada', '', 'x:', compare.toStringAsFixed(3)]);
        break;
      }
      b = a;
      a = x;
      i += 1;
    }

    return [raizes, tabela];
  }

  metFalsaPos(String eq, double A, double B, int N, double p) {
    int i = 0;
    double x = A, a = A, b = B, fa, fb, fx, x0;
    List<List<double>> raizes = [];
    List<List<dynamic>> tabela = [];

    tabela.add(['Equação', 'a', 'b', '', 'parada']);
    tabela.add([eq, A, B, '', 'abs(x - x0) / abs(x) < p']);
    tabela.add(['i', 'a', 'b', 'x', 'parada']);
    while (i < N) {
      List<dynamic> tableRow = [];
      x0 = x;
      fa = evaluateExpression(eq, a);
      fb = evaluateExpression(eq, b);
      x = a - (fa * (b - a) / (fb - fa));
      fx = evaluateExpression(eq, x);
      tableRow.add(i);
      tableRow.add(a.toStringAsFixed(3));
      tableRow.add(b.toStringAsFixed(3));
      tableRow.add(x.toStringAsFixed(3));

      if ((fx * fa) < 0) {
        b = x;
      } else {
        a = x;
      }

      bool parada = ((x - x0).abs() / x.abs()) < p;
      tableRow.add(parada ? 'verdadeiro' : 'falso');
      tabela.add(tableRow);

      if (parada) {
        raizes.add([x, fx]);
        tabela.add(['Raiz', 'encontrada', '', 'x:', x.toStringAsFixed(3)]);
        break;
      }

      i += 1;
    }
    return [raizes, tabela];
  }

  metPontoFixo(String eq, String it, double A, int N, double p) {
    List<List<double>> raizes = [];
    List<List<dynamic>> tabela = [];

    tabela.add(['Equação', 'Função Iteração', 'a', '', 'parada']);
    tabela.add([eq, it, A, '', 'abs(x - xAnt) < p']);

    tabela.add(['i', 'x', 'xProx', '', 'parada']);

    int i = 0;

    double xAnt = A;

    while (i < N) {
      List<dynamic> tableRow = [];
      tableRow.add(i);
      tableRow.add('');
      double x = evaluateExpression(it, xAnt);
      tableRow.add(x.toStringAsFixed(3));
      tableRow.add(xAnt.toStringAsFixed(3));

      bool parada = (x - xAnt).abs() < p;
      tableRow.add(parada ? 'verdadeiro' : 'falso');
      tabela.add(tableRow);

      if (parada) {
        raizes.add([x, 0]);
        tabela.add(['Raiz', 'encontrada', '', 'x:', x.toStringAsFixed(3)]);
        break;
      }
      xAnt = x;
      i += 1;
    }

    return [raizes, tabela];
  }
}
