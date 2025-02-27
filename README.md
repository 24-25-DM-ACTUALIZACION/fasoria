# indi_games_crud

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Notas del desarrollador

Para realizar este proyecto he utilizado Sqlite, con una version para javascript, esto debido a algunos problemas.
- No disponía del hardware suficiente para correr el emulador de Android en el equipo de desarrollo por lo cual no podía testear la aplicación.
- Solo podía testear la aplicacion en un navegador Web así que se utilizó una libreria Sqlite de javascript.
- La librería sqflite para javascrip tiene un conflicto con la librería sqflite para android, si la aplicación se ejecuta en un emulador Android se debe remover la librería sqflite javascript antes de compilar la aplicación y eliminar las referencias a esta librería.
-En el archivo main.dart que inicia la aplicación se encuentra (import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';) y un condicional como únicas referencias a la librería sqflite javascript los cuales deberian eliminarse para desplegar la aplicación en Android.
Primer usuario: fass@uce.edu.ec  contraseña: fass3425
Segundo usuario: alfa@uce.edu.ec contraeña: alfa3425
