import 'dart:convert';

class AspectsScore {
  double? bATTERY;
  double? cAMERA;
  double? dESIGN;
  double? fEATURES;
  double? gENERAL;
  double? pERFORMANCE;
  double? pRICE;
  double? sCREEN;
  double? sTORAGE;
  AspectsScore({
    this.bATTERY,
    this.cAMERA,
    this.dESIGN,
    this.fEATURES,
    this.gENERAL,
    this.pERFORMANCE,
    this.pRICE,
    this.sCREEN,
    this.sTORAGE,
  });

  Map<String, dynamic> toMap() {
    return {
      'battery': bATTERY,
      'camera': cAMERA,
      'design': dESIGN,
      'features': fEATURES,
      'general': gENERAL,
      'performance': pERFORMANCE,
      'price': pRICE,
      'screen': sCREEN,
      'storage': sTORAGE,
    };
  }

  factory AspectsScore.fromMap(Map<String, dynamic> map) {
    return AspectsScore(
      bATTERY: map['battery']?.toDouble(),
      cAMERA: map['camera']?.toDouble(),
      dESIGN: map['design']?.toDouble(),
      fEATURES: map['features']?.toDouble(),
      gENERAL: map['general']?.toDouble(),
      pERFORMANCE: map['performance']?.toDouble(),
      pRICE: map['price']?.toDouble(),
      sCREEN: map['screen']?.toDouble(),
      sTORAGE: map['storage']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory AspectsScore.fromJson(String source) =>
      AspectsScore.fromMap(json.decode(source));
}
