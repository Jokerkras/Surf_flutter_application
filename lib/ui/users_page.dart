import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_surf_test/model/user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class UsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserPageState();

}

class _UserPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            FutureBuilder(
              future: http.get('https://jsonplaceholder.typicode.com/users'),
              builder: (context, snapshot) => _buildUserPage(context, snapshot),
            ),
      ),
    );
  }

  _retryLoading() {
    setState(() {
    });
  }

  Widget _showError() {
    return Container(
      height: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SvgPicture.asset("assets/warning-sign.svg"),
          Text('Не удалось загрузить информацию',
            style: TextStyle(
                fontSize: 16
            ),
          ),
          MaterialButton(
            elevation: 0,
            minWidth: 230,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
            ),
            child: Text('Обновить',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            color: Color.fromARGB(254, 155, 81, 224),
            disabledColor: Color.fromARGB(155, 155, 81, 224),
            onPressed: () => _retryLoading(),
          )
        ],
      ),
    );
  }

  Widget _showUsers(AsyncSnapshot snapshot) {
    List<dynamic> array = json.decode((snapshot.data as http.Response).body);

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          floating: false,
          pinned: true,
          elevation: 5,
          centerTitle: true,
          backgroundColor: Colors.white,
          expandedHeight: 132,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Пользователи', //TODO В развернутом состоянии должно быть левее
              style: TextStyle(fontSize: 18, color: Colors.black),),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
              array.map((data) => _buildRow(data)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRow(data) {
    User user = User.fromMap(data);
    return Row(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 21, vertical: 15),
            child: SvgPicture.asset("assets/bx-user-circle.svg")),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(user.name,
              style: TextStyle( fontSize: 20),),
            Text(user.email,
              style: TextStyle(fontSize: 13, color: Colors.grey)),
            Text(user.company,
              style: TextStyle(fontSize: 13),)
          ],
        )
      ],
    );
  }

  _buildUserPage(BuildContext context, snapshot) {
      if(snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasError) {
          return _showError();
        }
        return _showUsers(snapshot);
      } else {
        return CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(254, 155, 81, 224)),
        );
      }
  }
}