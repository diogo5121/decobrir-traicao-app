import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wizardry_gym_habits/Pages/Pergunta10.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Pergunta9 extends StatefulWidget {
  const Pergunta9({Key? key}) : super(key: key);

  @override
  _Pergunta9State createState() => _Pergunta9State();
}

class _Pergunta9State extends State<Pergunta9> {
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
        title: Text('Pergunta 9'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Pergunta 9/10'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                value: 0.9,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            ),
            Text(
              'Seu parceiro(a) tem tido reações emocionais incomuns, como culpa excessiva ou irritação repentina?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile<int>(
                  activeColor: Colors.redAccent,
                  title: Text('Não percebi mudanças emocionais'),
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
                  title: Text('Leves alterações emocionais'),
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
                  title: Text('Algumas reações incomuns'),
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
                  title: Text('Reações emocionais frequentes'),
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
                  title: Text('Mudanças emocionais extremas'),
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
                  print(respostaSelecionada);
                  Salvar();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Pergunta10()),
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
    prefs.setString("Pergunta9", respostaSelecionada.toString());
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pergunta9(),
    );
  }
}
