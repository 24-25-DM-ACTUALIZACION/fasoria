import 'package:sqflite/sqflite.dart' as sql;
import '../model/user.dart';
import '../model/game.dart';

/// Clase que funciona como ORM entre Modelo y DB.
/// 
/// - sqflite DB
/// - User model
/// - Game model
class SQLHelper {

  /// Genera las tablas user y games en la DB sqlite.
  /// 
  /// Parametros:
  /// - Pormesa Database de sql
  /// 
  /// Devuelve:
  /// - Promesa
  static Future<void> createTables(sql.Database database) async{
    await database.execute("""CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      name TEXT,
      lastname TEXT,
      email TEXT,
      password TEXT,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
    )""");

    await database.execute("""CREATE TABLE games(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      user_id INTEGER NOT NULL,
      search_id INTEGER,
      title TEXT,
      thumbnail TEXT,
      genre TEXT,
      platform TEXT,
      release_date TEXT,
      coment TEXT,
      score REAL,
      active INTEGER,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
    )""");
  }

  /// Genera una DB de nombre database_app.db en la aplicación.
  /// 
  /// Devuelve:
  /// - Pormesa Database de sql
  static Future<sql.Database> db() async => sql.openDatabase(
      "database_app.db",
      version: 1,
      onCreate: (sql.Database database, int version) async{
        await createTables(database);
      }
    );

  //Metodos para crear registros en DB.

  /// Crea un registro en la tabla users.
  /// 
  /// Parametros:
  /// - Objeto User
  /// 
  /// Devuelve:
  /// - Pormesa int id del registro creado
  static Future<int> createUser(User user) async{
    final db = await SQLHelper.db();

    final data = user.toMap();

    final id = await db.insert('users', data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  /// Crea un registro en la tabla games.
  /// 
  /// Parametros:
  /// - Objeto Game
  /// 
  /// Devuelve:
  /// - Pormesa int id del registro creado
  static Future<int> createGame(Game game) async{
    final db = await SQLHelper.db();
    final data = game.toMap();
    final id = await db.insert('games', data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  /// Crea un 2 registros iniciales en la tabla users.
  /// 
  /// Usuarios creados
  /// - Fausto fass@uce.edu.ec
  /// - Alejandro alfa@uce.edu.ec
  static Future<void> createInitDataUsers() async{
    try {
      bool verify = await getEmailVerify('fass@uce.edu.ec');
      if (verify) {
        await createUser(User(name: 'Fausto', lastname: 'Soria', email: 'fass@uce.edu.ec', password: 'fass3425'));
        await createUser(User(name: 'Alejandro', lastname: 'Sanchez', email: 'alfa@uce.edu.ec', password: 'alfa3425')); 
      }
    } catch (e) {
      print(e);
    }
  }

  //Metodos para leer registros en DB 

  /// Obtiene todos los registros de la tabla users.
  /// 
  /// Devuelve:
  /// - Promesa de una lista de Objetos Map con todos los usuarios en la tabla users
  static Future<List<Map<String, Object?>>> getAllUsers() async{
    final db =  await SQLHelper.db();
    return db.query('users', orderBy: 'id');
  }

  /// Obtiene un registro de la tabla users por email y password.
  /// 
  /// Parámetros:
  /// - String email, String password
  /// 
  /// Devuelve:
  /// - Promesa de una lista de Objetos Map con un usuario en la tabla users o ninguno
  static Future<List<Map<String, Object?>>> getUser4EmailPass(String email, String password) async{
    final db =  await SQLHelper.db();
    return db.query('users', where: 'email = ? AND password = ?', whereArgs: [email, password], limit: 1);
  }

  /// Verifica si algun registro de la tabla users ya dispone del email ingresado.
  /// 
  /// Parámetros:
  /// - String email
  /// 
  /// Devuelve:
  /// - Promesa bool
  static Future<bool> getEmailVerify( String email ) async{
    final db =  await SQLHelper.db();
    final List<Map<String, Object?>> data =  await db.query('users', where: 'email = ?', whereArgs: [email], limit: 1);
    return data.isEmpty ? true : false ;
  }

  /// Obtiene todos registros de la tabla games por ingresados por un usuario .
  /// 
  /// Parámetros:
  /// - int userId
  /// 
  /// Devuelve:
  /// - Promesa de una lista de Objetos Map con un usuario en la tabla games o ninguno
  static Future<List<Map<String, Object?>>> getAllGames4User(int userId) async{
    final db =  await SQLHelper.db();
    return db.query('games', where: 'user_id = ?', whereArgs: [userId]);
  }

  /// Obtiene un registro de la tabla games por id.
  /// 
  /// Parámetros:
  /// - int id
  /// 
  /// Devuelve:
  /// - Promesa de una lista de Objetos Map con un Game en la tabla games o ninguno
  static Future<List<Map<String, Object?>>> getGame4SeachId(int searchId) async{
    final db =  await SQLHelper.db();
    return db.query('games', where: 'search_id = ?', whereArgs: [searchId], limit: 1);
  }

  //Metodos para actualizar registros en DB

  /// Actualiza un registro de la tabla users a partir de un objeto User.
  /// 
  /// Parámetros:
  /// - User user
  /// 
  /// Devuelve:
  /// - Pormesa int id del registro actualizado en la tabla users
  static Future<int> updateUser( User user) async{
    final db =  await SQLHelper.db();
    final data = user.toMap();
    final result =
      await db.update('users', data, where: "id = ?", whereArgs: [user.id]);
    return result;
  }

  /// Actualiza un registro de la tabla games a partir de un objeto Game.
  /// 
  /// Parámetros:
  /// - Game game
  /// 
  /// Devuelve:
  /// - Pormesa int id del registro actualizado en la tabla games
  static Future<int> updateGame( Game game) async{
    final db =  await SQLHelper.db();
    final data = game.toMap();
    final result =
      await db.update('games', data, where: "id = ?", whereArgs: [game.id]);
    return result;
  }

  //Metodos para borrar registros en DB

  /// Elinina un registro de la tabla users a partir de su id.
  /// 
  /// Parámetros:
  /// - int id
  /// 
  /// Devuelve:
  /// - Pormesa
  static Future<void> deleteUser(int id) async{
    final db =  await SQLHelper.db();
    try {
      await db.delete('users', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      print(e);
    }
  }

  /// Elinina un registro de la tabla games a partir de su search_id.
  /// 
  /// Parámetros:
  /// - int searchId
  /// 
  /// Devuelve:
  /// - Pormesa
  static Future<void> deleteGame4SearchId(int searchId) async{
    final db =  await SQLHelper.db();
    try {
      await db.delete('games', where: "search_id = ?", whereArgs: [searchId]);
    } catch (e) {
      print(e);
    }
  }
}
