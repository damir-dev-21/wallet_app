import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wallet_app/constants/categories.dart';
import 'package:wallet_app/controllers/ChartController.dart';
import 'package:wallet_app/controllers/OperationsController.dart';
import 'package:wallet_app/models/Chart.dart';
import 'package:wallet_app/models/ChartOverview.dart';

class OverviewExpensesScreen extends StatelessWidget {
  Map<String, dynamic> getCategory(id) {
    final item = categories.firstWhere((element) => element.id == id);

    return {
      'title': item.title,
      'icon': item.icon,
      'color': item.color,
    };
  }

  @override
  Widget build(BuildContext context) {
    final chartData = Get.put(ChartController());
    final operationController = Get.put(OperationsController());
    return Scaffold(
        body: Column(
      children: [
        GetBuilder<ChartController>(
            init: ChartController(),
            builder: (context) {
              return Container(
                  height: 300,
                  child: SfCartesianChart(primaryXAxis: CategoryAxis(),
                      // Columns will be rendered back to back
                      series: <ChartSeries>[
                        ColumnSeries<Chart, String>(
                            color: Colors.white,
                            borderColor: Colors.white,
                            dataSource: chartData.chartsCharge,
                            pointColorMapper: (Chart data, _) =>
                                Color(data.colorCategory),
                            xValueMapper: (Chart sales, _) =>
                                sales.titleCategory,
                            yValueMapper: (Chart sales, _) => sales.value),
                      ]));
            }),
        Expanded(
          child: GetBuilder<OperationsController>(
              init: OperationsController(),
              builder: (ctx) {
                return ListView.builder(
                    itemCount: operationController.operationsList.length,
                    itemBuilder: (ctx, index) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 0),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              for (var i in operationController
                                  .operationsList[index].operations)
                                Container(
                                  //color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Color(getCategory(
                                                    i.categoryId)['color'])),
                                            child: getCategory(
                                                i.categoryId)['icon'],
                                          ),
                                          Container(
                                            child: Center(
                                              child: Text(
                                                getCategory(
                                                    i.categoryId)['title'],
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              child: Text(
                                            '-' + i.expense.toString(),
                                            style: TextStyle(
                                                color: Colors.redAccent),
                                          )),
                                        ],
                                      ),
                                      Divider()
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ));
              }),
        ),
      ],
    ));
  }
}
