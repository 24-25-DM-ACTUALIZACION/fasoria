import 'package:flutter/material.dart';

class FlasIcon extends StatelessWidget {
  
  final bool isLoading; // Para controlar si la petición está en curso
  final bool action;

  const FlasIcon({
    super.key, 
    required this.isLoading, 
    required this.action
  }); // Para controlar si el icono de check debe mostrarse


  @override
  Widget build(BuildContext context) {

    return  Positioned(
      left: 10,
      right: 10,
      child: Center(
        child: isLoading ? 
        CircularProgressIndicator() : 
        Icon( action ? Icons.delete : Icons.save, color: action ? Colors.red : Colors.green)
      ),
    );
  }
}


