import 'package:bpr/Constants/general.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:bpr/UI/Widgets/custom_shape.dart';
import 'package:bpr/Constants/constants.dart';
import 'package:bpr/Presenter/userPresenter.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  UserPresenter _presenter;

  _SignupPageState() {
    _presenter = UserPresenter(null);
  }

  final _formKey = GlobalKey<FormState>();
  bool passVisible, confirmpassVisible;
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController phonenoController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final TextEditingController confirmpassController = new TextEditingController();

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phonenoFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  final FocusNode _confirmpassFocus = FocusNode();

  @override
  void initState() {
    passVisible = true;
    confirmpassVisible = true;
    isLoading = false;
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Akun',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        elevation: 0.0,
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :
      Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 45,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                color: Colors.white,
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Nama harus diisi';
                    }
                    return null;
                  },
                  controller: nameController,
                  focusNode: _nameFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _nameFocus, _emailFocus);
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: "Nama",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: Material(
                        color: Colors.transparent,
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 15.8)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                color: Colors.white,
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      // The form is empty
                      return "Email harus diisi";
                    }
                    // This is just a regular expression for email addresses
                    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
                        "\\@" +
                        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
                        "(" +
                        "\\." +
                        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
                        ")+";
                    RegExp regExp = new RegExp(p);

                    if (regExp.hasMatch(value)) {
                      // So, the email is valid
                      return null;
                    }

                    // The pattern of the email didn't match the regex above.
                    return 'Email tidak valid';
                  },
                  controller: emailController,
                  focusNode: _emailFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _emailFocus, _phonenoFocus);
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: Material(
                        color: Colors.transparent,
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 15.8)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                color: Colors.white,
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value.length < 9)
                      return 'Nomor Ponsel minimal 9 digit';
                    else
                      return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if (value.substring(0,1) == '0') {
                        phonenoController.clear();
                      } else if (value.substring(0,2) == '62') {
                        phonenoController.clear();
                      }
                    });
                  },
                  controller: phonenoController,
                  focusNode: _phonenoFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _phonenoFocus, _passFocus);
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    WhitelistingTextInputFormatter.digitsOnly
                  ],
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: "Nomor Ponsel",
                      prefixText: "+62",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: Material(
                        color: Colors.transparent,
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.phone_android,
                          color: Colors.black,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 25, vertical: 15.8)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                color: Colors.white,
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Password harus diisi';
                    }
                    return null;
                  },
                  controller: passController,
                  obscureText: passVisible,
                  focusNode: _passFocus,
                  onFieldSubmitted: (value){
                    _fieldFocusChange(context, _passFocus, _confirmpassFocus);
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: Material(
                        color: Colors.transparent,
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.lock_open,
                          color: Colors.black,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          passVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            passVisible = !passVisible;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15.8)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Material(
                color: Colors.white,
                elevation: 2.0,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller: confirmpassController,
                  obscureText: confirmpassVisible,
                  focusNode: _confirmpassFocus,
                  validator: (val){
                      if(val.isEmpty)
                        return 'Data Kosong';
                      if(val != passController.text)
                        return 'Tidak Sama';
                      return null;
                    },
                  onFieldSubmitted: (value){
                    _confirmpassFocus.unfocus();
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: "Konfirmasi Password",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      prefixIcon: Material(
                        color: Colors.transparent,
                        elevation: 0,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        child: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          confirmpassVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            confirmpassVisible = !confirmpassVisible;
                          });
                        },
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 15.8)),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Container(
                height: 50.0,
                /*padding: EdgeInsets.symmetric(horizontal: 15.0),*/
                margin: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        isLoading = true;
                        _presenter.regis('0${phonenoController.text}', nameController.text, emailController.text, passController.text, context);
                      });
                    }
                  },//since this is only a UI app
                  child: Text('Buat Akun',
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
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }

  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}