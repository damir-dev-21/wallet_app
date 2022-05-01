import 'dart:ui';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallet_app/screens/wallet/screens/expenses/CategoriesExpensesScreen.dart';
import 'package:wallet_app/screens/wallet/screens/expenses/ListExpensesScreen.dart';
import 'package:wallet_app/screens/wallet/screens/expenses/OverviewExpensesScreen.dart';
import 'package:wallet_app/screens/wallet/screens/expenses/TransactionsExpensesScreen.dart';

class WalletTab extends StatefulWidget {
  @override
  _WalletTabState createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  List pages = [];
  int selectedPageIndex = 0;

  @override
  void initState() {
    pages = [
      CategoriesExpensesScreen(),
      TransactionsExpensesScreen(),
      OverviewExpensesScreen()
    ];
    super.initState();
  }

  // void selectedPage(id) {
  //   setState(() {
  //     selectedPageIndex = id;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        body: pages[selectedPageIndex],
        bottomNavigationBar: Container(
          color: Color(0xFF272B40),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (int i) {
                  setState(() {
                    selectedPageIndex = i;
                  });
                },
                currentIndex: selectedPageIndex,
                unselectedItemColor: Colors.black,
                selectedItemColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Color(0xFF272B40),
                elevation: 0,
                iconSize: 38,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.add_chart_rounded), label: 'Категории'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.list_alt), label: 'Транзакции'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.bar_chart), label: 'Общее'),
                ]),
          ),
        ),
      ),

      // BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      //     child: Container(
      //       color: Colors.black.withOpacity(0),
      //     ))
    ]);
  }
}
