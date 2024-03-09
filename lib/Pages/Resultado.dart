import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wizardry_gym_habits/main.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Resultado extends StatefulWidget {
  const Resultado({super.key});

  @override
  State<Resultado> createState() => _ResultadoState();
}

class _ResultadoState extends State<Resultado> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;

  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  var porcentagem = 0.0;
  var corPorcentagem = Colors.white;
  var descricao = '';

  @override
  void initState() {
    super.initState();
    calcularPorcentagem();
    loadAd();
  }

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-6470450114920643/9289379618',
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('BannerAd failed to load: $error');
          ad.dispose();
        },
      ),
    )..load();

    InterstitialAd.load(
        adUnitId: 'ca-app-pub-6470450114920643/8554403517',
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});
            debugPrint('$ad loaded.');
            _interstitialAd = ad;

            setState(() {
              _isInterstitialAdLoaded = true;
            });
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void mostrar() {
    if (_isInterstitialAdLoaded) {
      if (_interstitialAd == null) {
      } else {
        _interstitialAd?.show();
        setState(() {
          _isInterstitialAdLoaded = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mostrar();
    return Scaffold(
      backgroundColor: const Color.fromARGB(115, 56, 56, 56),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8, // Ajuste conforme necessário
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'RESULTADO DO SEU TESTE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'O índice de infidelidade do seu companheiro ficou em:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Readex Pro',
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${porcentagem.toStringAsFixed(2)}%',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: corPorcentagem,
                    fontFamily: 'Readex Pro',
                    fontSize: 50,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '${descricao}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: corPorcentagem,
                    fontFamily: 'Readex Pro',
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),

                      (route) => false, // Remove todas as rotas anteriores
                    );
                  },
                  child: Text('REFAZER TESTE!',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
                SizedBox(height: 40),
                if (_isLoaded)
                  Container(
                    width: double.infinity,
                    height: _bannerAd?.size.height.toDouble() ?? 0,
                    child: AdWidget(ad: _bannerAd!),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calcularPorcentagem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var pergunta1 = int.parse(prefs.getString('Pergunta1') ?? '1');
    var pergunta2 = int.parse(prefs.getString('Pergunta2') ?? '1');
    var pergunta3 = int.parse(prefs.getString('Pergunta3') ?? '1');
    var pergunta4 = int.parse(prefs.getString('Pergunta4') ?? '1');
    var pergunta5 = int.parse(prefs.getString('Pergunta5') ?? '1');
    var pergunta6 = int.parse(prefs.getString('Pergunta6') ?? '1');
    var pergunta7 = int.parse(prefs.getString('Pergunta7') ?? '1');
    var pergunta8 = int.parse(prefs.getString('Pergunta8') ?? '1');
    var pergunta9 = int.parse(prefs.getString('Pergunta9') ?? '1');
    var pergunta10 = int.parse(prefs.getString('Pergunta10') ?? '1');

    // Calcula a média
    var media = (pergunta1 +
            pergunta2 +
            pergunta3 +
            pergunta4 +
            pergunta5 +
            pergunta6 +
            pergunta7 +
            pergunta8 +
            pergunta9 +
            pergunta10 -
            10) /
        10;

    // Calcula a porcentagem
    porcentagem = (media / 4) * 100;

    if (porcentagem <= 30) {
      corPorcentagem = Colors.green;
      descricao = 'Está dentro da média';
    } else if (30 < porcentagem && porcentagem <= 70) {
      corPorcentagem = Colors.orange;
      descricao = 'A infidelidade do seu parceiro está acima da média';
    } else if (porcentagem >= 70) {
      corPorcentagem = Colors.red;
      descricao =
          'Seu parceiro(a) exibe fortes características de infidelidade';
    }
    setState(() {
      // Atualiza o estado para refletir a mudança na interface do usuário
    });
  }
}
