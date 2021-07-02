import 'package:bpr/Constants/constants.dart';
import 'package:bpr/Constants/general.dart';
import 'package:bpr/Model/pinjamanModel.dart';
import 'package:bpr/Presenter/pinjamanPresenter.dart';
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

class DaftarPinjamanPage extends StatefulWidget {
  String tokenUser;
  String nasabah_no;
  bool appBarAva;

  DaftarPinjamanPage({Key key, @required this.tokenUser, @required this.nasabah_no, @required this.appBarAva,}) : super(key: key);

  @override
  _DaftarPinjamanPageState createState() => _DaftarPinjamanPageState();
}

class _DaftarPinjamanPageState extends State<DaftarPinjamanPage> implements PinjamanAbstract {
  PinjamanPresenter _presenter;

  _DaftarPinjamanPageState() {
    _presenter = PinjamanPresenter(this, null);
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<PinjamanValue> _listFinalPinjaman = new List();


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
    _presenter.getPinjaman(widget.tokenUser, widget.nasabah_no, context);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.appBarAva == false ? null : AppBar(
        title: Text('Daftar Pinjaman',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :
      SmartRefresher(
        controller: _refreshController,
        /*enablePullUp: true,*/
        child: _listFinalPinjaman.length > 0 ? ListView.builder(
          shrinkWrap: true,
          itemCount: _listFinalPinjaman.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.5, vertical: 2.5),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.10,
                child: RaisedButton(
                  onPressed: _listFinalPinjaman[index].status == 'APPROVED' ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPinjamanPage(
                            tokenUser: widget.tokenUser,
                            loan_no: _listFinalPinjaman[index].loan_no,
                    )));
                  } : () {},
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
                          Text(_listFinalPinjaman[index].nama_paket,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                          Spacer(),
                          Text(_listFinalPinjaman[index].status,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                        ]
                    ),
                  ),
                ),
              ),
            );},
        ) :
        Center(
            child:  CircularProgressIndicator()
        ),
        onRefresh: refreshList,
        physics: BouncingScrollPhysics(),
        /*footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
        ),
        onLoading: () async{
          // monitor network fetch
          await Future.delayed(Duration(milliseconds: 1000));
          // if failed,use loadFailed(),if no data return,use LoadNodata()
          if(mounted)
            setState(() {});
          _refreshController.loadComplete();
        }*/
      ),
    );
  }

  @override
  void getListPinjaman(List<PinjamanValue> item) {
    setState(() {
      _listFinalPinjaman = item;
    });

    _refreshController.refreshCompleted();
  }
}

class DetailPinjamanPage extends StatefulWidget {
  String tokenUser;
  String loan_no;
  bool appBarAva;

  DetailPinjamanPage({Key key, @required this.tokenUser, @required this.loan_no, @required this.appBarAva,}) : super(key: key);

  @override
  _DetailPinjamanPageState createState() => _DetailPinjamanPageState();
}

class _DetailPinjamanPageState extends State<DetailPinjamanPage> implements AngsuranAbstract {
  PinjamanPresenter _presenter;

  _DetailPinjamanPageState() {
    _presenter = PinjamanPresenter(null, this);
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<AngsuranValue> _listFinalAngsuran = new List();


  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _presenter.getAngsuran(widget.tokenUser, widget.loan_no, context);
    });

    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    _presenter.getAngsuran(widget.tokenUser, widget.loan_no, context);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pinjaman',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :
      SmartRefresher(
        controller: _refreshController,
        /*enablePullUp: true,*/
        child: _listFinalAngsuran.length > 0 ? ListView.builder(
          shrinkWrap: true,
          itemCount: _listFinalAngsuran.length,
          itemBuilder: (BuildContext context, int index){
            return Padding(
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: [
                              Text('Angsuran ke-${_listFinalAngsuran[index].angsuran_ke}',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Spacer(),
                              Text(_listFinalAngsuran[index].status_pembayaran,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Pembayaran',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Spacer(),
                              Text(
                                '-${MoneyFormatter(amount: _listFinalAngsuran[index].angsuran.toInt()).compact}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                'Jatuh Tempo',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Spacer(),
                              Text(
                                '${DateFormat("yyyy-MM-dd hh:mm").format(DateTime.parse(_listFinalAngsuran[index].jatuh_tempo))}',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            );},
        ) :
        Center(
            child:  CircularProgressIndicator()
        ),
        onRefresh: refreshList,
        physics: BouncingScrollPhysics(),
        /*footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
        ),
        onLoading: () async{
          // monitor network fetch
          await Future.delayed(Duration(milliseconds: 1000));
          // if failed,use loadFailed(),if no data return,use LoadNodata()
          if(mounted)
            setState(() {});
          _refreshController.loadComplete();
        }*/
      ),
    );
  }

  @override
  void getListAngsuran(List<AngsuranValue> item) {
    setState(() {
      _listFinalAngsuran = item;
    });

    _refreshController.refreshCompleted();
  }
}