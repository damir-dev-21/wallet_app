import 'dart:ui';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_app/models/Chart.dart';
import 'package:wallet_app/models/ChartOverview.dart';
import 'package:wallet_app/services/database_helper.dart';

DatabaseHelper db = DatabaseHelper();

class ChartController extends GetxController {
  RxList<Chart> chartsCharge = RxList<Chart>([]);
  RxList<Chart> _chartsProfit = RxList<Chart>([]);
  RxList<ChartOverview> _chartsOverview = RxList<ChartOverview>([]);
  RxList<ChartOverview> _chartsOverviewExchange = RxList<ChartOverview>([]);

  @override
  void onInit() {
    String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
    getCharts(dateNow);
    getChartsProfit(dateNow);
    super.onInit();
  }

  List<Chart> get charts {
    return [...chartsCharge];
  }

  List<ChartOverview> get chartsOverview {
    return [..._chartsOverview];
  }

  List<ChartOverview> get chartsOverviewExchange {
    return [..._chartsOverviewExchange];
  }

  List<Chart> get chartsProfit {
    return [..._chartsProfit];
  }

  // void setItems(items) async {
  //   Future.forEach(
  //       items,
  //       (element) => _charts
  //           .removeWhere((el){if(element.titleCategory != null){return el.titleCategory == element.titleCategory}}));
  // }

  void addItem(Chart item) {
    chartsCharge.add(item);
    update();
  }

  Future<void> getCharts(String date) async {
    String dateYes = DateFormat('d MMMM yyyy')
        .format(DateTime.now().subtract(Duration(days: 1)));
    String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
    final db = await DatabaseHelper().fetchCharts(date);
    chartsCharge.clear();
    chartsOverview.clear();
    if (db.isNotEmpty) {
      db.forEach((element) {
        print(element);
        // chartsCharge
        //     .removeWhere((e) => e.titleCategory == element.titleCategory);
        int value = int.parse(element.colorCategory.toString(), radix: 16);
        addChart(Chart(element.titleCategory, element.date, element.value,
            element.colorCategory));
      });
    }
    update();
  }

  Future<void> getChartsProfit(String date) async {
    String dateYes = DateFormat('d MMMM yyyy')
        .format(DateTime.now().subtract(Duration(days: 1)));
    String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
    final db = await DatabaseHelper().fetchChartsProfit();
    chartsProfit.clear();
    chartsOverviewExchange.clear();
    if (db.isNotEmpty) {
      db.forEach((element) {
        // chartsCharge
        //     .removeWhere((e) => e.titleCategory == element.titleCategory);
        int value = int.parse(element.colorCategory.toString(), radix: 16);
        addChartProfit(Chart(element.titleCategory, element.date, element.value,
            element.colorCategory));
      });
    }
    update();
  }

  void addChart(Chart chart) async {
    Database db = await DatabaseHelper().db;
    String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
    var item = chartsCharge.firstWhere(
        (e) => e.titleCategory == chart.titleCategory,
        orElse: () => Chart('', chart.date, 0, chart.colorCategory));

    if (item.titleCategory == '') {
      chartsCharge.add(chart);
      await db.insert('chart', chart.toMap());
    } else {
      item.value += chart.value;
      await db.rawUpdate('UPDATE chart SET value = ? WHERE titleCategory = ?',
          [chart.value, chart.titleCategory]);
    }

    update();
  }

  void addChartOverview(ChartOverview chart) {
    _chartsOverview.add(chart);
  }

  void addChartOverviewExchange(ChartOverview chart) {
    _chartsOverviewExchange.add(chart);
  }

  void addChartProfit(Chart chart) async {
    String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
    Database db = await DatabaseHelper().db;
    var item = _chartsProfit.firstWhere(
        (e) => e.titleCategory == chart.titleCategory,
        orElse: () => Chart('', dateNow, 0, chart.colorCategory));

    if (item.titleCategory == '') {
      _chartsProfit.add(chart);
      await db.insert('chartProfit', chart.toMap());
    } else {
      item.value += chart.value;
      await db.rawUpdate(
          'UPDATE chartProfit SET value = ? WHERE titleCategory = ?',
          [chart.value, chart.titleCategory]);
    }

    update();
  }
}
