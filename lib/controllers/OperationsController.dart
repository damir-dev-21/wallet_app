import 'dart:math';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_app/models/Operation.dart';
import 'package:wallet_app/services/database_helper.dart';

class OperationsController extends GetxController {
  final RxList<Operation> _operations = RxList<Operation>([
    Operation(1, 1, 0, '', false),
    Operation(2, 2, 0, '', false),
    Operation(3, 3, 0, '', false),
    Operation(4, 4, 0, '', false),
    Operation(5, 5, 0, '', false),
    Operation(6, 6, 0, '', false),
    Operation(7, 7, 0, '', false),
    Operation(8, 8, 0, '', false),
  ]);

  final RxList<Operation> _operationsExchange = RxList<Operation>([
    Operation(9, 9, 0, '', false),
  ]);

  RxList<OperationList> operationsList = RxList<OperationList>([]);
  RxList<OperationList> operationsListExchange = RxList<OperationList>([]);

  //RxList<OperationList> operationsAllTime = RxList<OperationList>([]);

  var total = 0;
  var totalExchange = 0;
  var outcome = 0;
  var dateText = '';
  var dateTextRu = '';

  @override
  void onInit() {
    String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
    String dateYes = DateFormat('d MMMM yyyy')
        .format(DateTime.now().subtract(Duration(days: 1)));
    dateText = dateNow;
    changeDateOfController(dateNow);
    getOperations(dateNow);
    getOperationsExchange(dateNow);
    super.onInit();
  }

  void clearAllData() async {
    Database db = await DatabaseHelper().db;

    operationsList.clear();
    operationsListExchange.clear();
    update();

    await db.delete('operationList');
    await db.delete('operationListProfit');
  }

  void changeDateOfController(String recDate) {
    List<Map<String, String>> months = [
      {'January': 'Января'},
      {'February': 'Февраля'},
      {'March': 'Марта'},
      {'April': 'Апреля'},
      {'May': 'Мая'},
      {'June': 'Июня'},
      {'July': 'Июля'},
      {'August': 'Августа'},
      {'September': "Сентября"},
      {'October': "Октября"},
      {'November': "Ноября"},
      {'December': "Декабря"}
    ];
    String month = recDate.split(' ')[1];
    String lang = '';
    // recDate.replaceFirst('', to)
    months.forEach((element) {
      var usdKey = element.keys
          .firstWhere((k) => element[k] == element[month], orElse: () => '');
      if (month == usdKey) {
        lang = recDate.replaceAll(month, element[month].toString());
      }
    });
    dateTextRu = lang;
    dateText = recDate;
    update();
  }

  List<Operation> get operations {
    return [..._operations];
  }

  List<Operation> get operationsExchange {
    return [..._operationsExchange];
  }

  Operation findById(id) {
    return _operations.firstWhere((element) => element.categoryId == id);
  }

  Operation findByIdExchange(id) {
    return _operationsExchange
        .firstWhere((element) => element.categoryId == id);
  }

  Future<void> getOperations(String date) async {
    final db = await DatabaseHelper().fetchOperations(date);
    total = 0;

    outcome = 0;
    operations.forEach((element) {
      element.expense = 0;
      element.comment = "";
      element.isStarted = false;
    });
    operationsList.clear();
    update();
    if (db.isNotEmpty) {
      db.forEach((element) {
        element.operations.forEach((element) {
          addOperation(element);
        });
      });
    }
  }

  Future<void> getOperationsExchange(String date) async {
    final db = await DatabaseHelper().fetchOperationsProfit();

    totalExchange = 0;

    _operationsExchange.forEach((element) {
      element.expense = 0;
      element.comment = "";
      element.isStarted = false;
    });
    operationsListExchange.clear();
    update();
    if (db.isNotEmpty) {
      db.forEach((element) {
        element.operations.forEach((element) {
          addOperationExchange(element);
        });
      });
    }
  }

