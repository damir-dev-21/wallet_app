import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateController extends GetxController {
  var dateText = '';

  @override
  void onInit() {
    dateText = DateFormat("d MMMM yyyy").format(DateTime.now());
    super.onInit();
  }

  void setDateText(String date) {
    dateText = date;
    update();
  }
}
