import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:zeromath/ad_state.dart';

class ZeroDetails extends StatefulWidget {
  const ZeroDetails({super.key});

  @override
  State<ZeroDetails> createState() => _ZeroDetails();
}

class _ZeroDetails extends State<ZeroDetails> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Zero de Funções"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Zero de Funções",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "v1.0.2",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ]),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24, right: 8),
              child: Text(
                "Zero de uma função, também chamado de raiz, é todo valor da variável independente x que tem por  imagem o valor 0",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Como obter as raízes de uma equação?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 24, right: 8),
              child: Text(
                "Métodos numéricos iterativos são utilizados para aproximar a solução de x. Nesses métodos é dada uma solução inicial e a partir dela calculamos diversas vezes até que encontramos a solução correta. \nObter uma raiz pode ser dividido em dois passos:",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Image.asset(
              "assets/img/zero_details/primeiro.png",
              scale: 3,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Image.asset(
                "assets/img/zero_details/analise.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Image.asset(
              "assets/img/zero_details/segundo.png",
              scale: 3,
              fit: BoxFit.fitWidth,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Image.asset(
                "assets/img/zero_details/refinamento.png",
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 60,
              child: AdWidget(ad: banner),
            ),
          ],
        ),
      ),
    );
  }
}
