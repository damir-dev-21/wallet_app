import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:wallet_app/controllers/ChartController.dart';
import 'package:wallet_app/controllers/OperationsController.dart';
import 'package:wallet_app/models/Chart.dart';
import 'package:wallet_app/widgets/ModalWindowForInput.dart';
import 'package:wallet_app/widgets/ModalWindowForInputExchange.dart';

class CategoryItemExchange extends StatefulWidget {
  final String title;
  final int color;
  final IconData icon;
  final int categoryId;

  CategoryItemExchange(this.title, this.color, this.icon, this.categoryId);

  @override
  _CategoryItemExchangeState createState() => _CategoryItemExchangeState();
}

class _CategoryItemExchangeState extends State<CategoryItemExchange> {
  @override
  Widget build(BuildContext context) {
    final operationsController = Get.put(OperationsController());

    var item = operationsController.findByIdExchange(widget.categoryId);
    var expense = item.expense.toString();

    return GestureDetector(
        onTap: () {
          showMaterialModalBottomSheet(
              context: context,
              builder: (context) {
                return ModalWindowForInputExchange(
                    widget.title, widget.color, widget.icon, widget.categoryId);
              });
          setState(() {});
        },
        child: GetBuilder<OperationsController>(
          builder: (_) => Container(
            margin: EdgeInsets.symmetric(vertical: 15),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 23,
                    ),
                    width: 47,
                    height: 47,
                    decoration: BoxDecoration(
                        color: Color(widget.color),
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  Text(item.expense.toString(),
                      style: TextStyle(fontSize: 14, color: Colors.white))
                ]),
          ),
        ));
  }
}
