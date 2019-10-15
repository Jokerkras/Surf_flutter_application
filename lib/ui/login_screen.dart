
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
      backgroundColor: Color.fromARGB(255, 232, 233, 237),
      body: Stack (
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset("assets/bg.png",
          fit: BoxFit.fitWidth,
          alignment: Alignment.topCenter,),
          Positioned(
            bottom: 50,
            left: 30,
            right: 30,
            top: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
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
                Card(
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
                            _buildTextField('Email', _emailController),
                            _buildTextField('Пароль', _passwordController),
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
                            )
                          ],
                        ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
  
  Widget _buildTextField(String text, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.0),
              borderSide: BorderSide(color: Colors.red)
          ),
          hintText: text,
          labelText: text
      ),
    );
  }

  _callback() {

  }
}