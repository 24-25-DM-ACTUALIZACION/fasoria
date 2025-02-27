import 'package:flutter/material.dart';

class InfoGame extends StatelessWidget {
  const InfoGame({
    super.key,
    
    required this.game
  });

  final dynamic game;

  Widget info ( String texto, double fontzise, bool center , bool bold ){
    return Text(
      texto,
      textAlign: center ? TextAlign.center : TextAlign.left,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontzise,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
      softWrap: true,
      overflow: TextOverflow.visible,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      bottom: 0,
      right: 65,
      left: 0,
      child: Card(
        color: Color.fromARGB(120, 0, 0, 0),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                info('Título: ${game['title']}', 16, true, true),
                info('Plataforma: ${game['platform']}', 10, true, true),
                info('Género: ${game['genre']}', 10, true, true),
                info('Desarrollador: ${game['developer']}', 10, false, false),
                info('Dia de lanzamiento: ${game['release_date']}', 10, true, true),
                info('Enlace: ${game['game_url']}', 10, true, false),
                info('Descripción: ${game['short_description']}', 12, false, false),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
