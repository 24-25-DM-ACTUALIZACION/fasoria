import 'package:flutter/material.dart';
import 'card_game.dart';

class ListGames extends StatefulWidget {
  const ListGames(
      {super.key,
      required this.games,
      required this.userId,
      required this.favorites,
      required this.onPressed});

  final List<dynamic> games;
  final int userId;
  final List<dynamic> favorites;
  final Function onPressed;

  @override
  State<ListGames> createState() => _ListGamesState();
}

class _ListGamesState extends State<ListGames> {
  bool disableScroll = false;
  int count=0;

  bool verifyLiked(int gameId) {
    for (var favorite in widget.favorites) {
      if (gameId == favorite['search_id']) {
        return true;
      }
    }
    return false;
  }

  void changeDisable(bool value) {
    if (count < 2) {
      setState(() {
        
        disableScroll = value;
      });
    }
    value ? count++ : count--;
  }

  @override
  // metodo que construye un widget
  Widget build(BuildContext context) {
    return ListView(
      physics: disableScroll
          ? NeverScrollableScrollPhysics()
          : BouncingScrollPhysics(),
      children: [
        for (var game in widget.games)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CardGame(
              liked: verifyLiked(game['id']),
              item: game,
              userId: widget.userId,
              onPressed1: changeDisable,
              onPressed2: widget.onPressed,
            ),
          ),
      ],
    );
  }
}
