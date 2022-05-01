// ignore_for_file: prefer_const_constructors

import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/controllers/ChartController.dart';
import 'package:wallet_app/controllers/OperationsController.dart';
import 'package:wallet_app/screens/exchange/exchange_tab_screen.dart';
import 'package:wallet_app/screens/wallet/wallet_tab_screen.dart';
import 'package:wallet_app/widgets/AppDrawer.dart';

class DefaultTabs extends StatefulWidget {
  const DefaultTabs({Key? key}) : super(key: key);

  @override
  State<DefaultTabs> createState() => _DefaultTabsState();
}

class _DefaultTabsState extends State<DefaultTabs> {
  OperationsController operationController = Get.put(OperationsController());
  ChartController chartsController = Get.put(ChartController());
  DateTime datePickerData = DateTime.now();

  void setCurrentDate(date) {
    String receivedDate = DateFormat('d MMMM yyyy').format(date);

    operationController.changeDateOfController(receivedDate);
    chartsController.getCharts(receivedDate);
    chartsController.getChartsProfit(receivedDate);
    operationController.getOperations(receivedDate);
    operationController.getOperationsExchange(receivedDate);

    operationController.update();
  }

  void changeDateWithArrows(DateTime date, String type) {
    if (type == 'PREV') {
      var day = date.day - 1;
      if (day > 0) {
        var dateCh = DateTime(date.year, date.month, day);

        setState(() {
          datePickerData = dateCh;
        });

        setCurrentDate(dateCh);
      } else if (day == 0) {
        var days = DateTimeRange(
                start: DateTime(date.year, date.month - 1, date.day),
                end: DateTime(date.year, date.month))
            .duration
            .inDays;
        var dateCh = DateTime(date.year, date.month - 1, days);
        setState(() {
          datePickerData = dateCh;
        });
        setCurrentDate(dateCh);
      }
    }
    if (type == 'NEXT') {
      if (date !=
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) {
        var day = date.day + 1;
        var dateCh = DateTime(date.year, date.month, day);
        setState(() {
          datePickerData = dateCh;
        });
        setCurrentDate(dateCh);
      }
    }
  }

  @override
  Widget build(context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 150,
            backgroundColor: Color(0xFF272B40),
            primary: true,
            bottom: PreferredSize(
              child: Column(
                children: [
                  TabBar(
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Color(0xFF2E2E47)),
                    // ignore: prefer_const_literals_to_create_immutables
                    tabs: [
                      const Tab(
                        child: Text(
                          'Расход',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      const Tab(
                        child: Text(
                          'Приход',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: double.infinity,
                    color: Color(0xFF272B40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              changeDateWithArrows(datePickerData, 'PREV');
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 15,
                              color: Colors.white,
                            )),
                        TextButton(
                            onPressed: () {
                              DatePicker.showDatePicker(context,
                                  minDateTime: DateTime(2021, 1, 1),
                                  maxDateTime: DateTime.now(),
                                  onChange: (date, index) {
                                setState(() {
                                  datePickerData = date;
                                });
                              }, onConfirm: (date, index) {
                                setCurrentDate(date);
                              },
                                  initialDateTime: datePickerData,
                                  locale: DateTimePickerLocale.ru);
                            },
                            child: GetBuilder<OperationsController>(
                                init: OperationsController(),
                                builder: (_) {
                                  return Text(
                                    operationController.dateTextRu.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  );
                                })),
                        TextButton(
                            onPressed: () {
                              changeDateWithArrows(datePickerData, 'NEXT');
                            },
                            child: Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              preferredSize: Size.fromHeight(15),
            ),
            title: Text('Кошелек'),
            centerTitle: true,
            actions: const [Icon(Icons.notifications)],
          ),
          drawer: AppDrawer(),
          body: TabBarView(children: [WalletTab(), ExchangeTab()]),
        ));
  }
}
