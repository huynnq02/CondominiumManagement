import 'package:flutter/cupertino.dart';
import 'package:untitled/src/models/phone.dart';

class DataMultiChartProvider extends ChangeNotifier {
  double? batteryPositive;
  double? batteryNegative;
  double? batteryNeutral;
  double? cameraPositive;
  double? cameraNegative;
  double? cameraNeutral;
  double? designPositive;
  double? designNegative;
  double? designNeutral;
  double? featuresPositive;
  double? featuresNegative;
  double? featuresNeutral;
  double? generalPositive;
  double? generalNegative;
  double? generalNeutral;
  double? performancePositive;
  double? performanceNegative;
  double? performanceNeutral;
  double? pricePositive;
  double? priceNegative;
  double? priceNeutral;
  double? screenPositive;
  double? screenNegative;
  double? screenNeutral;
  double? storagePositive;
  double? storageNegative;
  double? storageNeutral;
  double? serAccPositive;
  double? serAccNegative;
  double? serAccNeutral;

  double statistical(String type, List<Phone> listPhone) {
    double rates = 0;
    listPhone.forEach((element) {
      final temp =
          element.review!.where((element) => element.label!.contains(type));
      rates += temp.length;
    });
    return rates;
  }

  void getList(List<Phone> listPhone) {
    List<String> hardware = [
      'BATTERY',
      'CAMERA',
      'DESIGN',
      'FEATURES',
      'GENERAL',
      'PERFORMANCE',
      'PRICE',
      'SCREEN',
      'STORAGE',
      'SER&ACC'
    ];

    List<String> rates = ['Positive', 'Negative', 'Neutral'];
    batteryPositive = statistical(hardware[0] + '#' + rates[0], listPhone);
    batteryNegative = statistical(hardware[0] + '#' + rates[1], listPhone);
    batteryNeutral = statistical(hardware[0] + '#' + rates[2], listPhone);

    cameraPositive = statistical(hardware[1] + '#' + rates[0], listPhone);
    cameraNegative = statistical(hardware[1] + '#' + rates[1], listPhone);
    cameraNeutral = statistical(hardware[1] + '#' + rates[2], listPhone);

    designPositive = statistical(hardware[2] + '#' + rates[0], listPhone);
    designNegative = statistical(hardware[2] + '#' + rates[1], listPhone);
    designNeutral = statistical(hardware[2] + '#' + rates[2], listPhone);

    featuresPositive = statistical(hardware[3] + '#' + rates[0], listPhone);
    featuresNegative = statistical(hardware[3] + '#' + rates[1], listPhone);
    featuresNeutral = statistical(hardware[3] + '#' + rates[2], listPhone);

    generalPositive = statistical(hardware[4] + '#' + rates[0], listPhone);
    generalNegative = statistical(hardware[4] + '#' + rates[1], listPhone);
    generalNeutral = statistical(hardware[4] + '#' + rates[2], listPhone);

    performancePositive = statistical(hardware[5] + '#' + rates[0], listPhone);
    performanceNegative = statistical(hardware[5] + '#' + rates[1], listPhone);
    performanceNeutral = statistical(hardware[5] + '#' + rates[2], listPhone);

    pricePositive = statistical(hardware[6] + '#' + rates[0], listPhone);
    priceNegative = statistical(hardware[6] + '#' + rates[1], listPhone);
    priceNeutral = statistical(hardware[6] + '#' + rates[2], listPhone);

    screenPositive = statistical(hardware[7] + '#' + rates[0], listPhone);
    screenNegative = statistical(hardware[7] + '#' + rates[1], listPhone);
    screenNeutral = statistical(hardware[7] + '#' + rates[2], listPhone);

    storagePositive = statistical(hardware[8] + '#' + rates[0], listPhone);
    storageNegative = statistical(hardware[8] + '#' + rates[1], listPhone);
    storageNeutral = statistical(hardware[8] + '#' + rates[2], listPhone);

    serAccPositive = statistical(hardware[9] + '#' + rates[0], listPhone);
    serAccNegative = statistical(hardware[9] + '#' + rates[1], listPhone);
    serAccNeutral = statistical(hardware[9] + '#' + rates[2], listPhone);
  }
}
