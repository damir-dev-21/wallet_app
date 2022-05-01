class Transaction {
  final int id;
  final String date;
  final int chart_id;
  final int operation_id;

  Transaction(this.id, this.date, this.chart_id, this.operation_id);

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "date": date,
      "chart_id": chart_id,
      "operation_id": operation_id,
    };
  }

  factory Transaction.fromDb(Map<String, dynamic> map) {
    return Transaction(
        map['id'], map['date'], map['chart_id'], map['operation_id']);
  }
}
