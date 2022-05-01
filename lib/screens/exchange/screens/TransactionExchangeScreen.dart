import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/constants/categories.dart';
import 'package:wallet_app/controllers/OperationsController.dart';

class TransactionsExchangeScreen extends StatelessWidget {
  final operationController = Get.put(OperationsController());

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
    return Column(
      children: [
        Expanded(
          child: GetBuilder<OperationsController>(
              init: OperationsController(),
              builder: (context) {
                return ListView.builder(
                    itemCount:
                        operationController.operationsListExchange.length,
                    itemBuilder: (ctx, index) => Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey,
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              margin: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    operationController
                                        .operationsListExchange[index].date,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  Text(
                                    '+' +
                                        operationController.totalExchange
                                            .toString() +
                                        ' UZS',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            for (var item in operationController
                                .operationsListExchange[index].operations)
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 5),
                                padding: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Color(getCategory(
                                            item.categoryId)['color']),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: getCategory(item.categoryId)['icon'],
                                  ),
                                  title: Container(
                                    child: Text(
                                        getCategory(item.categoryId)['title']
                                            .toString()),
                                  ),
                                  trailing: Container(
                                    child: Text(
                                      '+' + item.expense.toString() + ' UZS',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.greenAccent,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ));
              }),
        ),
      ],
    );
  }
}
