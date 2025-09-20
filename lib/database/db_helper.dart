import 'package:baru/model/transaction.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper instance = DbHelper._privateConstructor();
  static sql.Database? _database;

  DbHelper._privateConstructor();

  Future<sql.Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<sql.Database> _initDatabase() async {
    final path = join(await sql.getDatabasesPath(), 'expense_tracker.db');
    return await sql.openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(sql.Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        category TEXT,
        amount REAL,
        date TEXT
      )
    ''');
  }

  Future<int> insertTransactions(Transaction transaction) async {
    final db = await instance.database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<Transaction>> getTransactions() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) {
      return Transaction.fromMap(maps[i]);
    });
  }

  Future<int> deleteTransactions(int id) async {
    final db = await instance.database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }
}
