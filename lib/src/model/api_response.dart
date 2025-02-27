//ApiResponse Objeto modelo para la peticion a la api
///Atributos:
/// - int? id
/// - String title
/// - String thumbnail
/// - String shortDescription
/// - String gameUrl
/// - String genre
/// - String platform
/// - String publisher
/// - String developer
/// - String relaseDate
/// - String freetogameProfileUrl
class ApiResponse{
  final int id;
  final String title;
  final String thumbnail;
  final String shortDescription;
  final String gameUrl;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String releaseDate;
  final String freetogameProfileUrl;

  ApiResponse({ //constructor
    required this.id,
    required this.title, 
    required this.thumbnail,
    required this.shortDescription,
    required this.gameUrl,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.freetogameProfileUrl,
  });

  /// Genera un Objeto Map clave valor con los atributos del Objeto ApiResponse.
  /// 
  /// Devuelve:
  /// - Objeto Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'shortDescription': shortDescription,
      'gameUrl': gameUrl,
      'genre': genre,
      'platform': platform,
      'publisher': publisher,
      'developer': developer,
      'releaseDate': releaseDate,
      'freetogameProfileUrl': freetogameProfileUrl,
    };
  }

  /// Genera un Objeto ApiResponse a partir de un Objeto Map que coincida con los atributos de ApiResponse.
  /// 
  /// Parametros:
  /// - Objeto Map
  /// 
  /// Devuelve:
  /// - Objeto ApiResponse
  factory ApiResponse.fromMap(Map<String, dynamic> map) {
    return ApiResponse(
      id: map['id'],
      title: map['title'],
      thumbnail: map['thumbnail'],
      shortDescription: map['shortDescription'],
      gameUrl: map['gameUrl'],
      genre: map['genre'],
      platform: map['platform'],
      publisher: map['publisher'],
      developer: map['developer'],
      releaseDate: map['releaseDate'],
      freetogameProfileUrl: map['freetogameProfileUrl'],
    );
  }
}