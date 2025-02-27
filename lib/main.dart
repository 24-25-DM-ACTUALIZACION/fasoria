import 'package:flutter/material.dart';

import 'src/view/main_page.dart';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart';

void main() {

  if (kIsWeb) {
    // Web: usa la implementación de `sqflite_common_ffi_web`
      databaseFactory = databaseFactoryFfiWeb;
  } 
  runApp(MainPage());
}
