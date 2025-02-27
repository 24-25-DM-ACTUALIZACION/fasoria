import 'package:flutter/material.dart';

class FloatTextBottom extends StatelessWidget {
  const FloatTextBottom({
    super.key,
    required this.text,
    required this.bottom,
    required this.left,
    required this.right,
  });

  final String text;
  final double bottom;
  final double left;
  final double right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      left: left,
      right: right,          
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          color: const Color.fromARGB(103, 0, 0, 0), // Fondo semitransparente
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}