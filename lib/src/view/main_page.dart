import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/login_page.dart';
import 'pages/create_account_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key}); //constructor

  @override
  // metodo que construye un widget 
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(  //este metodo retorna un widget cada vez que el estado de la app cambia
    //
      create: (context) => MainPageState(),  //se asignan los estados para volver a renderizar
      child: MaterialApp(
        title: 'Login and Data',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: LayoutMainPage(),
      ),
    );
  }
}

class MainPageState extends ChangeNotifier { //clase que verifica los estados de la aplicacion
  var _panelSelected = 'Login';

  void setTitle ( String title){
    _panelSelected = title;
    notifyListeners();
  }
}

class LayoutMainPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var mainState = context.watch<MainPageState>();
    Widget page;
    switch (mainState._panelSelected) {
      case 'Login':
        page = LoginPage();
      break;
      case 'Crear Cuenta':
        page = CreateAccountPage();
      break;
      default:
      throw UnimplementedError('null widget');
    }

    return Scaffold(
      appBar:  AppBar(title: Text(mainState._panelSelected)),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  mainState.setTitle('Login');
                },
                child: Text('Ingresar Credenciales'),
              ),
              SizedBox(width: 32),
              ElevatedButton(
                onPressed: () {
                  mainState.setTitle('Crear Cuenta');
                },
                child: Text('Crear Cuenta'),
              ),
            ],
          ),
          SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child:  page, //llamando al componente de vista deseado
          ),
        ],
      ),
    );
  }
}




