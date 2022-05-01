import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:wallet_app/models/Category.dart';

const colorBtnAriph = Color(0xFFF7F7F7);
const colorBtnNum = Colors.white;

final List<Category> categories = [
  Category(
      1,
      'Транспорт',
      Icon(
        Icons.local_taxi,
        color: Colors.white,
      ),
      int.parse("0xFFFFD500")),
  Category(
      2,
      'Общепит',
      Icon(
        Icons.restaurant,
        color: Colors.white,
      ),
      int.parse("0xFF003F88")),
  Category(
      3,
      'Досуг',
      Icon(
        Icons.headset_mic,
        color: Colors.white,
      ),
      int.parse("0xFF2EC4B6")),
  Category(
      4,
      'Продукты',
      Icon(
        Icons.shopping_basket,
        color: Colors.white,
      ),
      int.parse("0xFF0496FF")),
  Category(
      5,
      'Здоровье',
      Icon(
        Icons.spa,
        color: Colors.white,
      ),
      int.parse("0xFF0EAD69")),
  Category(
      6,
      'Семья',
      Icon(
        Icons.face,
        color: Colors.white,
      ),
      int.parse("0xFFFF99C8")),
  Category(
      7,
      'Подарки',
      Icon(
        Icons.gif,
        color: Colors.white,
      ),
      int.parse("0xFFFF99C8")),
  Category(
      8,
      'Покупки',
      Icon(
        Icons.shopping_bag,
        color: Colors.white,
      ),
      int.parse("0xFF495867")),
  Category(
      9,
      'Зарплата',
      Icon(
        Icons.money_rounded,
        color: Colors.white,
      ),
      int.parse("0xFF495867")),
];

final List<dynamic> calcButtons = [
  {'value': '/', 'color': colorBtnAriph, 'isBtn': false},
  {'value': '7', 'color': colorBtnNum, 'isBtn': false},
  {'value': '8', 'color': colorBtnNum, 'isBtn': false},
  {'value': '9', 'color': colorBtnNum, 'isBtn': false},
  {'value': Icon(Icons.backspace), 'color': colorBtnAriph, 'isBtn': true},
  {'value': '*', 'color': colorBtnAriph, 'isBtn': false},
  {'value': '4', 'color': colorBtnNum, 'isBtn': false},
  {'value': '5', 'color': colorBtnNum, 'isBtn': false},
  {'value': '6', 'color': colorBtnNum, 'isBtn': false},
  {
    'value': Icon(Icons.calendar_view_day),
    'color': colorBtnAriph,
    'isBtn': true
  },
  {'value': '-', 'color': colorBtnAriph, 'isBtn': false},
  {'value': '1', 'color': colorBtnNum, 'isBtn': false},
  {'value': '2', 'color': colorBtnNum, 'isBtn': false},
  {'value': '3', 'color': colorBtnNum, 'isBtn': false},
  {'value': Icon(Icons.check), 'color': colorBtnAriph, 'isBtn': true},
  {'value': '+', 'color': colorBtnAriph, 'isBtn': false},
  {'value': ',', 'color': colorBtnNum, 'isBtn': false},
  {'value': '0', 'color': colorBtnNum, 'isBtn': false},
  {'value': '=', 'color': colorBtnNum, 'isBtn': false},
];
