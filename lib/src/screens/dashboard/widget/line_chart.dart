import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:untitled/utils/app_constant/app_colors.dart';
import 'package:untitled/utils/app_constant/app_text_style.dart';

class LineChart extends StatefulWidget {
  LineChart({Key? key}) : super(key: key);

  @override
  State<LineChart> createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('15/3', 7.7),
      ChartData('16/3', 6.3),
      ChartData('17/3', 8.0),
      ChartData('18/3', 5.0),
      ChartData('19/3', 8.3),
      ChartData('20/3', 6.5),
      ChartData('21/3', 7.0),
    ];

    return Center(
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              Container(
                  height: 300,
                  width: 700,
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries>[
                        LineSeries<ChartData, String>(
                            markerSettings: const MarkerSettings(
                              width: 10,
                              height: 10,
                              color: AppColors.Blue,
                              isVisible: true,
                            ),
                            pointColorMapper: (datum, index) => AppColors.Blue,
                            color: AppColors.Blue,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                margin: const EdgeInsets.all(10),
                                showCumulativeValues: true,
                                color: AppColors.Blue,
                                textStyle: AppTextStyle.nunitoBoldSize14
                                    .copyWith(
                                        color: AppColors.White, fontSize: 12)),
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y)
                      ]))
            ])));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}
