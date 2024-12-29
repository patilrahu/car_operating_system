import 'package:carcheckinout/feature/view_car_check_history/model/car_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class AppDatabaseHelper {
  static final AppDatabaseHelper instance = AppDatabaseHelper._init();
  static Database? _database;
  static const dataBaseName = 'cars';
  AppDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB('cars.db');
    return _database!;
  }

  Future<Database> initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const dateTimeType = 'TEXT';

    await db.execute('''
      CREATE TABLE cars (
        carNumber $textType UNIQUE,
        checkInTime $dateTimeType NOT NULL,
        checkOutTime $dateTimeType
      )
    ''');
  }

  Future<int> insertCar(Map<String, Object?> car) async {
    final db = await instance.database;
    return await db.insert(
      dataBaseName,
      car,
    );
  }

  Future<List<Map<String, dynamic>>> getAllCars() async {
    final db = await instance.database;
    return await db.query(dataBaseName);
  }

  Future<int> updateCarCheckOut(String carNumber, String? checkOutTime) async {
    final db = await instance.database;
    return await db.update(
      dataBaseName,
      {'checkOutTime': checkOutTime},
      where: 'carNumber = ?',
      whereArgs: [carNumber],
    );
  }

  Future<int> updateCarCheckIn(String carNumber, String checkInTime) async {
    final db = await instance.database;
    return await db.update(
      dataBaseName,
      {'checkInTime': checkInTime},
      where: 'carNumber = ?',
      whereArgs: [carNumber],
    );
  }

  Future<Car?> getCarByNumber(String carNumber) async {
    final db = await instance.database;
    final result = await db.query(
      'cars',
      where: 'carNumber = ?',
      whereArgs: [carNumber],
    );

    if (result.isNotEmpty) {
      return Car.fromMap(result.first);
    }
    return null;
  }
}
