
///User
///Atributos:
/// - int? id, String name, String lastname, String email, String password, 
class User {
  final int? id;
  final String name;
  final String lastname;
  final String email;
  final String password;

  User({this.id, required this.name, required this.lastname, required this.email, required this.password});

  /// Genera un Objeto Map clave valor con los atributos del Objeto User sin el atributo id.
  /// 
  /// Devuelve:
  /// - Objeto Map.
  Map<String, Object> toMap() {
    return {'name': name, 'lastname': lastname, 'email': email, 'password': password};
  }

  /// Genera un Objeto Usuario a partir de un Objeto Map que coincida con los atributos de Usuario.
  /// 
  /// Parametros:
  /// - Objeto Map 
  /// 
  /// Devuelve:
  /// - Objeto User
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      lastname: map['lastname'],
      email: map['email'],
      password: map['password'],
    );
  }
}

// User u1 = User(id: 0, name: 'Fausto', lastname: 'Soria', email: 'fass@gmail.com', password: 'fass3425');
// Map<String, dynamic> user = u1.toMap();
// User us = User.fromMap(user);
