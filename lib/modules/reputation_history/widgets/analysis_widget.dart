import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:sof_app/utils/gap.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sof_app/utils/helper.dart';
import '../reputation_history_controller.dart';
import 'package:intl/intl.dart';

class AnalysisWidget extends GetView<ReputationHistoryController> {
  const AnalysisWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.repuHistoryChart.isEmpty) {
        return const Center(child: Text('No reputation history available'));
      }

      // Sort reputation history by date and calculate cumulative reputation
      final sortedHistory =
          controller.repuHistoryChart.toList()..sort(
            (a, b) => (a.creationDate ?? 0).compareTo(b.creationDate ?? 0),
          );

      int cumulativeReputation = 0;
      final chartData =
          sortedHistory.map((rep) {
            cumulativeReputation += rep.reputationChange ?? 0;
            return _ReputationData(
              date: DateTime.fromMillisecondsSinceEpoch(
                (rep.creationDate ?? 0) * 1000,
              ),
              reputation: cumulativeReputation,
            );
          }).toList();

      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reputation History',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(k20),
            SizedBox(
              height: 300,
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(
                  intervalType: DateTimeIntervalType.days,
                  interval: 1,
                  dateFormat: DateFormat('dd/MM'),
                  labelStyle: const TextStyle(fontSize: 10),
                  title: AxisTitle(
                    text: 'Date',
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  labelRotation: 45,
                  minimum: DateTime.now().subtract(const Duration(days: 7)),
                  maximum: DateTime.now(),
                ),
                primaryYAxis: NumericAxis(
                  labelStyle: const TextStyle(fontSize: 10),
                  title: AxisTitle(
                    alignment: ChartAlignment.center,
                    text: 'Reputation',
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  builder: (
                    dynamic data,
                    dynamic point,
                    dynamic series,
                    int pointIndex,
                    int seriesIndex,
                  ) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Text(
                        'Date: ${DateFormat('dd/MM/yyyy').format(data.date)}\nReputation: ${data.reputation}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
                series: <CartesianSeries>[
                  LineSeries<_ReputationData, DateTime>(
                    dataSource: chartData,
                    xValueMapper: (_ReputationData data, _) => data.date,
                    yValueMapper: (_ReputationData data, _) => data.reputation,
                    name: 'Reputation',
                    color: context.theme.primaryColor,
                    width: 2,
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 4,
                      width: 4,
                      borderWidth: 2,
                    ),
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      labelAlignment: ChartDataLabelAlignment.top,
                      labelPosition: ChartDataLabelPosition.outside,
                      angle: -45,
                      builder: (
                        dynamic data,
                        dynamic point,
                        dynamic series,
                        int pointIndex,
                        int seriesIndex,
                      ) {
                        return Text(
                          '${data.reputation}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            Gap(k20),
            Text(
              "Ideally, we should have filter options to select a custom date range.\nHowever, since the StackOverflow API doesn't support this, we're limited to showing data from the last 7 days up to now.",
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w400,
                color: context.theme.colorScheme.onSurface.withAlpha(150),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _ReputationData {
  _ReputationData({required this.date, required this.reputation});

  final DateTime date;
  final int reputation;
}
