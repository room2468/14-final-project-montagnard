import 'dart:async';
import 'dart:io';
import 'package:gudang_kopi/model/item_kategori.dart';
import 'package:gudang_kopi/model/item_masuk.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'item_keluar.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  Future<Database> initDb() async {
//untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'item.db';
//create, read databases
    var itemDatabase = openDatabase(path,
        version: 4, onCreate: _createDb, onUpgrade: _onUpgrade);
//mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      // db.execute(""); // SQL Query
    }
  }

//buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    Batch batch = db.batch();
    //tabel kategori
    batch.execute('''
    CREATE TABLE kategori (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    beratKarung TEXT
    )
    ''');

    // tabel KopiMasuk
    batch.execute('''
    CREATE TABLE masuk (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    jenisKopi TEXT,
    jumlah INTEGER,
    idKategori INTEGER, FOREIGN KEY (idKategori) REFERENCES kategori(id)
          )''');

    // tabel KopiKeluar
    batch.execute('''
    CREATE TABLE keluar (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    jenisKopi TEXT,
    jumlah INTEGER,
    idKategori INTEGER, FOREIGN KEY (id_kategori) REFERENCES kategori(id)
          )''');
    List<dynamic> res = await batch.commit();
  }

//select databases table kategori
  Future<List<Map<String, dynamic>>> selectKategori() async {
    Database db = await this.initDb();
    var mapList = await db.query('kategori', orderBy: 'id');
    return mapList;
  }

//select database table masuk
  Future<List<Map<String, dynamic>>> selectMasuk() async {
    Database db = await this.initDb();
    var mapList = await db.query('masuk', orderBy: 'id');
    return mapList;
  }

//select database table keluar
  Future<List<Map<String, dynamic>>> selectKeluar() async {
    Database db = await this.initDb();
    var mapList = await db.query('keluar', orderBy: 'id');
    return mapList;
  }

//create databases table kategori
  Future<int> insertKategori(Kategori object) async {
    Database db = await this.initDb();
    int count = await db.insert('kategori', object.toMap());
    return count;
  }

//create databases table masuk
  Future<int> insertMasuk(Masuk object) async {
    Database db = await this.initDb();
    int count = await db.insert('masuk', object.toMap());
    return count;
  }

//create databases table keluar
  Future<int> insertKeluar(Keluar object) async {
    Database db = await this.initDb();
    int count = await db.insert('keluar', object.toMap());
    return count;
  }

//update databases table kategori
  Future<int> updateKategori(Kategori object) async {
    Database db = await this.initDb();
    int count = await db.update('kategori', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //update databases table Masuk
  Future<int> updateMasuk(Masuk object) async {
    Database db = await this.initDb();
    int count = await db
        .update('masuk', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //update databases table Keluar
  Future<int> updateKeluar(Keluar object) async {
    Database db = await this.initDb();
    int count = await db.update('keluar', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

  //delete databases table Kategori
  Future<int> deleteKategori(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('kategori', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //delete databases table Masuk
  Future<int> deleteMasuk(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('masuk', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //delete databases table Keluar
  Future<int> deleteKeluar(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('keluar', where: 'id=?', whereArgs: [id]);
    return count;
  }

  //list item table Kategori
  Future<List<Kategori>> getItemListKategori() async {
    var itemMapList = await selectKategori();
    int count = itemMapList.length;
    List<Kategori> itemList = List<Kategori>();
    for (int i = 0; i < count; i++) {
      itemList.add(Kategori.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  //list item table masuk
  Future<List<Masuk>> getItemListMasuk() async {
    var itemMapList = await selectMasuk();
    int count = itemMapList.length;
    List<Masuk> itemList = List<Masuk>();
    for (int i = 0; i < count; i++) {
      itemList.add(Masuk.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  //list item table keluar
  Future<List<Keluar>> getItemListKeluar() async {
    var itemMapList = await selectKeluar();
    int count = itemMapList.length;
    List<Keluar> itemList = List<Keluar>();
    for (int i = 0; i < count; i++) {
      itemList.add(Keluar.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
