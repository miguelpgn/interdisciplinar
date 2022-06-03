import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:interdisciplinar/model/figurinha.dart';

class FigurinhaDatabase {

  static final FigurinhaDatabase instance = FigurinhaDatabase._init();

  static Database? _database;

  FigurinhaDatabase._init();

  Future<Database>get database async {
    if (_database != null) return _database!;

    _database = await _initDB('figurinha.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute("CREATE TABLE $tableFigurinha ("
  "${FigurinhaFields.id} $idType, "
  "${FigurinhaFields.name} $textType, "
  "${FigurinhaFields.imagem} $textType, "
  "${FigurinhaFields.username} $textType, "
  "${FigurinhaFields.contato} $textType"
")");
  }

  Future<Figurinha> create(Figurinha figurinha) async {
    final db = await instance.database;

    final id = await db.insert(tableFigurinha, figurinha.toJson());
    print("Figurinha criada com id = $id");
    return figurinha.copy(id: id);
  }

  Future<Figurinha> readFigurinha(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableFigurinha,
      columns: FigurinhaFields.values,
      where: '${FigurinhaFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Figurinha.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<Figurinha> getFigPage(String name) async {
    final db = await instance.database;

    final res = await db.rawQuery("SELECT * FROM $tableFigurinha WHERE "
    "${FigurinhaFields.name} = '$name'");

    if (res.isNotEmpty)
    {
      return Figurinha.fromJson(res.first);
    }
    else
    {
      throw Exception('ERRO: Não foi possível abrir a página');
    }
  }

  Future<List<Figurinha>> readUserFigurinha(String username) async {
    final db = await instance.database;

    final result = await db.rawQuery("SELECT * FROM $tableFigurinha WHERE "
    "${FigurinhaFields.username} = '$username'");

    return result.map((json) => Figurinha.fromJson(json)).toList();
  }

  Future<List<Figurinha>> readFigHomePag(String username) async {
    final db = await instance.database;

    final result = await db.rawQuery("SELECT * FROM $tableFigurinha WHERE "
    "${FigurinhaFields.username} <> '$username'");

    return result.map((json) => Figurinha.fromJson(json)).toList();
  }

  Future<List<Figurinha>> readAllFigurinha() async {
    final db = await instance.database;

    final result = await db.query(tableFigurinha);

    return result.map((json) => Figurinha.fromJson(json)).toList();
  }

  Future<int> update(Figurinha figurinha) async {
    final db = await instance.database;

    return db.update(
      tableFigurinha,
      figurinha.toJson(),
      where: '${FigurinhaFields.id} = ?',
      whereArgs: [figurinha.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableFigurinha,
      where: '${FigurinhaFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

