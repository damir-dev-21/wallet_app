import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wallet_app/constants/categories.dart';
import 'package:wallet_app/controllers/ChartController.dart';
import 'package:wallet_app/controllers/DateController.dart';
import 'package:wallet_app/controllers/OperationsController.dart';
import 'package:wallet_app/models/Chart.dart';
import 'package:wallet_app/models/ChartOverview.dart';
import 'package:wallet_app/models/Operation.dart';
import 'package:wallet_app/widgets/CalcButton.dart';

class ModalWindowForInput extends StatefulWidget {
  final String title;
  final int color;
  final IconData icon;
  final int id;

  ModalWindowForInput(this.title, this.color, this.icon, this.id);

  @override
  _ModalWindowForInputState createState() => _ModalWindowForInputState();
}

class _ModalWindowForInputState extends State<ModalWindowForInput> {
  int id = Random().nextInt(1000);
  var count = '0';
  final chartController = Get.put(ChartController());
  //final dateController = Get.put(DateController());
  final operationsController = Get.put(OperationsController());

  String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
  String dateYes = DateFormat('d MMMM yyyy')
      .format(DateTime.now().subtract(Duration(days: 1)));
  void changeCount(countSelect) {
    print("! " + operationsController.dateText);
    setState(() {
      if (countSelect is Icon) {
        if (countSelect.icon == Icons.check) {
          chartController.addChart(Chart(
              widget.title,
              operationsController.dateText,
              double.parse(count),
              widget.color));
          chartController.addChartOverview(ChartOverview(
              dateNow, double.parse(count), Color(widget.color), widget.title));
          operationsController.addOperation(
              Operation(id, widget.id, int.parse(count), '', true));

          operationsController.update();
          Navigator.pop(context);
        }
        if (countSelect.icon == Icons.backspace) {
          String t =
              count.substring(0, count.lastIndexOf(count[count.length - 1]));
          count = t;
          if (count.length == 0) {
            count = '0';
          }
        }
      } else {
        if (count.length == 1 && count == '0') {
          count = count.substring(0, count.lastIndexOf('0'));
        }
        count += countSelect;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 520,
      child: Column(children: [
        Container(
          color: Color(widget.color),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'На Категорию',
                      style: TextStyle(fontSize: 17, color: Colors.white),
                    ),
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Icon(
                    widget.icon,
                    color: Color(widget.color),
                    size: 23,
                  ),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              Text('Расход'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '$count UZS',
                  style: TextStyle(fontSize: 25),
                ),
              )
            ],
          ),
        ),
        //Divider(),
        //Container(width: double.infinity, height: 40, child: TextField()),

        Expanded(
            child: GetBuilder<OperationsController>(
          init: OperationsController(),
          builder: (_) => Container(
            color: Color(0xFFECECEC),
            height: 200,
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 5,
              itemCount: calcButtons.length,
              itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  changeCount(calcButtons[index]['value']);
                },
                child: CalcButton(calcButtons[index]['value'],
                    calcButtons[index]['color'], calcButtons[index]['isBtn']),
              ),
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(1, index / 14 == 1 ? 2 : 1),
              mainAxisSpacing: 1.5,
              crossAxisSpacing: 1.5,
            ),
          ),
        )),

        Container(
          height: 30,
          child: Center(
              child: Text(
            'Сегодня, ' + dateNow + ' Г.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          )),
        )
      ]),
    );
  }
}
