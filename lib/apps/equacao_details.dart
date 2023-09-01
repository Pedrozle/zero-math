import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class EquacaoDetails extends StatefulWidget {
  const EquacaoDetails({super.key, required this.typeScreen});
  final int typeScreen;

  @override
  State<EquacaoDetails> createState() => _EquacaoDetails();
}

class _EquacaoDetails extends State<EquacaoDetails> {
  String title = "";
  String definicao = "";
  String imgPath1 = "";
  String imgPath2 = "";
  String imgPath3 = "";
  String explicacao = "";

  @override
  void initState() {
    super.initState();
    switch (widget.typeScreen) {
      case 1:
        title = "Método da bisseção";
        definicao =
            "O método da bisseção consiste em dividir o intervalo [a, b] ao meio, obtendo os subintervalos [a, m] e [m, b], e considerar como intervalo de busca o subintervalo em que f tem sinais opostos nos extremos. Em seguida  repete-se o procedimento com o subintervalo de interesse. Após um número finito de subdivisões ou encontramos uma solução ou sabemos que a raiz encontra-se em algum subintervalo [ak, bk].";
        imgPath1 = "assets/img/met_bissecao/metodo_bissecao.png";
        imgPath2 = "assets/img/met_bissecao/metodo_bissecao_table.png";
        imgPath3 = "assets/img/met_bissecao/metodo_bissecao_grafico.png";
        explicacao =
            "Se considerarmos k = 1 até 4, a = 0.75, b = 1, critério de parada 0.03 aplicando na função f(x) = x^2 + ln(x), ao aplicarmos estes dados na função da bisseção encontramos a tabela e o gráfico abaixo";
        break;
      case 2:
        title = "Método de Newton-Raphson";
        definicao =
            "O método de Newton, desenvolvido por Isaac Newton e Joseph Raphson, tem o objetivo de estimar as raízes de uma função. Para isso, escolhe-se uma aproximação inicial para esta";
        imgPath1 = "assets/img/met_bissecao/metodo_bissecao.png";
        imgPath2 = "assets/img/met_bissecao/metodo_bissecao_table.png";
        imgPath3 = "assets/img/met_bissecao/metodo_bissecao_grafico.png";
        explicacao = "";
        break;
      case 3:
        title = "Método da secante";
        definicao =
            "O método das secantes é um algoritmo de busca de raízes que usa uma sequência de raízes de linhas secantes para aproximar cada vez melhor a raiz de uma função f";
        imgPath1 = "assets/img/met_bissecao/metodo_bissecao.png";
        imgPath2 = "assets/img/met_bissecao/metodo_bissecao_table.png";
        imgPath3 = "assets/img/met_bissecao/metodo_bissecao_grafico.png";
        explicacao = "";
        break;
      case 4:
        title = "Método da falsa posição";
        definicao =
            "O método da posição falsa ou regula falsi é um método numérico usado para resolver equações lineares definidas em um intervalo [a, b], partindo do pressuposto de que haja uma solução em um subintervalo contido em [a, b";
        imgPath1 = "assets/img/met_bissecao/metodo_bissecao.png";
        imgPath2 = "assets/img/met_bissecao/metodo_bissecao_table.png";
        imgPath3 = "assets/img/met_bissecao/metodo_bissecao_grafico.png";
        explicacao = "";
        break;
      case 5:
        title = "Método do ponto fixo";
        definicao = "O método do ponto fixo é um método de se calcular pontos fixos de funções.";
        imgPath1 = "assets/img/met_bissecao/metodo_bissecao.png";
        imgPath2 = "assets/img/met_bissecao/metodo_bissecao_table.png";
        imgPath3 = "assets/img/met_bissecao/metodo_bissecao_grafico.png";
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
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Column(children: [
                    const Text(
                      "Gráfico",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeroPhotoViewRouteWrapper(
                              imageProvider: AssetImage(imgPath1),
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: "Gráfico1",
                        child: Image.asset(
                          imgPath1,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    )
                  ]),
                ),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeroPhotoViewRouteWrapper(
                              imageProvider: AssetImage(imgPath2),
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: "Tabela1",
                        child: Image.asset(
                          imgPath2,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  ]),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: Column(children: [
                    const Text(
                      "Gráfico",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeroPhotoViewRouteWrapper(
                              imageProvider: AssetImage(imgPath3),
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: "Gráfico3",
                        child: Image.asset(
                          imgPath3,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    )
                  ]),
                ),
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

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  const HeroPhotoViewRouteWrapper({
    super.key,
    required this.imageProvider,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
  });

  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        maxScale: maxScale,
        heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
      ),
    );
  }
}
