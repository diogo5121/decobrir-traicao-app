// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wizardry_gym_habits/Pages/Pergunta1.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(115, 56, 56, 56),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  AppBar(
                    backgroundColor: const Color.fromARGB(255, 248, 56, 56),
                    title: Row(
                      children: [
                        Text(
                          'DESCOBRIR TRAIÇÃO',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            width:
                                8), // Add some spacing between text and heart icon
                        Icon(
                          Icons
                              .favorite_border, // Use your preferred broken heart icon
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Image.asset(
                      'assets/imagem2.jpg',
                      width: 300,
                      height: 300,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Text(
                      'DESCUBRA SE VOCÊ ESTÁ SENDO TRAIDO(A) !',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Text(
                      '- Este aplicativo apresenta 10 perguntas rápidas destinadas a avaliar o potencial índice de infidelidade do seu parceiro(a). No entanto, é crucial destacar que os resultados gerados não asseguram a veracidade da traição. As avaliações são calculadas por meio de inteligência artificial, proporcionando um alto nível de precisão.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Readex Pro',
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Apagar();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Pergunta1()),
              );
            },
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 248, 46, 46),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Color(0x411D2429),
                    offset: Offset(0, 2),
                  )
                ],
                borderRadius: BorderRadius.circular(0),
              ),
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                      child: Text(
                        'REALIZAR TESTE !!',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Readex Pro',
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoaded)
            Container(
              width: double.infinity,
              height: _bannerAd?.size.height.toDouble() ?? 0,
              child: AdWidget(ad: _bannerAd!),
            ),
        ],
      ),
    );
  }

  void Apagar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
