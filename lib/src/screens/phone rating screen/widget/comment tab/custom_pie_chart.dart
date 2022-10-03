// ignore_for_file: unused_field, prefer_final_fields, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

import '../../../../models/phone.dart';
import '../../../../models/statistical.dart';

class CustomPieChart extends StatefulWidget {
  Phone phone;
  CustomPieChart({Key? key, required this.phone}) : super(key: key);

  @override
  _CustomPieChartState createState() => _CustomPieChartState();
}

enum LegendShape { Circle, Rectangle }

class _CustomPieChartState extends State<CustomPieChart> {
  final colorList = <Color>[
    AppColors.Green,
    AppColors.Yellow,
    AppColors.Red,
  ];

  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;

  bool _showChartValueBackground = false;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.Circle;
  LegendPosition? _legendPosition = LegendPosition.right;
  var dataMap;
  int key = 0;
  //set dữ liệu vào biểu đồ
  dataChart(Statistical? statistical) {
    dataMap = <String, double>{
      "Tốt": statistical!.totalPositive != null
          ? double.parse(statistical.totalPositive.toString())
          : 0,
      "Bình thường": statistical.totalNeutral != null
          ? double.parse(statistical.totalNeutral.toString())
          : 0,
      "không tốt": statistical.totalNegative != null
          ? double.parse(statistical.totalNegative.toString())
          : 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    dataChart(widget.phone.statistical!);
    return PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing!,
      chartRadius: 221,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType!,
      centerText: null,
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition!,
        showLegends: _showLegends,
        legendShape: _legendShape == LegendShape.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        decimalPlaces: 0,
        chartValueStyle: AppTextStyle.nunitoBoldSize14.copyWith(
          color: AppColors.White,
          fontSize: 20,
        ),
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth!,
      emptyColor: Colors.grey,
    );
  }
}
