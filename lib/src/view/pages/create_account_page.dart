import 'package:flutter/material.dart';

import '../../controller/db_helper.dart';
import '../../model/user.dart';

class CreateAccountPage extends StatefulWidget {
  //Esta clase es como la instancia del estado del Widget
  @override
  State<CreateAccountPage> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text(message)),
    );
  }

  Future<void> _createUser() async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String lastname = _lastNameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      bool verifyEmail = await SQLHelper.getEmailVerify(email);

      if (verifyEmail) {
        User auxUser = User(
          name: name, lastname: lastname, email: email, password: password
        );
        int id = await SQLHelper.createUser(auxUser);
        _nameController.text = '';
        _lastNameController.text = '';
        _emailController.text = '';
        _passwordController.text = '';
        _showMessage('${auxUser.name}, su cuenta de usuario se ha creado correctamente.');
        print(id);
      }
      else{
        _showMessage('La dirección de email ingresada ya esta registrada. Inténtelo con otra dirección de email');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Nombre'),
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor ingrese un nombre, el campo no puede ser nulo.';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(labelText: 'Apellido'),
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor ingrese su apellido, el campo no puede ser nulo.';
              }
              return null;
            },
          ),
          SizedBox(height: 32),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor ingrese su email, el campo no puede ser nulo.';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Ingerese un email válido.';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Porfavor ingrese su contraseña, el campo no puede ser nulo.';
              }
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres por su seguridad.';
              }
              return null;
            },
          ),
          SizedBox(height: 32),
          ElevatedButton(
            onPressed: _createUser,
            child: Text('Crear'),
          ),
        ],
      ),
    );
  }
}
