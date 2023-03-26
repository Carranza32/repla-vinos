import 'package:repla_vinos/models/form_model.dart';
import 'package:repla_vinos/models/plaguidas_model.dart';
import 'package:repla_vinos/models/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbDataSource {
	static const _databaseName = 'repla_vinos.db';
	static const _databaseVersion = 1;

	static Future<DbDataSource> init() async {
		final aux = DbDataSource();
		await aux._init();

		return aux;
	}

	late final Database db;

	Future<void> _init() async {
		final dbPath = await getDatabasesPath();
		print("DB Location: " + dbPath);

		final path = join(dbPath, _databaseName);

		db = await openDatabase(
			path,
			version: _databaseVersion,
			onCreate: (db, version) async {
				await db.execute('''
					CREATE TABLE IF NOT EXISTS user (
						id INTEGER PRIMARY KEY AUTOINCREMENT,
						llaveApi TEXT,
						nombre TEXT,
						email TEXT,
					)

					CREATE TABLE IF NOT EXISTS form (
						id INTEGER PRIMARY KEY AUTOINCREMENT,
						vinificacion TEXT,
						diametro TEXT,
						plaguicida INTEGER,
						dosis TEXT,
						fechaAplicacion TEXT,
						so TEXT
					)

					CREATE TABLE IF NOT EXISTS plaguicidas (
						id INTEGER PRIMARY KEY,
						plaguicida TEXT,
						k TEXT,
						ftt TEXT,
						ftb TEXT,
					)
				''');
			}
		);
	}

	Future<int> saveUser(Usuario user) {
		return db.insert('user', user.toMapForDb(), conflictAlgorithm: ConflictAlgorithm.replace);
	}

	Future<Usuario?> getUser() async {
		final data = await db.query('user');

		if (data.isNotEmpty) {
			return Usuario.fromJson(data.first);
		}else{
			return null;
		}
	}

	Future<int> saveForm(FormModel form) {
		return db.insert('form', form.toMapForDb(), conflictAlgorithm: ConflictAlgorithm.replace);
	}

	Future<List<FormModel>?> getForms() async {
		final data = await db.query('form');

		if (data.isNotEmpty) {
			return data.map((e) => FormModel.fromJson(e)).toList();
		}else{
			return null;
		}
	}

	Future<int?> savePlaguicidas(List<Plaguicida> plaguicidas) async {
		await db.delete('plaguicidas');

		return await db.transaction((txn) async {
			for (var item in plaguicidas) {
				await txn.insert('plaguicidas', item.toMapForDb());
			}
			return null;
		});
	}

	Future<List<Plaguicida>?> getPlaguicidas() async {
		final data = await db.query('plaguicidas');

		if (data.isNotEmpty) {
			return data.map((e) => Plaguicida.fromJson(e)).toList();
		}else{
			return null;
		}
	}

	Future<bool> deletePlaguicidas() async {
		final result = await db.delete('plaguicidas');

		return result == 1;
	}

	Future<bool> deleteForm(int id) async {
		final result = await db.delete('form', where: 'id = ?', whereArgs: [id]);

		return result == 1;
	}

	Future<int> deleteAllForms() {
		return db.delete('form');
	}

	Future<bool> deleteUser() async {
		final result = await db.delete('user');

		return result == 1;
	}

	Future<int> deleteAll() async {
		await deleteUser();
		await deleteAllForms();

		return 1;
	}
}