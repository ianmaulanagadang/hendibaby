import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bpr/UI/Main/drawer.dart';
import 'package:bpr/Constants/general.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    var userAva = prefs.getString("key");
    if (userAva != null) {
      user = new User.fromJson(json.decode(prefs.getString("key")));
    }

    if (userAva == null) {*/
      Navigator.of(context).pushReplacementNamed('/login');
    /*} else {
      Navigator.of(context).pushReplacementNamed('/home',
        arguments: DrawerPage(tokenUser: null, nasabah_no: null, phoneNumber:null,),
      );
    }*/
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: new Image.asset(
                    'assets/images/logo.png',
                    height: 25.0,
                    fit: BoxFit.scaleDown,
                  ))
            ],
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40,
                    ),
                    Icon(
                      Icons.credit_card,
                      color: Colors.white,
                      size: 150,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "BPR",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
                width: double.infinity,
                height: 300,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
