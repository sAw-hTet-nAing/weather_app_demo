import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/models/db_model.dart';

class DBService {
  static Database? db;

  static const int version = 1;
  static const String _tableName = 'download';

  static Future<void> initDb() async {
    if (db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}fav.db';
      db = await openDatabase(
        path,
        version: version,
        onCreate: (db, version) {
          return db.execute("CREATE TABLE $_tableName("
              "id INTEGER PRIMARY KEY AUTOINCREMENT,"
              "city STRING,"
              "country STRING,"
              "lat VARCHAR(256),"
              "long VARCHAR(256),"
              "time_created STRING)");
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<int> insert(DB? newdb) async {
    return await db?.insert(_tableName, newdb!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    return await db!.query(_tableName);
  }

  static delete(city) async {
    return await db!.delete(_tableName, where: 'city=?', whereArgs: [city]);
  }

  static deleteAll() async {
    return await db!.delete(_tableName);
  }

  static Future<List> check(String city) async {
    var result =
        await db!.query(_tableName, where: "city=?", whereArgs: [city]);

    return result.toList();
  }
}
