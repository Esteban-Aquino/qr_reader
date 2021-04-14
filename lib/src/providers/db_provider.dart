//
//
import 'package:qr_reader/src/models/scan_model.dart';
export 'package:qr_reader/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    // Path de donde se almacena la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScansDB.db');

    print(path);

    // Crear Bd
    return await openDatabase(path, //
        version: 1, //
        onOpen: (db) {}, //
        onCreate: (Database db, int version) async {
      await db.execute('''
              CREATE TABLE Scans (
                id INTEGER PRIMARY KEY,
                tipo TEXT,
                valor TEXT
              );
             ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel scan) async {
    //final id = scan.id;
    final tipo = scan.tipo;
    final valor = scan.valor;

    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Scans ( tipo, valor)
      VALUES ('$tipo','$valor')
    ''');
    return res;
  }

  Future<int> nuevoScan(ScanModel scan) async {
    final db = await database;
    final res = await db.insert('Scans', scan.toJson());
    print(res);
    //Id del ultimo registro insertado.
    return res;
  }

  Future<ScanModel> getScanById(int i) async {
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [i]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getTodosLosScans() async {
    final db = await database;
    final res = await db.query('Scans');
    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  Future<List<ScanModel>> getScansPorTipo(String tipo) async {
    final db = await database;
    final res = await db.rawQuery('''
        SELECT *
        FROM Scans 
        WHERE Tipo = '$tipo' 
    ''');
    return res.isNotEmpty
        ? res.map((e) => ScanModel.fromJson(e)).toList()
        : null;
  }

  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan() async {
    final db = await database;
    final res = await db.rawDelete('''
        DELETE FROM Scans
    ''');
    return res;
  }
}
