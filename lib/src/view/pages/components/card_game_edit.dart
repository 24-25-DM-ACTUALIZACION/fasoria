import 'package:flutter/material.dart';
import 'float_button_tr.dart';
import 'float_text_bottom.dart';
import 'info_game.dart';
import '../../../controller/db_helper.dart';

class CardGameEdit extends StatefulWidget {
  const CardGameEdit(
      {super.key,
      required this.item,
      required this.onPressed1,
      required this.onPressed2});

  final dynamic item;
  final Function onPressed1;
  final Function onPressed2;

  @override
  State<CardGameEdit> createState() => _CardGameEditState();
}

class _CardGameEditState extends State<CardGameEdit> {
  // bool temporalIcon = false;
  bool isLoading = false;
  bool showInfo = false;
  bool buttonsDisable = false;

  void deleteGame() async {
    try {
      widget.onPressed1(true); //activa la restriccion de scrool en la lista
      setState(() {
        isLoading = true;
        buttonsDisable = true;
      });
      await SQLHelper.deleteGame4SearchId(
          widget.item['search_id']); //elimina registro de juego
      setState(() {
        isLoading = false;
      });
      setState(() {
        buttonsDisable = false;
      });
      widget.onPressed1(false);
      widget.onPressed2(); //actualiza la lista en la pagina principal
    } catch (e) {
      print('hubo un error $e');
    }
  }

  void changeIconInfo() {
    setState(() {
      showInfo = !showInfo;
    });
  }

  Widget iconFlash() {
    return Positioned(
      left: 10,
      right: 10,
      child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Icon(Icons.delete, color: Colors.red)),
    );
  }

  /* @override
  void initState() {
    super.initState();
    // Inicializa la variable con el valor de widget.liked
  } */

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
          if (showInfo) InfoGame(game: widget.item),
          FloatButonTR(
            icon: Icons.delete,
            top: 5,
            right: 5,
            active: buttonsDisable,
            onPressed: deleteGame,
          ),
          FloatButonTR(
            icon: showInfo ? Icons.info : Icons.info_outline,
            top: 65,
            right: 5,
            active: buttonsDisable,
            onPressed: changeIconInfo,
          ),
          FloatButonTR(
            icon: Icons.edit,
            top: 125,
            right: 5,
            active: buttonsDisable,
            onPressed: () {},
          ),
          if (!showInfo)
            FloatTextBottom(
              text: widget.item['title'],
              bottom: 10,
              left: 10,
              right: 65,
            ),
          if (buttonsDisable) iconFlash()
        ],
      ),
    );
  }
}


