import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:interdisciplinar/model/usuario.dart';

class UsuarioDatabase {

  static final UsuarioDatabase instance = UsuarioDatabase._init();

  static Database? _database;

  UsuarioDatabase._init();

  Future<Database>get database async {
    if (_database != null) return _database!;

    _database = await _initDB('usuario.db');
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

    await db.execute("CREATE TABLE $tableUsuario ("
  "${UsuarioFields.id} $idType, "
  "${UsuarioFields.name} $textType, "
  "${UsuarioFields.telefone} $textType, "
  "${UsuarioFields.senha} $textType"
")");
  }

  Future<Usuario> create(Usuario usuario) async {
    final db = await instance.database;

    final id = await db.insert(tableUsuario, usuario.toJson());
    print("Usuario criado com id = $id");
    return usuario.copy(id: id);
  }

  Future<Usuario> getLoginUser(String nome, String senha) async {
    final db = await instance.database;

    final res = await db.rawQuery("SELECT * FROM $tableUsuario WHERE "
    "${UsuarioFields.name} = '$nome' AND "
    "${UsuarioFields.senha} = '$senha'");

    if (res.isNotEmpty)
    {
      return Usuario.fromJson(res.first);
    } else {
      throw Exception('Usuario e/ou senha incorretos');
    }
  }

  Future<Usuario> readFigurinha(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableUsuario,
      columns: UsuarioFields.values,
      where: '${UsuarioFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Usuario.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Usuario>> readAllFigurinha() async {
    final db = await instance.database;

    final result = await db.query(tableUsuario);

    return result.map((json) => Usuario.fromJson(json)).toList();
  }

  Future<int> update(Usuario usuario) async {
    final db = await instance.database;

    return db.update(
      tableUsuario,
      usuario.toJson(),
      where: '${UsuarioFields.id} = ?',
      whereArgs: [usuario.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUsuario,
      where: '${UsuarioFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

