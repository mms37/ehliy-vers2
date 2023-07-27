import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(EhliyetSorulariUygulamasi());
}

class EhliyetSorulariUygulamasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SoruSayfasi(),
    );
  }
}

class Soru {
  final String soruMetni;
  final List<String?> secenekler;
  final String dogruCevap;

  Soru({required this.soruMetni, required this.secenekler, required this.dogruCevap});
}

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

class _SoruSayfasiState extends State<SoruSayfasi> {
  List<Soru> tumSorular = [
    Soru(
      soruMetni: "Kırmızı ışıkta durmak zorunlu mudur?",
      secenekler: ["A) Evet", "B) Hayır"],
      dogruCevap: "A) Evet",
    ),
    Soru(
      soruMetni: "Taşıt yolunda yaya olarak yürümek doğru mudur?",
      secenekler: ["A) Evet", "B) Hayır"],
      dogruCevap: "B) Hayır",
    ),
    Soru(
      soruMetni: "Öndeki aracı sollarken nelere dikkat etmelisiniz?",
      secenekler: ["A) Sollama şeridi olmalı", "B) Korna çalmalı", "C) Fazla hızlı olmalı"],
      dogruCevap: "A) Sollama şeridi olmalı",
    ),
    Soru(
      soruMetni: "Emniyet kemeri, koltuğa nasıl takılır?",
      secenekler: ["A) Takmaya gerek yok", "B) Sol omuz ve beli kapsayacak şekilde takılır"],
      dogruCevap: "B) Sol omuz ve beli kapsayacak şekilde takılır",
    ),
    Soru(
      soruMetni: "Sürücü belgesi alabilmek için kaç yaşını doldurmalısınız?",
      secenekler: ["A) 17", "B) 18", "C) 19", "D) 20"],
      dogruCevap: "B) 18",
    ),
    Soru(
      soruMetni: "Geceleri park halindeyken hangi ışıkları açık bırakmalısınız?",
      secenekler: ["A) Sis lambaları", "B) Park lambaları", "C) Dönüş sinyalleri"],
      dogruCevap: "B) Park lambaları",
    ),
    Soru(
      soruMetni: "Araç lastiklerinin nasıl olması gerekir?",
      secenekler: ["A) İlk sahibi tarafından alınmış", "B) Yırtık ve düzensiz desenli olmalı", "C) Düşük lastik basıncına sahip olmalı"],
      dogruCevap: "B) Yırtık ve düzensiz desenli olmalı",
    ),
    Soru(
      soruMetni: "Araçlar arasında en yavaş hareket eden hangisidir?",
      secenekler: ["A) Bisiklet", "B) Motorsiklet", "C) Otomobil", "D) Kamyonet"],
      dogruCevap: "A) Bisiklet",
    ),
    Soru(
      soruMetni: "Aracınızla giderken trafik polisi çevirmesi yapıldı, hangi durumda durmazsınız?",
      secenekler: ["A) Trafik polisinin el işareti yaptığı durumda", "B) Trafik polisi uyarıda bulunmadan", "C) Trafik ışıklarının yanıp sönmediği durumda"],
      dogruCevap: "C) Trafik ışıklarının yanıp sönmediği durumda",
    ),
    Soru(
      soruMetni: "Kanunen araçların kullandığı bölümler nelerdir?",
      secenekler: ["A) Kaldırım", "B) Yol", "C) Kavşak", "D) Yaya yolu"],
      dogruCevap: "B) Yol",
    ),
  ];

  List<Soru> testSorulari = [];
  int soruIndex = 0;
  bool cevaplandi = false;
  String? secilenCevap;
  int dogruSayisi = 0;

  void testSorulariniAyarla() {
    // Soruları karıştırmak için liste indekslerini oluşturuyoruz
    List<int> indeksler = List.generate(tumSorular.length, (index) => index);
    indeksler.shuffle();

    // İlk 5 rastgele soruyu testSorulari listesine ekliyoruz
    for (int i = 0; i < 5; i++) {
      testSorulari.add(tumSorular[indeksler[i]]);
    }
  }

  @override
  void initState() {
    super.initState();
    testSorulariniAyarla();
  }

  void ileriGit() {
    if (soruIndex < testSorulari.length - 1) {
      setState(() {
        soruIndex++;
        cevaplandi = false;
        secilenCevap = null;
      });
    } else {
      // Tüm sorular çözüldü, sonucu göster
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SonucDialog(
            dogruSayisi: dogruSayisi,
            toplamSoru: testSorulari.length,
            onPressedYenidenBasla: () {
              // Yeni bir test için sayfayı yeniden başlat ve soruları tekrar karıştır
              setState(() {
                soruIndex = 0;
                cevaplandi = false;
                secilenCevap = null;
                dogruSayisi = 0;
                testSorulari.clear();
                testSorulariniAyarla();
              });
              Navigator.pop(context); // Sonuç ekranını kapat
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ehliyet Sınavı"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Soru ${soruIndex + 1}/${testSorulari.length}",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  testSorulari[soruIndex].soruMetni,
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  itemCount: testSorulari[soruIndex].secenekler.length,
                  itemBuilder: (context, index) {
                    String cevap = testSorulari[soruIndex].secenekler[index]!;
                    bool isDogruCevap = (cevap == testSorulari[soruIndex].dogruCevap);
                    bool isSecilenCevap = (cevap == secilenCevap);

                    return GestureDetector(
                      onTap: () {
                        if (!cevaplandi) {
                          setState(() {
                            cevaplandi = true;
                            secilenCevap = cevap;
                            if (secilenCevap == testSorulari[soruIndex].dogruCevap) {
                              dogruSayisi++;
                            }
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        decoration: BoxDecoration(
                          color: isSecilenCevap
                              ? (isDogruCevap ? Colors.green : Colors.red)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: isSecilenCevap ? Colors.transparent : Colors.grey.withOpacity(0.5),
                            width: 2.0,
                          ),
                        ),
                        child: Text(
                          cevap,
                          style: TextStyle(
                            color: isSecilenCevap ? Colors.white : Colors.black,
                            fontWeight: isSecilenCevap ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (cevaplandi) {
                    ileriGit();
                  }
                },
                child: Text("Geç"),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return YenidenBaslaDialog(
                        onPressedYenidenBasla: () {
                          // Yeni bir test için sayfayı yeniden başlat ve soruları tekrar karıştır
                          setState(() {
                            soruIndex = 0;
                            cevaplandi = false;
                            secilenCevap = null;
                            dogruSayisi = 0;
                            testSorulari.clear();
                            testSorulariniAyarla();
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
                child: Text("Yeniden Başla"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SonucDialog extends StatelessWidget {
  final int dogruSayisi;
  final int toplamSoru;
  final VoidCallback onPressedYenidenBasla;

  SonucDialog({required this.dogruSayisi, required this.toplamSoru, required this.onPressedYenidenBasla});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Sonuç"),
      content: Text("Tebrikler! ${dogruSayisi}/${toplamSoru} doğru cevapladınız."),
      actions: [
        ElevatedButton(
          onPressed: onPressedYenidenBasla,
          child: Text("Yeniden Başla"),
        ),
      ],
    );
  }
}

class YenidenBaslaDialog extends StatelessWidget {
  final VoidCallback onPressedYenidenBasla;

  YenidenBaslaDialog({required this.onPressedYenidenBasla});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Yeniden Başla"),
      content: Text("Yeni bir test başlatmak istediğinize emin misiniz?"),
      actions: [
        ElevatedButton(
          onPressed: onPressedYenidenBasla,
          child: Text("Evet"),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Hayır"),
        ),
      ],
    );
  }
}
