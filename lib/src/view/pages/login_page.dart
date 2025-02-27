import 'package:flutter/material.dart';

import 'components/content.dart';
import '../../controller/db_helper.dart';
import '../../controller/api_rest.dart';

class LoginPage extends StatefulWidget {
  //Esta clase es como la instancia del estado del Widget
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<Map<String, Object?>> userMap = [];

  bool _buttonDisable = false;
  List<dynamic> datos = []; 

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _appAcces(int userId, String userName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp(userId: userId, userName: userName, games: datos)),
    );
  }

  void _showMessage( String message){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
            message
          )
      ),
    );
  }

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;      
      userMap = await SQLHelper.getUser4EmailPass(email, password);
      if (userMap.isNotEmpty) {
        setState(() {
          _buttonDisable = true;
        });
        _emailController.text = '';
        _passwordController.text = '';
        _showMessage('Ingreso satisfactorio. Bienvenid@ ${userMap[0]['name']}');
        datos = await FetchData.getGamesLocal();
        await Future.delayed(Duration(seconds: 2));
        _appAcces(userMap[0]['id'] as int, userMap[0]['name'] as String);
      }else{
        _showMessage('No se han encontrado credenciales validas. Verifique su email y contraseña');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    SQLHelper.createInitDataUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor ingrese un correo, el campo no puede ser nulo.';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Ingrese un email valido.';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Contraseña'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor ingrese una contraseña, el campo no puede ser nulo.';
              }
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres por su seguridad.';
              }
              return null;
            },
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: _buttonDisable ? null: _loginUser,
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}
