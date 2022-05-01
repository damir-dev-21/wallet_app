import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Кошелек',
      theme: ThemeData(
          primaryColor: Color(0xFF28293F),
          scaffoldBackgroundColor: Color(0xFF2E2E47)),
      home: DefaultTabs(),
    );
  }
}
