import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wizardry_gym_habits/Pages/Pergunta6.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Pergunta5 extends StatefulWidget {
  const Pergunta5({Key? key}) : super(key: key);

  @override
  _Pergunta5State createState() => _Pergunta5State();
}

class _Pergunta5State extends State<Pergunta5> {
  int? respostaSelecionada;

  BannerAd? _bannerAd;
  bool _isLoaded = false;

  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdLoaded = false;

  @override
  void initState() {
    super.initState();
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
      _interstitialAd?.show();
      setState(() {
        _isInterstitialAdLoaded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta 5'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Pergunta 5/10'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            ),
            Text(
              'Seu parceiro(a) tem agido defensivamente quando questionado sobre o relacionamento?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile<int>(
                  title: Text('Não, responde abertamente'),
                  activeColor: Colors.redAccent,
                  value: 1,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text('Às vezes'),
                  activeColor: Colors.redAccent,
                  value: 2,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text('Em certas situações'),
                  activeColor: Colors.redAccent,
                  value: 3,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text('Frequentemente'),
                  activeColor: Colors.redAccent,
                  value: 4,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  title: Text('Sempre fica na defensiva'),
                  activeColor: Colors.redAccent,
                  value: 5,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                mostrar();
                if (respostaSelecionada != null) {
                  Salvar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pergunta6()),
                  );
                }
              },
              child: Text('Próxima pergunta',
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
    );
  }

  void Salvar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Pergunta5", respostaSelecionada.toString());
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pergunta5(),
    );
  }
}