  void addOperationExchange(Operation operation) async {
    Database db = await DatabaseHelper().db;
    int id = Random().nextInt(1000);
    String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
    var item = _operationsExchange.firstWhere(
      (e) => e.categoryId == operation.categoryId,
    );

    item.expense = operation.expense;
    item.comment = operation.comment;
    item.isStarted = operation.isStarted;

    var i = operationsListExchange.firstWhere(
        (element) => element.date == dateText,
        orElse: () => OperationList(
            404,
            dateText,
            _operationsExchange
                .where((element) => element.isStarted)
                .toList()));

    if (i.id == 404) {
      OperationList obj = OperationList(id, dateText,
          _operationsExchange.where((element) => element.isStarted).toList());
      operationsListExchange.add(obj);

      await db.insert("operationListProfit", obj.toMap());
    } else {
      List<Operation> listOfOperations =
          _operationsExchange.where((element) => element.isStarted).toList();
      i.operations = listOfOperations;
      String operationToString = getOper(listOfOperations);
      await db.rawUpdate(
          'UPDATE operationListProfit SET operations = ? WHERE id = ?',
          [operationToString, i.id]);
    }

    setTotalExchange();
    update();
  }

  Future<void> addOperation(Operation operation) async {
    Database db = await DatabaseHelper().db;

    int id = Random().nextInt(1000);
    String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
    String dateYes = DateFormat('d MMMM yyyy')
        .format(DateTime.now().subtract(Duration(days: 1)));
    var item = _operations.firstWhere(
      (e) => e.categoryId == operation.categoryId,
    );

    item.expense = operation.expense;
    item.comment = operation.comment;
    item.isStarted = operation.isStarted;

    var i = operationsList.firstWhere((element) => element.date == dateText,
        orElse: () => OperationList(404, dateText,
            operations.where((element) => element.isStarted).toList()));

    if (i.id == 404) {
      OperationList obj = OperationList(id, dateText,
          operations.where((element) => element.isStarted).toList());
      operationsList.add(obj);
      await db.insert("operationList", obj.toMap());
    } else {
      List<Operation> listOfOperations =
          operations.where((element) => element.isStarted).toList();
      i.operations = listOfOperations;
      String operationToString = getOper(listOfOperations);
      await db.rawUpdate('UPDATE operationList SET operations = ? WHERE id = ?',
          [operationToString, i.id]);
    }

    setTotal();
    update();
  }

  // Future<void> addOperationAllTime(Operation operation) async {
  //   Database db = await DatabaseHelper().db;

  //   int id = Random().nextInt(1000);
  //   String dateNow = DateFormat('d MMMM yyyy').format(DateTime.now());
  //   String dateYes = DateFormat('d MMMM yyyy')
  //       .format(DateTime.now().subtract(Duration(days: 1)));
  //   var item = _operations.firstWhere(
  //     (e) => e.categoryId == operation.categoryId,
  //   );

  //   item.expense = operation.expense;
  //   item.comment = operation.comment;
  //   item.isStarted = operation.isStarted;

  //   var i = operationsAllTime.firstWhere((element) => element.date == dateText,
  //       orElse: () => OperationList(404, dateText,
  //           operations.where((element) => element.isStarted).toList()));

  //   if (i.id == 404) {
  //     OperationList obj = OperationList(id, dateText,
  //         operations.where((element) => element.isStarted).toList());
  //     operationsAllTime.add(obj);
  //     //await db.insert("operationList", obj.toMap());
  //   } else {
  //     List<Operation> listOfOperations =
  //         operations.where((element) => element.isStarted).toList();
  //     i.operations = listOfOperations;
  //     String operationToString = getOper(listOfOperations);
  //     // await db.rawUpdate('UPDATE operationList SET operations = ? WHERE id = ?',
  //     //     [operationToString, i.id]);
  //   }

  //   setTotal();
  //   update();
  // }

  void setTotal() {
    total = _operations.fold(
        0, (previousValue, element) => previousValue + element.expense);

    //outcome = totalExchange - total.value;

    update();
  }

  void setTotalExchange() {
    totalExchange = _operationsExchange.fold(
        0, (previousValue, element) => previousValue + element.expense);

    //outcome = totalExchange - total.value;

    update();
  }
}
