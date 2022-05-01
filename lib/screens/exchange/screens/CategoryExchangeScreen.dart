import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wallet_app/controllers/ChartController.dart';
import 'package:wallet_app/controllers/OperationsController.dart';
import 'package:wallet_app/models/Chart.dart';
import 'package:wallet_app/widgets/CategoryItem.dart';
import 'package:wallet_app/widgets/CategoryItemExchange.dart';

class CategoriesExchangeScreen extends StatefulWidget {
  @override
  _CategoriesExchangeScreenState createState() =>
      _CategoriesExchangeScreenState();
}

class _CategoriesExchangeScreenState extends State<CategoriesExchangeScreen> {
  final chartController = Get.put(ChartController());
  final operationsController = Get.put(OperationsController());
  String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CategoryItemExchange(
              'Зарплата', int.parse("0xFF0496FF"), Icons.money_rounded, 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder<ChartController>(
                init: ChartController(),
                builder: (_) => Container(
                  width: 230,
                  height: 230,
                  child: SfCircularChart(
                    annotations: <CircularChartAnnotation>[
                      CircularChartAnnotation(
                          widget: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: const Text('Приход',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18))),
                          GetBuilder<OperationsController>(
                              init: OperationsController(),
                              builder: (_) => Container(
                                  child: Text(
                                      operationsController.totalExchange
                                              .toString() +
                                          ' UZS',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20)))),
                        ],
                      )),
                    ],
                    series: [
                      DoughnutSeries<Chart, String>(
                          emptyPointSettings: EmptyPointSettings(
                              color: Colors.black,
                              borderWidth: 10,
                              mode: EmptyPointMode.gap,
                              borderColor: Colors.black),
                          dataSource: chartController.chartsProfit.length == 0
                              ? [
                                  Chart('zero', dateNow, 100,
                                      int.parse("0xFFFF5252"))
                                ]
                              : chartController.chartsProfit,
                          pointColorMapper: (Chart data, _) =>
                              Color(data.colorCategory),
                          xValueMapper: (Chart data, _) => data.titleCategory,
                          yValueMapper: (Chart data, _) => data.value,
                          innerRadius: '85%'),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
