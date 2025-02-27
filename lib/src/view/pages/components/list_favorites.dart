import 'package:flutter/material.dart';
import 'card_game_edit.dart';

class ListFavorites extends StatefulWidget {
  final List<dynamic> favorites;
  final Function onPressed;

  const ListFavorites({
    super.key, 
    required this.favorites, 
    required this.onPressed
  });

  @override
  State<ListFavorites> createState() => _ListFavoritesState();
}

class _ListFavoritesState extends State<ListFavorites> {
  bool disableScroll = false;
  int count = 0;

  void changeDisable(bool value) {
    if (count < 2) {
      setState(() {
        disableScroll = value;
      });
    }
    value ? count++ : count--;
  }

  @override
  // metodo que construye un widget o elemento visual
  Widget build(BuildContext context) {
    return ListView(
      physics: disableScroll
          ? NeverScrollableScrollPhysics()
          : BouncingScrollPhysics(),
      children: [
        for (var game in widget.favorites)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: 
              CardGameEdit(
                item: game, 
                onPressed1: changeDisable,
                onPressed2: widget.onPressed
              )
          ),
      ],
    );
  }
}
