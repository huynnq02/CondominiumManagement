import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled/src/models/phone.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';

import '../../../providers/data_multi_chart.dart';

class MultiColumnChart extends StatelessWidget {
  List<Phone> listPhone;
  MultiColumnChart({Key? key, required this.listPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late DataMultiChartProvider provider;
    provider = Provider.of<DataMultiChartProvider>(context, listen: false);
    provider.getList(listPhone);
    final List<ChartData> chartData = <ChartData>[
      ChartData(
        'Màn hình',
        provider.screenPositive,
        provider.screenNegative,
        provider.screenNeutral,
      ),
      ChartData(
        'Pin',
        provider.batteryPositive,
        provider.batteryPositive,
        provider.batteryNeutral,
      ),
      ChartData(
        'Camera',
        provider.cameraPositive,
        provider.cameraNegative,
        provider.cameraNeutral,
      ),
      ChartData(
        'Tính năng',
        provider.featuresPositive,
        provider.featuresNegative,
        provider.featuresNeutral,
      ),
      ChartData(
        'Bộ nhớ',
        provider.storagePositive,
        provider.storageNegative,
        provider.storageNeutral,
      ),
      ChartData(
        'Hiệu suất',
        provider.performancePositive,
        provider.performanceNegative,
        provider.performanceNegative,
      ),
      ChartData(
        'Thiết kế',
        provider.designPositive,
        provider.designNegative,
        provider.designNeutral,
      ),
      ChartData(
        'Giá cả',
        provider.pricePositive,
        provider.priceNegative,
        provider.priceNeutral,
      ),
    ];
    return Center(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              Container(
                  width: 700,
                  height: 300,
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries>[
                        ColumnSeries<ChartData, String>(
                            color: AppColors.Green,
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y),
                        ColumnSeries<ChartData, String>(
                            color: AppColors.Red,
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y1),
                        ColumnSeries<ChartData, String>(
                            color: AppColors.LightBlue,
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y2)
                      ]))
            ])));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);
  final String x;
  final double? y;
  final double? y1;
  final double? y2;
}
