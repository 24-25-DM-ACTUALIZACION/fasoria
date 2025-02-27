import 'package:flutter/material.dart';

class FloatButonTR extends StatelessWidget {
  
  final IconData icon;
  final double right;
  final double top;
  final bool active;
  final Function onPressed;

  const FloatButonTR({
    super.key,
    required this.icon,
    required this.right,
    required this.top,
    required this.onPressed, 
    required this.active
  });


  @override
  Widget build(BuildContext context) {

    return Positioned(
      top: top,
      right: right,
      child: FloatingActionButton(
        heroTag: context,
        onPressed: active ? 
        null
        : (){
          onPressed();
        } ,
        tooltip: '',
        child: Icon(icon),
      ),
    );
  }
}