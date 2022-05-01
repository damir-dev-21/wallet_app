import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wallet_app/controllers/ChartController.dart';
import 'package:wallet_app/controllers/OperationsController.dart';
import 'package:wallet_app/models/Chart.dart';
import 'package:wallet_app/widgets/CategoryItem.dart';

class CategoriesExpensesScreen extends StatefulWidget {
  @override
  _CategoriesExpensesScreenState createState() =>
      _CategoriesExpensesScreenState();
}

class _CategoriesExpensesScreenState extends State<CategoriesExpensesScreen> {
  final chartController = Get.put(ChartController());
  final operationsController = Get.put(OperationsController());
  String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    var total = operationsController.total.toString();

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CategoryItem('Продукты', int.parse("0xFF0496FF"),
                  Icons.shopping_basket, 4),
              CategoryItem(
                  'Транспорт', int.parse("0xFFFFD500"), Icons.local_taxi, 1),
              CategoryItem(
                  'Общепит', int.parse("0xFF003F88"), Icons.restaurant, 2),
              CategoryItem(
                  'Досуг', int.parse("0xFF2EC4B6"), Icons.headset_mic, 3),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CategoryItem(
                      'Здоровье', int.parse("0xFF0EAD69"), Icons.spa, 5),
                  CategoryItem('Семья', int.parse("0xFFFF99C8"), Icons.face, 6),
                ],
              ),
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
                              child: const Text('Расходы',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18))),
                          GetBuilder<OperationsController>(
                              init: OperationsController(),
                              builder: (_) => Column(
                                    children: [
                                      Container(
                                          child: Text(
                                              operationsController.total
                                                      .toString() +
                                                  ' UZS',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20))),
                                      Container(
                                          margin: EdgeInsets.only(top: 3),
                                          child: Text(
                                              operationsController.total == 0
                                                  ? '0 UZS'
                                                  : (operationsController
                                                                  .totalExchange -
                                                              operationsController
                                                                  .total)
                                                          .toString() +
                                                      ' UZS',
                                              style: TextStyle(
                                                  color: Colors.redAccent,
                                                  fontSize: 20))),
                                    ],
                                  )),
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
                          dataSource: chartController.chartsCharge.length == 0
                              ? [
                                  Chart('zero', dateNow, 100,
                                      int.parse("0xFFFF5252"))
                                ]
                              : chartController.chartsCharge,
                          pointColorMapper: (Chart data, _) =>
                              Color(data.colorCategory),
                          xValueMapper: (Chart data, _) => data.titleCategory,
                          yValueMapper: (Chart data, _) => data.value,
                          innerRadius: '85%'),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  CategoryItem(
                      'Подарки', int.parse("0xFFFF99C8"), Icons.gif, 7),
                  CategoryItem('Покупки', int.parse("0xFF495867"),
                      Icons.shopping_bag, 8),
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
