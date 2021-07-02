import 'package:bpr/Constants/general.dart';
import 'package:bpr/Presenter/userPresenter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  UserPresenter _presenter;

  _ForgotPassPageState() {
    _presenter = UserPresenter(null);
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController phonenoController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();

  final FocusNode _phonenoFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();

  @override
  void initState() {
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
        title: Text('Lupa Password',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
        elevation: 0.0,
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :
      Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 25,
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
                    _phonenoFocus.unfocus();
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
                        _presenter.forgotpassword('62${phonenoController.text}', emailController.text, context);
                      });
                    }
                  },//since this is only a UI app
                  child: Text('Continue',
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