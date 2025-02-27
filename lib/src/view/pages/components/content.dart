import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/db_helper.dart';

import '../../main_page.dart';
import 'list_games.dart';
import 'list_favorites.dart';

// widget principal de la aplicacion
class MyApp extends StatelessWidget {
  
  const MyApp({
      super.key, required this.userId, 
      required this.userName,
      required this. games, 
    }); //constructor

  final int userId;
  final String userName;
  final List<dynamic> games;

  @override
  // metodo que construye un widget
  Widget build(BuildContext context) {
    print('$userName el usuario #$userId');
    return ChangeNotifierProvider(
      //este metodo retorna un widget cada vez que el estado de la app cambia
      //
      create: (context) =>
        MyAppState(), //se asignan los estados de para volver a renderizar
        child: MaterialApp(
        title: 'Juegos Indi informacion',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        home: MyHomePage(games: games, userId: userId),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {//clase que verifica los estados de la aplicacion
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners(); //informa al widget que esta observando los estados
  }

  var favoritos = <WordPair>[];
  void toggleFavorito() {
    if (favoritos.contains(current)) {
      favoritos.remove(current);
    } else {
      favoritos.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {

  final List<dynamic> games;
  final int userId;

  const MyHomePage({
    super.key, required this.games, 
    required this.userId
  });
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}



class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0; //variable que controla a la pagina que dirige el appbar
  List<dynamic> favorites = [];
  bool drawListGames = false;
  
  void getFavorites () async{
    favorites = await SQLHelper.getAllGames4User(widget.userId);
    setState(() {
      drawListGames = true;
      print(favorites.length);
    });
  }
  
  @override  
  void initState() {
    super.initState();
    getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = drawListGames ?
          ListGames(
            games: widget.games.sublist(0, 20),
            userId: widget.userId,
            favorites: favorites,
            onPressed: getFavorites,
          ) :
          CircularProgressIndicator() ;
        break;
      case 1:
        page = ListFavorites(
          favorites: favorites, 
          onPressed: getFavorites);
        break;
      case 2:
        page = LogOut();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(builder: (context, constrains) {
      return Scaffold(
        body: Row(
          children: [
            SafeArea(
              child: NavigationRail(
                extended: constrains.maxWidth >= 600,
                destinations: [
                  NavigationRailDestination(
                    icon: Icon(Icons.home),
                    label: Text('Home'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.favorite),
                    label: Text('Favorites'),
                  ),
                  NavigationRailDestination(
                    icon: Icon(Icons.exit_to_app),
                    label: Text('Logout'),
                  ),
                ],
                selectedIndex: selectedIndex,
                onDestinationSelected: (value) {
                  setState(() {
                    selectedIndex = value;
                    getFavorites();
                  });
                },
              ),
            ),
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}


class LogOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Desea salir de su cuenta'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              },
              child: Text('Salir'),
            ),
          ],
        ),
      ),
    );
  }
}
