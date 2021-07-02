import 'package:bpr/Constants/general.dart';
import 'package:bpr/Presenter/pengajuanPresenter.dart';
import 'package:bpr/Constants/constants.dart';
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

class PengajuanPage extends StatefulWidget {
  String tokenUser;

  PengajuanPage({Key key, @required this.tokenUser}) : super(key: key);

  @override
  _PengajuanPageState createState() => _PengajuanPageState();
}

class _PengajuanPageState extends State<PengajuanPage>  implements PengajuanAbstract {
  PengajuanPresenter _presenter;

  _PengajuanPageState() {
    _presenter = PengajuanPresenter(this);
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController jumlahPinjamanController = new TextEditingController();
  final TextEditingController lamaPinjamanController = new TextEditingController();

  final FocusNode _jumlahPinjamanFocus = FocusNode();
  final FocusNode _lamaPinjamanFocus = FocusNode();

  List<DropdownMenuItem<String>> _dropDownPeruntukan;
  List<DropdownMenuItem<String>> _dropDownJaminan;

  @override
  void initState() {
    /*_dropDownPeruntukan = getDropDownMenuItems();*/
    /*_dropDownJaminan = getDropDownMenuItems();*/
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
        title: Text('Pengajuan Pinjaman',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :
      Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
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
                          'Peruntukan Pinjaman',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 2.0),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  hint: Text('Pilih Peruntukan Pinjaman'),
                  validator: (value) {
                    if (value == null) {
                      return 'Peruntukan Pinjaman harus dipilih';
                    }
                    return null;
                  },
                  value: currentPeruntukan,
                  items: _dropDownPeruntukan,
                  onChanged: changedDropDownPeruntukan,
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
                          'Jumlah Pinjaman',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 2.0),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Flexible(
                      child: new TextFormField(
                        validator: (value) {
                          if (value.isEmpty || value == "0") {
                            return 'Jumlah Pinjaman harus diisi';
                          }
                          return null;
                        },
                        controller: jumlahPinjamanController,
                        focusNode: _jumlahPinjamanFocus,
                        onFieldSubmitted: (value){
                          _fieldFocusChange(context, _jumlahPinjamanFocus, _lamaPinjamanFocus);
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: "Masukkan Jumlah Pinjaman",
                        ),
                      ),
                    ),
                  ],
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
                          'Lama Pinjaman',
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
                            return 'Lama Pinjaman harus diisi';
                          }
                          return null;
                        },
                        controller: lamaPinjamanController,
                        focusNode: _lamaPinjamanFocus,
                        onFieldSubmitted: (value){
                          _lamaPinjamanFocus.unfocus();
                        },
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                          hintText: "Masukkan Lama Pinjaman",
                        ),
                      ),
                    ),
                  ],
                )
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 25),
              child: Container(
                height: 50.0,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {

                      });
                    } //since this is only a UI app
                  },
                  child: Text('Kalkulasi',
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
            detailView(),
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
                          'Jenis Jaminan',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 2.0),
                child: DropdownButtonFormField(
                  isExpanded: true,
                  hint: Text('Pilih Jenis Jaminan'),
                  validator: (value) {
                    if (value == null) {
                      return 'Jenis Jaminan harus dipilih';
                    }
                    return null;
                  },
                  value: currentJaminan,
                  items: _dropDownJaminan,
                  onChanged: changedDropDownJaminan,
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
                          'Foto Jaminan',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                )),
            Padding(
                padding: EdgeInsets.only(
                    left: 25.0, right: 25.0, top: 2.0),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 25),
              child: Container(
                height: 50.0,
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                margin: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {

                      });
                    } //since this is only a UI app
                  },
                  child: Text('Ajukan',
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
          ],
        ),
      ),
    );
  }

  Widget detailView(){
    return new Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text("Detail",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .apply(color: Colors.white, fontWeightDelta: 2),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Divider(
              height: 31,
              color: Colors.white,
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:  Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 5.0,
                    runSpacing: 10.0,
                    children: <Widget>[
                      Container(
                        child: Text('Data',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                        alignment: Alignment.centerLeft,
                      ),
                      /*Divider(
                        height: 11,
                        color: Colors.black,
                      ),*/
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Pokok Pinjaman',
                              style: TextStyle(color: Colors.black)),
                          Text('Bunga Pertahun',
                              style: TextStyle(color: Colors.black)),
                          Text('Tenor Pinjaman',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(':',
                              style: TextStyle(color: Colors.black)),
                          Text(':',
                              style: TextStyle(color: Colors.black)),
                          Text(':',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('',
                              style: TextStyle(color: Colors.black)),
                          Text('',
                              style: TextStyle(color: Colors.black)),
                          Text('',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Container(
                        child: Text('Cicilan Pokok',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                        alignment: Alignment.centerLeft,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${''} : ${''}',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('=',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Container(
                        child: Text('Bunga',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                        alignment: Alignment.centerLeft,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('(${''} x ${''}%) : ${''} bulan',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('=',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${''}',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Container(
                        child: Text('Angsuran per Bulan',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                        alignment: Alignment.centerLeft,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${''} + ${''}',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text('=',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${''}',
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ),
        ]
    );
  }

  void changedDropDownPeruntukan(String selectedPeruntukan) {
    setState(() {
      currentPeruntukan = selectedPeruntukan;
    });
  }

  void changedDropDownJaminan(String selectedJaminan) {
    setState(() {
      currentJaminan = selectedJaminan;
    });
  }
}