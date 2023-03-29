import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:repla_vinos/models/form_model.dart';
import 'package:repla_vinos/models/plaguidas_model.dart';
import 'package:repla_vinos/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DBProvider {
	static const _databaseName = 'repla_vinos.db';
	static const _databaseVersion = 1;

	static Database? _dataBase;
	static final DBProvider db = DBProvider._();
	DBProvider._();

	Future<Database?> get database async{
		if(_dataBase != null) return _dataBase;

		_dataBase = await initDB();
		return _dataBase;
  	}

  	Future<Database> initDB() async{
      Database db;

      if (kIsWeb) {
        var factory_web = databaseFactoryFfiWeb;
        db = await factory_web.openDatabase(join(".", _databaseName));

        var sqliteVersion = (await db.rawQuery('select sqlite_version()')).first.values.first;
        print(sqliteVersion);
        print("DB Location: " + db.path);

        await db.execute('''
                CREATE TABLE IF NOT EXISTS user (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  llave_api TEXT,
                  nombre TEXT,
                  email TEXT
                );
            ''');

            await db.execute('''
                CREATE TABLE IF NOT EXISTS form (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  vinificacion TEXT,
                  diametro TEXT,
                  plaguicida INTEGER,
                  dosis TEXT,
                  fechaAplicacion TEXT,
                  so TEXT
                );
            ''');
            
            await db.execute('''
                CREATE TABLE IF NOT EXISTS plaguicidas (
                  id TEXT,
                  plaguicida TEXT,
                  k TEXT,
                  ftt TEXT,
                  ftb TEXT
                );
            ''');
        
      } else {
        //getPath database
        Directory documentDirectory = await getApplicationDocumentsDirectory();
        final path = join(documentDirectory.path, _databaseName);

        print("DB Location: " + path);

        //Crear db
        db = await openDatabase(
          path,
          version: _databaseVersion,
          onOpen: (db) {},
          onCreate: (Database db, int version) async {
            await db.execute('''
                CREATE TABLE IF NOT EXISTS user (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  llave_api TEXT,
                  nombre TEXT,
                  email TEXT
                );
            ''');

            await db.execute('''
                CREATE TABLE IF NOT EXISTS form (
                  id INTEGER PRIMARY KEY AUTOINCREMENT,
                  vinificacion TEXT,
                  diametro TEXT,
                  plaguicida INTEGER,
                  dosis TEXT,
                  fechaAplicacion TEXT,
                  so TEXT
                );
            ''');
            
            await db.execute('''
                CREATE TABLE IF NOT EXISTS plaguicidas (
                  id TEXT,
                  plaguicida TEXT,
                  k TEXT,
                  ftt TEXT,
                  ftb TEXT
                );
            ''');
          }
        );
      }

      return db;
  	}

	Future<int?> insertUser(Usuario model) async{
		final db = await database;
		final res = await db?.insert('user', model.toJson());
		//regresa el id del ultimo producto
		return res;
   }

	Future<Usuario?> getUser() async {
		final db = await database;
		final res = await db?.query('user');
    print(res!);

		return res.isNotEmpty ? Usuario.fromJson(res.first) : null;
	}

	Future<int> updateUser(Usuario model) async {
		final db = await database;
		final res = await db!.update('user', model.toJson(), where: 'llave_api = ?', whereArgs: [model.llaveApi]);

		return res;
	}

	Future<int> insertForm(FormModel form) async {
		final db = await database;
		final res = await db!.insert('form', form.toMapForDb(), conflictAlgorithm: ConflictAlgorithm.replace);

		return res;
	}

	Future<int> insertPlagicida(Plaguicida model) async {
		final db = await database;
		final res = await db!.insert('plaguicidas', model.toMapForDb(), conflictAlgorithm: ConflictAlgorithm.replace);

		return res;
	}

	Future<List<Plaguicida>?> getAllPlagicidas() async {
		final db = await database;
		final res = await db!.query('plaguicidas');

		return res.isNotEmpty 
			? res.map((s) => Plaguicida.fromJson(s)).toList() 
			: null;
	}

	Future<int> deleteUser() async {
		final db  = await database;
		final res = await db!.rawDelete('DELETE FROM user');
		return res;
	}
}