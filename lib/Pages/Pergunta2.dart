import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wizardry_gym_habits/Pages/Pergunta3.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Pergunta2 extends StatefulWidget {
  const Pergunta2({Key? key}) : super(key: key);

  @override
  _Pergunta2State createState() => _Pergunta2State();
}

class _Pergunta2State extends State<Pergunta2> {
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
        title: Text('Pergunta 2'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Pergunta 2/10'),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                value: 0.2,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
              ),
            ),
            Text(
              'Com que frequência seu parceiro(a) tem estado ausente sem explicação?',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile<int>(
                  title: Text('Raramente'),
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
                  title: Text('Ocasionalmente'),
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
                  title: Text('Regularmente'),
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
                  title: Text('Constantemente'),
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
                  if (respostaSelecionada != null) {
                    print('clicou, proxima pergunta');
                    Salvar();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Pergunta3()),
                    );
                  }
                },
                child: Text(
                  'Próxima pergunta',
                  style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold, fontSize: 20),
                )),
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
    prefs.setString("Pergunta2", respostaSelecionada.toString());
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pergunta2(),
    );
  }
}
