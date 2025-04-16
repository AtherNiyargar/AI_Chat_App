import 'dart:io' show Directory;

import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseFunctionality {
  DatabaseFunctionality._();
  static final DatabaseFunctionality dbInstance = DatabaseFunctionality._();
  factory DatabaseFunctionality() {
    return dbInstance;
  }

  Database? db;

  Future<Database> getDB() async {
    return db ?? await openDB();
    // if (db == null) {
    //   db = await openDB();
    //   return db!;
    // } else {
    //   return db!;
    // }
  }

  Future<Database> openDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(createQuery);
      },
    );
  }

  // Stream<Map<String, dynamic>> getDataFromDB() async* {
  //   Database db = await getDB();
  //   var result = await db.query(tableName);
  //   for (var msg in result) {
  //     yield {message: msg.values.first, isSent: msg.values.elementAt(1)};
  //   }
  // }

  Future<List<Map<String, dynamic>>> getDataFromDB() async {
    Database db = await getDB();
    return await db.query(tableName);
  }

  Future insertData(String msg, int isMsgSent) async {
    Database db = await getDB();
    await db.insert(tableName, {message: msg, isSent: isMsgSent});
  }
}

const String tableName = 'messageTable';
const String sNo = 's_no';
const String message = 'message';
const String isSent = 'is_sent';
const String dbName = 'AppDB.db';

const String createQuery = '''
CREATE TABLE $tableName (
	$sNo	INTEGER NOT NULL UNIQUE,
	$message	TEXT,
	$isSent	INTEGER,
	PRIMARY KEY($sNo AUTOINCREMENT)
);''';
