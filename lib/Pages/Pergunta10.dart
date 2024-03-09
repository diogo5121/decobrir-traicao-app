import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wizardry_gym_habits/Pages/Resultado.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Pergunta10 extends StatefulWidget {
  const Pergunta10({Key? key}) : super(key: key);

  @override
  _Pergunta10State createState() => _Pergunta10State();
}

class _Pergunta10State extends State<Pergunta10> {
  int? respostaSelecionada;

  BannerAd? _bannerAd;
  bool _isLoaded = false;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta 10'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Pergunta 10/10'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                value: 0.95,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            ),
            Text(
              'Você já teve a sensação de que seu parceiro(a) está escondendo algo importante de você?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile<int>(
                  activeColor: Colors.redAccent,
                  title: Text('Nunca tive essa sensação'),
                  value: 1,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  activeColor: Colors.redAccent,
                  title: Text('Raramente sinto isso'),
                  value: 2,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  activeColor: Colors.redAccent,
                  title: Text('Às vezes tenho essa sensação'),
                  value: 3,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  activeColor: Colors.redAccent,
                  title: Text('Frequentemente sinto isso'),
                  value: 4,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
                RadioListTile<int>(
                  activeColor: Colors.redAccent,
                  title: Text('Sempre sinto que algo está sendo escondido'),
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
                if (respostaSelecionada != null) {
                  print('clicou, proxima pergunta');
                  Salvar();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Resultado()),
                    (route) => false, // Remove todas as rotas anteriores
                  );
                }
              },
              child: Text('Obter resultado !',
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
    prefs.setString("Pergunta10", respostaSelecionada.toString());
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pergunta10(),
    );
  }
}
