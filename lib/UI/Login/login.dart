import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bpr/UI/Login/forgotpass.dart';
import 'package:bpr/UI/Login/signup.dart';
import 'package:bpr/Constants/general.dart';
import 'package:toast/toast.dart';
import 'package:bpr/Presenter/userPresenter.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserPresenter _presenter;

  _LoginPageState() {
    _presenter = UserPresenter(null);
  }

  bool passwordVisible;
  final TextEditingController userController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final FocusNode _userFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void initState() {
    bool _isLoading = false;
    passwordVisible = true;
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height/2.5,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16)
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/full-bloom.png'),
                  )
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    height: 35,
                    child: Text('BPR',style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: 50,
                    height: 40,
                    child: Icon(
                      Icons.person,
                      color: Colors.black,),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent
                    ),
                  ),
                ],
              ),
            ),
            Container(
              /*height: MediaQuery.of(context).size.height/1.92,*/
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(23),
                child: Column(
                  children: <Widget>[
                    /*Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Container(
                        color: Color(0xfff5f5f5),
                        child: TextFormField(
                          controller: userController,
                          focusNode: _userFocus,
                          onFieldSubmitted: (term) {
                            _fieldFocusChange(context, _userFocus, _passwordFocus);
                          },
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person_outline),
                              labelStyle: TextStyle(
                                  fontSize: 15
                              )
                          ),
                        ),
                      ),
                    ),*/
                    Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Material(
                          color: Colors.white,
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            controller: userController,
                            focusNode: _userFocus,
                            onFieldSubmitted: (term) {
                              _fieldFocusChange(context, _userFocus, _passwordFocus);
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                hintText: 'Nomor Ponsel',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                prefixIcon: Material(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                  ),
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15.8)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Material(
                          color: Colors.white,
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: TextFormField(
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            controller: passwordController,
                            obscureText: passwordVisible,
                            focusNode: _passwordFocus,
                            onFieldSubmitted: (value){
                              _passwordFocus.unfocus();
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                prefixIcon: Material(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  child: Icon(
                                    Icons.lock_open,
                                    color: Colors.black,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15.8)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.96,
                      height: 50.0,
                      /*padding: EdgeInsets.symmetric(horizontal: 15.0),*/
                      margin: EdgeInsets.only(top: 40.0),
                      child: RaisedButton(
                        onPressed: () {
                            setState(() {
                              isLoading = true;
                              _presenter.signIn(userController.text, passwordController.text, context);
                            });
                        },//since this is only a UI app
                        child: Text('Login',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                height: 20.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassPage()));
                      },
                      child: Text("Lupa Password?",
                        style: TextStyle(color:Colors.white,
                            fontWeight: FontWeight.w500,fontSize: 12, decoration: TextDecoration.underline),),
                    ),
                  ],
                )
            ),
            Container(
                height: 20.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("atau", style: TextStyle(color:Colors.white,fontSize: 12 ,fontWeight: FontWeight.normal),),
                  ],
                )
            ),
            Container(
                height: 20.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Belum Membuat Akun?", style: TextStyle(color:Colors.white,fontSize: 12 ,fontWeight: FontWeight.normal),),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          isLoading = true;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                      },
                      child: Text("Daftar Sekarang",
                        style: TextStyle(color:Colors.white,
                            fontWeight: FontWeight.w500,fontSize: 12, decoration: TextDecoration.underline),),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}