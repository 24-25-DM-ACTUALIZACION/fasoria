import 'package:flutter/material.dart';
import 'float_button_tr.dart';
import 'float_text_bottom.dart';
import 'flash_icon.dart';
import 'info_game.dart';
import '../../../controller/db_helper.dart';
import '../../../model/game.dart';

class CardGame extends StatefulWidget {
  
  const CardGame({
    super.key, 
    required this.liked, 
    required this.item,
    required this.userId, 
    required this.onPressed1, 
    required this.onPressed2
  });

  final bool liked;
  final dynamic item;
  final int userId;
  final Function onPressed1;
  final Function onPressed2;  

  @override
  State<CardGame> createState() => _CardGameState();
}

class _CardGameState extends State<CardGame> {
  bool iconLike = false;
  bool iconInfo = false;
  bool temporalIcon = false;
  bool isLoading = false;
  bool action = false;
  bool showInfo = false;


  void changeIconLike() async{
    widget.onPressed1(true);
    setState(() {
      isLoading = true;
      temporalIcon = true;
      iconLike = !iconLike;
    });
    if (action) {
      await SQLHelper.deleteGame4SearchId(widget.item['id']);
      
    } else {
      await SQLHelper.createGame(
        Game(userId: widget.userId, 
        searchId: widget.item['id'],
        title: widget.item['title'], 
        thumbnail: widget.item['thumbnail'], 
        genre: widget.item['genre'], 
        platform: widget.item['platform'], 
        releaseDate: DateTime.parse(widget.item['release_date']), 
        coment: '', 
        score: 0.0, 
        active: false)
      );
    }
    widget.onPressed2();
    setState(() {
      isLoading = false;
    });
    await Future.delayed(Duration(seconds: 1));
    widget.onPressed1(false);
    setState(() {
      action = !action;
      temporalIcon = false;
    });
  }

  void changeIconInfo() {
    setState(() {
      iconInfo = !iconInfo;
      showInfo = !showInfo;
    });
  }

  @override
  void initState() {
    super.initState();
    // Inicializa la variable con el valor de widget.liked
    iconLike = widget.liked;
    action = widget.liked;
  }

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Stack(
        alignment: Alignment.center, // Centra los widgets superpuestos
        children: [
          // Imagen de fondo
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'images/game1.jpg',
              fit: BoxFit.cover,
            ),
          ),
          if (showInfo)
            InfoGame(game: widget.item),
          FloatButonTR(
            icon: iconLike ? Icons.favorite : Icons.favorite_border,
            top: 5,
            right: 5,
            active: temporalIcon,
            onPressed: changeIconLike,
          ),
          FloatButonTR(
            icon: iconInfo ? Icons.info : Icons.info_outline,
            top: 65,
            right: 5,
            active: temporalIcon,
            onPressed: changeIconInfo,
          ), 
          if (!showInfo)
            FloatTextBottom(
              text: widget.item['title'],
              bottom: 10,
              left: 10,
              right: 10,
            ),
          if ( temporalIcon )
            FlasIcon(isLoading: isLoading, action: action)
        ],
      ),
    );
  }
}
