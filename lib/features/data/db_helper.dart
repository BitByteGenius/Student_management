import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Future<void> createTables(Database database) async {
    await database.execute("""CREATE TABLE data(
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    name TEXT,
    age INTEGER,
    course TEXT
    createdAt TEXT
    )""");
  }

  static Future<Database> db() async {
    return openDatabase(
      "database_name.db",
      version: 1,
      onCreate: (Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createData(String name, String? course, int? age) async {
    final db = await DbHelper.db();
    final data = {'name': name, 'age': age, 'course': course};
    final id = await db.insert(
      'data',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await DbHelper.db();
    return db.query('data', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSingleData(int id) async {
    final db = await DbHelper.db();
    return db.query('data', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateData(
    int id,
    String name,
    int age,
    String course,
  ) async {
    final db = await DbHelper.db();
    final data = {
      'name': name,
      'age': age,
      'course': course,
     // 'createdAt': DateTime.now().toString(),
    };
    final result = await db.update(
      'data',
      data,
      where: "id= ?",
      whereArgs: [id],
    );
    return result;
  }

  static Future<void> deleteData(int id) async {
    final db = await DbHelper.db();
    try {
      await db.delete('data', where: "id = ?", whereArgs: [id]);
    } catch (e) {}
  }
}
