// ignore: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import "model.dart";

class DbService {
  Future<Database> initilaize() async {
    String path = await getDatabasesPath();

    return openDatabase(join(path, "data.db"),
        onCreate: (database, version) async {
      await database.execute('CREATE TABLE Sessions(date TEXT, hours REAL)');

      final DateTime now = DateTime.now();

      for (int i = 0; i < 7; i++) {
        final DateTime date = now.add(Duration(days: i));
        final formatted = "${date.year}-${date.month}-${date.day}";
        await database.insert("Sessions", {'date': formatted, 'hours': 0},
            conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }, version: 1);
  }

  Future<List<DataModel>> get() async {
    final db = await initilaize();

    final List<Map<String, Object?>> dataMap = await db.query("Sessions");

    return [
      for (final {"date": date as String, "hours": hours as double} in dataMap)
        DataModel(date: date, hours: hours)
    ];
  }

  Future<void> insertHours(DataModel dm) async {
    final db = await initilaize();
    await db.insert("Sessions", dm.toMap());
  }

  Future<void> updateHours(double hours) async {
    final db = await initilaize();
    DateTime date = DateTime.now();
    final formatted = "${date.year}-${date.month}-${date.day}";

    List<Map<String, dynamic>> newData = await db.query('Sessions',
        columns: ['hours'], where: 'date = ?', whereArgs: [formatted]);

    double currentHours = newData.first['hours'] as double;

    await db.update('Sessions', {"hours": currentHours + hours},
        where: 'date = ?', whereArgs: [formatted]);
  }

  Future<void> deleteAll() async {
    final db = await initilaize();
    await db.delete("Sessions");
  }

  Future<double> getToday() async {
    final db = await initilaize();
    final now = DateTime.now();
    final today = "${now.year}-${now.month}-${now.day}";

    List<Map<String, dynamic>> data =
        await db.query('Sessions', where: "date = ?", whereArgs: [today]);

    return data[0]['hours'];
  }

  Future<Map<String, double>> getStats() async {
    final db = await initilaize();

    List<Map<String, dynamic>> monthAvg = await db.rawQuery(
        "SELECT AVG(hours) AS avg from Sessions WHERE date >= date('now','-30 days')");

    List<Map<String, dynamic>> weekAvg = await db.rawQuery(
        "SELECT AVG(hours) as avg from Sessions WHERE date >= date('now','-6 days')");
    List<Map<String, dynamic>> avgRes =
        await db.rawQuery("SELECT AVG(hours) AS avg from Sessions");
    List<Map<String, dynamic>> maxRes =
        await db.rawQuery("SELECT MAX(hours) AS max from Sessions");

    double month = monthAvg[0]['avg'];
    double avg = avgRes[0]['avg'];
    double max = maxRes[0]['max'];
    double week = weekAvg[0]['avg'];

    return {'monthAvg': month, 'avg': avg, 'max': max, 'weekAvg': week};
  }
}
