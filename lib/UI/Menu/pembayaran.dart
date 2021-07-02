import 'package:bpr/Constants/general.dart';
import 'package:bpr/Constants/constants.dart';
import 'package:bpr/Presenter/pembayaranPresenter.dart';
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

class PembayaranPage extends StatefulWidget {
  String tokenUser;
  String nasabah_no;

  PembayaranPage({Key key, @required this.tokenUser, @required this.nasabah_no}) : super(key: key);

  @override
  _PembayaranPageState createState() => _PembayaranPageState();
}

class _PembayaranPageState extends State<PembayaranPage> {
  PembayaranPresenter _presenter;

  _PembayaranPageState() {
    _presenter = PembayaranPresenter();
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nominalController = new TextEditingController();

  final FocusNode _nominalFocus = FocusNode();

  List<DropdownMenuItem<String>> _dropDownAngsuran;

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _presenter.getPinjaman(widget.tokenUser, widget.nasabah_no, context);
    });

    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    _dropDownAngsuran = _presenter.getDropDownMenuItems();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :
      Form(
        key: _formKey,
        child: SmartRefresher(
          controller: _refreshController,
          child: ListView(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'Angsuran',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                  child: DropdownButtonFormField(
                    isExpanded: true,
                    hint: Text('Pilih Angsuran'),
                    validator: (value) {
                      if (value == null) {
                        return 'Angsuran harus dipilih';
                      }
                      return null;
                    },
                    value: currentAngsuran,
                    items: _dropDownAngsuran,
                    onChanged: changedDropDownAngsuran,
                    /*decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                    ),*/
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: 25.0, right: 25.0, top: 25.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'Upload Bukti Pembayaran',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: 25.0, right: 25.0, top: 25.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          new Text(
                            'Nominal Pembayaran',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
                  child: new Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      new Flexible(
                        child: new TextFormField(
                          validator: (value) {
                            if (value.isEmpty || value == "0") {
                              return 'Nominal Pembayaran harus diisi';
                            }
                            return null;
                          },
                          controller: nominalController,
                          focusNode: _nominalFocus,
                          onFieldSubmitted: (value){
                            _nominalFocus.unfocus();
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          decoration: const InputDecoration(
                            hintText: "Masukkan Nominal Pembayaran",
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ],
          ),
          onRefresh: refreshList,
          physics: BouncingScrollPhysics(),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 25),
        child: Container(
          height: 50.0,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          margin: EdgeInsets.only(top: 20.0),
          child: RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                setState(() {
                  _presenter.Pembayaran(widget.tokenUser, currentAngsuran, nominalController.text, '', context);
                });
              } //since this is only a UI app
            },
            child: Text('Bayar',
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
    );
  }

  void changedDropDownAngsuran(String selectedAngsuran) {
    setState(() {
      currentAngsuran = selectedAngsuran;
    });
  }
}