import 'package:bpr/Constants/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactCSPage extends StatefulWidget {
  ContactCSPage({Key key}) : super(key: key);

  @override
  _ContactCSPageState createState() => _ContactCSPageState();
}

class _ContactCSPageState extends State<ContactCSPage> {
  @override
  void initState() {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact CS',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :
      ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.10,
              child: RaisedButton(
                onPressed: () {
                },
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('Whatsapp',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                      ]
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.10,
              child: RaisedButton(
                onPressed: () {
                },
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                ),
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('Email',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                      ]
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}