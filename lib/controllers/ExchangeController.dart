import 'dart:convert';

import 'package:get/get.dart';
import 'package:wallet_app/models/Crypto.dart';
import 'package:wallet_app/models/ExchangeChart.dart';
import 'package:http/http.dart' as http;

class ExchangeController extends GetxController {
  RxList exchangeChartList = RxList<ExchangeChart>([]);
  RxList exchangeCryptoList = RxList<Crypto>([]);

  List<ExchangeChart> get itemsChart {
    return [...exchangeChartList];
  }

  List<Crypto> get itemsCrypto {
    return [...exchangeCryptoList];
  }

  void addExchangeChart(ExchangeChart chart) {
    exchangeChartList.add(chart);
    update();
  }

  void addExchangeCrypto(Crypto crypto) {
    exchangeCryptoList.add(crypto);
    update();
  }

  void getDataFromAPI() async {
    var url = 'https://rest.coinapi.io/v1/assets';
    final responce = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "X-CoinAPI-Key": "84EF9114-A3C6-47F5-B999-C2094A995C2A"
    });

    final data = json.decode(responce.body) as List<dynamic>;
    var index = 0;
    data.forEach((element) {
      if (element['type_is_crypto'] == 1 && index < 10) {
        Crypto newCrypto = Crypto(
            element['asset_id'],
            element['name'],
            element['type_is_crypto'],
            element['data_end'],
            element['volume_1hrs_usd'],
            element['volume_1day_usd'],
            element['volume_1mth_usd'],
            element['price_usd'].toString());

        addExchangeCrypto(newCrypto);
        index = index + 1;
      }
    });
    update();
  }
}
