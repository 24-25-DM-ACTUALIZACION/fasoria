
///Game
///Atributos:
/// - int? id, int userId, int searchId, String title, String thumbnail, String genre, String plataform, String relaseDate, String coment, num score, bool active.
class Game {
  final int? id;
  final int userId;
  final int searchId;
  final String title;
  final String thumbnail;
  final String genre;
  final String platform;
  final DateTime releaseDate;
  final String coment;
  final num score;
  final bool active;

  Game({
    this.id, 
    required this.userId, 
    required this.searchId, 
    required this.title,
    required this.thumbnail,
    required this.genre, 
    required this.platform, 
    required this.releaseDate,
    required this.coment,
    required this.score,
    required this.active
  });

  /// Genera un Objeto Map clave valor con los atributos del Objeto Game sin el atributo id.
  /// 
  /// Devuelve:
  /// - Objeto Map.
  Map<String, Object> toMap() {
    return {
      'user_id': userId,
      'search_id': searchId,
      'title': title,
      'thumbnail': thumbnail,
      'genre': genre,
      'platform': platform,
      'release_date': releaseDate.toIso8601String().split('T')[0],
      'coment': coment,
      'score': score,
      'active': active? 1 : 0
    };
  }

  /// Genera un Objeto Game a partir de un Objeto Map que coincida con los atributos de Game.
  /// 
  /// Parametros:
  /// - Objeto Map
  /// 
  /// Devuelve:
  /// - Objeto Game
  factory Game.fromMap(Map<String, dynamic> map) {

    return Game(
      id: map['id'],
      userId: map['userId'],
      searchId: map['searchId'],
      title: map['title'],
      thumbnail: map['thumbnail'],
      genre: map['genre'],
      platform: map['platform'],
      releaseDate: DateTime.parse(map['releaseDate']),
      coment: map['coment'],
      score: map['score'],
      active: map['active'],
    );
  }
}