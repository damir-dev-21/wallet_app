import 'dart:convert';
import 'dart:ffi';

class Operation {
  final int id;
  final int categoryId;
  int expense;
  String comment;
  bool isStarted;

  Operation(
      this.id, this.categoryId, this.expense, this.comment, this.isStarted);

  factory Operation.fromJson(Map<String, dynamic> json) {
    return Operation(
        json['id'] as int,
        json['categoryId'] as int,
        json['expense'] as int,
        json['comment'] as String,
        json['isStarted'] as bool);
  }
}

String getOper(List<Operation> operations) {
  List arr = [];

  operations.forEach((e) {
    Map<String, dynamic> obj = {
      "id": e.id,
      "categoryId": e.categoryId,
      "expense": e.expense,
      "comment": e.comment,
      "isStarted": e.isStarted,
    };

    arr.add(obj);
  });

  var res = json.encode(arr);

  return res;
}

class OperationList {
  final int id;
  final String date;
  List<Operation> operations;

  OperationList(this.id, this.date, this.operations);

  Map<String, Object> toMap() {
    return {'id': id, 'date': date, 'operations': getOper(operations)};
  }
}
