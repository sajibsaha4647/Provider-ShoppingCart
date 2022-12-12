import 'package:path_provider/path_provider.dart';
import 'package:provider_with_shoppingcart/Cartmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get db async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDataBase();
    return _database;
  }

  initDataBase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'cart.db');
    var db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cart (id INTEGER PRIMARY KEY , productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER,productPrice INTEGER,quantity INTEGER,unitTag TEXT,image TEXT)');
  }

  Future<Cart> insertData(Cart cart) async {
    var dbclient = await db;
    await dbclient!.insert('cart', cart.toMap());
    return cart;
  }
}
