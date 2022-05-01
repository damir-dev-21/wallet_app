import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wallet_app/screens/exchange/screens/CategoryExchangeScreen.dart';
import 'package:wallet_app/screens/exchange/screens/OverviewExchangeScreen.dart';
import 'package:wallet_app/screens/exchange/screens/TransactionExchangeScreen.dart';

class ExchangeTab extends StatefulWidget {
  @override
  _ExchangeTabState createState() => _ExchangeTabState();
}

class _ExchangeTabState extends State<ExchangeTab> {
  List pages = [];
  int selectedPageIndex = 0;

  @override
  void initState() {
    pages = [
      CategoriesExchangeScreen(),
      TransactionsExchangeScreen(),
      OverviewExchangeScreen()
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
