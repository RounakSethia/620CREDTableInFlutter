import 'package:flutter/material.dart';

import 'registration.dart';
import '../controllers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.red),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType { login, register }

class _LoginPageState extends State<Login> {
  final TextEditingController _emailFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType.login;

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: _buildBar(context),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Container(
            child: TextField(
              controller: _emailFilter,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ),
          Container(
            child: TextField(
              controller: _passwordFilter,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      child: Column(
        children: <Widget>[
          ElevatedButton(
            child: Text('Login'),
            onPressed: _loginAccount,
          ),
          TextButton(
            child: const Text('Dont have an account? Tap here to register.'),
            onPressed: _SignUpPage,
          )
        ],
      ),
    );
  }

  void _loginAccount() {
    print(_email);
    print(_password);
    AuthController.instance.loginUser(_email, _password);
  }

  void _SignUpPage() {
    print('_SignUpPage');
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => SignUp())));
  }
}
