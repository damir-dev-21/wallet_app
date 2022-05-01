import 'package:intl/intl.dart';
import 'package:wallet_app/controllers/ChartController.dart';
import 'package:wallet_app/controllers/DateController.dart';
import 'package:wallet_app/controllers/OperationsController.dart';
import 'package:wallet_app/services/database_helper.dart';

OperationsController controllerOfOperations = OperationsController();
ChartController controllerOfCharts = ChartController();
DateController controllerOfDate = DateController();
DatabaseHelper _db = DatabaseHelper();

void changeData(DateTime date) {
  String receivedDate = DateFormat('d MMMM yyyy').format(date);

  controllerOfCharts.getCharts(receivedDate);
  controllerOfOperations.getOperations(receivedDate);

  controllerOfCharts.update();
  controllerOfOperations.update();
}
