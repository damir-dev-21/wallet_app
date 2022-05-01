import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wallet_app/models/Chart.dart';
import 'package:wallet_app/models/Operation.dart';

import '../models/Operation.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get db async => _database ??= await init();

  Future<Database> init() async {
    String dbPath = join(await getDatabasesPath(), 'wallet.db');
    var database = openDatabase(dbPath, version: 1, onCreate: _onCreateTables);
    return database;
  }

  void _onCreateTables(Database db, int version) {
    db.execute('''
      CREATE TABLE chart(
        titleCategory TEXT,
        date TEXT,
        value REAL,
        colorCategory INTEGER
      )
    ''');

    db.execute('''
       CREATE TABLE operationList(
        id INTEGER,
        date TEXT,
        operations TEXT
      )
    ''');

    db.execute('''
      CREATE TABLE chartProfit(
        titleCategory TEXT,
        date TEXT,
        value REAL,
        colorCategory INTEGER
      )
    ''');

    db.execute('''
       CREATE TABLE operationListProfit(
        id INTEGER,
        date TEXT,
        operations TEXT
      )
    ''');

    print('Tables was created!');
  }

  Future<List<Chart>> fetchCharts(String d) async {
    var client = await db;
    List<Map<String, dynamic>> futureMaps =
        await client.rawQuery('SELECT * FROM chart WHERE date=?', [d]);
    return List.generate(futureMaps.length, (index) {
      return Chart(
          futureMaps[index]['titleCategory'],
          futureMaps[index]['date'],
          futureMaps[index]['value'],
          futureMaps[index]['colorCategory']);
    });
  }

  Future<List<Chart>> fetchChartsProfit() async {
    var client = await db;
    List<Map<String, dynamic>> futureMaps = await client.query('chartProfit');
    return List.generate(futureMaps.length, (index) {
      return Chart(
          futureMaps[index]['titleCategory'],
          futureMaps[index]['date'],
          futureMaps[index]['value'],
          futureMaps[index]['colorCategory']);
    });
  }

  Future<List<OperationList>> fetchOperations(String d) async {
    var client = await db;
    List<Map<String, dynamic>> futureMaps =
        await client.rawQuery('SELECT * FROM operationList WHERE date=?', [d]);
    return List.generate(futureMaps.length, (index) {
      List<Operation> operations = List<Operation>.from(json
          .decode(futureMaps[index]['operations'].toString())
          .map((e) => Operation.fromJson(e)));

      return OperationList(
          futureMaps[index]['id'], futureMaps[index]['date'], operations);
    });
  }

  Future<List<OperationList>> fetchOperationsProfit() async {
    var client = await db;
    List<Map<String, dynamic>> futureMaps =
        await client.query('operationListProfit');
    return List.generate(futureMaps.length, (index) {
      List<Operation> operations = List<Operation>.from(json
          .decode(futureMaps[index]['operations'].toString())
          .map((e) => Operation.fromJson(e)));

      return OperationList(
          futureMaps[index]['id'], futureMaps[index]['date'], operations);
    });
  }

  Future<List<OperationList>> fetchOperationsAll() async {
    var client = await db;
    List<Map<String, dynamic>> futureMaps = await client.query('operationList');
    return List.generate(futureMaps.length, (index) {
      List<Operation> operations = List<Operation>.from(json
          .decode(futureMaps[index]['operations'].toString())
          .map((e) => Operation.fromJson(e)));

      return OperationList(
          futureMaps[index]['id'], futureMaps[index]['date'], operations);
    });
  }
}
