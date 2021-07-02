import 'package:bpr/Constants/constants.dart';
import 'package:bpr/Constants/general.dart';
import 'package:bpr/Presenter/userPresenter.dart';
import 'package:bpr/UI/Main/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TabunganPage extends StatefulWidget {
  String tokenUser;

  TabunganPage({Key key, @required this.tokenUser,}) : super(key: key);

  @override
  _TabunganPageState createState() => _TabunganPageState();
}

class _TabunganPageState extends State<TabunganPage> {
  UserPresenter _presenter;

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  _TabunganPageState() {
    _presenter = UserPresenter(null);
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _presenter.getData(widget.tokenUser, context);
    });

    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 175.0,
                width: double.infinity,
                color: Colors.white,
              ),
              Positioned(
                  bottom: 150,
                  left: -40,
                  child: Container(
                    height: 140,
                    width: 140,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(70),
                        color: Colors.grey.withOpacity(0.1)),
                  )),
              /*Positioned(
                  top: -120,
                  left: 100,
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(150),
                        color: Colors.grey.withOpacity(0.1)),
                  )),*/
              Positioned(
                  top: -150,
                  left: 0,
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey.withOpacity(0.1)),
                  )),
              Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(75),
                        color: Colors.grey.withOpacity(0.1)),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Saldo Tabungan",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Text('${MoneyFormatter(amount: user.Value.balance.toInt()).compact}',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black.withOpacity(0.70),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}