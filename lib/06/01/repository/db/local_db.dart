import 'dart:async';
import 'dart:io';

import 'package:regexp/06/01/repository/db/helper/db_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:path/path.dart' as path;

import 'helper/db_open_helper.dart';



class LocalDb {
  Database? _database;

  LocalDb._();

  final DbOpenHelper helper = const DbOpenHelper();

  static LocalDb instance = LocalDb._();

  bool get inited => _database!=null;

  Future<void> initDb({String name = "regexpo.db"}) async {
    if (_database != null) return;
    helper.setupDatabase();
    String databasesPath = await helper.getDbDirPath();
    String dbPath = path.join(databasesPath, name);

    print('====数据库所在文件夹: $dbPath=======');

    if (Platform.isWindows||Platform.isLinux) {
      DatabaseFactory databaseFactory = databaseFactoryFfi;
      _database = await databaseFactory.openDatabase(
        dbPath,
        options: OpenDatabaseOptions(
            version: 1,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onOpen: _onOpen
        ),
      );
    }else{
      _database = await openDatabase(dbPath,
        version: 1,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onOpen: _onOpen,
      );
    }
    print('初始化数据库....');
  }

  Future<void> closeDb() async {
    await _database?.close();
    _database = null;
  }

  FutureOr<void> _onCreate(Database db, int version) async{
    print('数据库创建....');
    await Future.wait([
     db.execute(DbHelper.createRecoder),
    ]);
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {
    print('数据库升级==$oldVersion====$newVersion===');
  }

  FutureOr<void> _onOpen(Database db) {
    print('数据库打开....');
  }
}
