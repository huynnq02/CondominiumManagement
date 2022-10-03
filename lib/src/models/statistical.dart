import 'dart:convert';

import 'package:untitled/src/models/aspects_score.dart';

class Statistical {
  String? overallScore;
  String? labelScore;
  String? totalNegative;
  String? totalNeutral;
  String? totalPositive;
  AspectsScore? aspectsScore;
  Statistical({
    this.overallScore,
    this.labelScore,
    this.totalNegative,
    this.totalNeutral,
    this.totalPositive,
    this.aspectsScore,
  });

  Map<String, dynamic> toMap() {
    return {
      'overallScore': overallScore,
      'labelScore': labelScore,
      'totalNegative': totalNegative,
      'totalNeutral': totalNeutral,
      'totalPositive': totalPositive,
      'aspectsScore': aspectsScore?.toMap(),
    };
  }

  factory Statistical.fromMap(Map<String, dynamic> map) {
    return Statistical(
      overallScore: map['overallScore'],
      labelScore: map['labelScore'],
      totalNegative: map['totalNegative'],
      totalNeutral: map['totalNeutral'],
      totalPositive: map['totalPositive'],
      aspectsScore: map['aspectsScore'] != null
          ? AspectsScore.fromMap(map['aspectsScore'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Statistical.fromJson(String source) =>
      Statistical.fromMap(json.decode(source));
}
