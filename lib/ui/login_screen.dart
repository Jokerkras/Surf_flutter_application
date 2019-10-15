
import 'package:flutter/material.dart';
import 'package:flutter_surf_test/ui/users_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{
  String _login;
  bool _isLoginBtnEnabled = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _emailController.addListener(() {
      _login = _emailController.text;
      setState(() {
        _isLoginBtnEnabled = _passwordController.value.text.isNotEmpty && _emailController.value.text.isNotEmpty;
      });
    });

    _passwordController.addListener(() {
      setState(() {
        _isLoginBtnEnabled = _passwordController.value.text.isNotEmpty && _emailController.value.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, //TODO Сделать так чтобы плднималось вверх и пряталась надпись вход
      backgroundColor: Colors.white,
      body: Stack (
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/bg.png",
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,),
          Positioned(
            top: 100,
            bottom: 15,
            left: 30,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  child: Text("Вход",
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    ),
                  ),
                  margin: EdgeInsets.only(bottom: 40),
                ),
                _buildCard(),
                  ]
              ),
            ),
          ]
        ),
      );
  }
  
  Widget _buildTextField(String text, TextEditingController controller, bool isHiden) {
    return TextFormField(
      controller: controller,
      obscureText: isHiden,
      decoration: InputDecoration(
          labelText: text,
      ),
    );
  }

  _callback() {
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => UsersPage(),
    ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  _buildCard() {
    return Card(
      elevation: 16,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 60),
        height: 250,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildTextField('Email', _emailController, false),
              _buildTextField('Пароль', _passwordController, true),
              MaterialButton(
                elevation: 0,
                minWidth: 230,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Text('Войти',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                color: Color.fromARGB(254, 155, 81, 224),
                disabledColor: Color.fromARGB(155, 155, 81, 224),
                onPressed: _isLoginBtnEnabled ? () => _callback() : null,
              ),
            ]
        ),
      ),
    );
  }
}