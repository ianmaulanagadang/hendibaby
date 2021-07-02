import 'package:bpr/Constants/constants.dart';
import 'package:bpr/Constants/general.dart';
import 'package:bpr/Model/mutasiModel.dart';
import 'package:bpr/Presenter/mutasiPresenter.dart';
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

class MutasiPage extends StatefulWidget {
  String tokenUser;
  String nasabah_no;

  MutasiPage({Key key, @required this.tokenUser, @required this.nasabah_no,}) : super(key: key);

  @override
  _MutasiPageState createState() => _MutasiPageState();
}

class _MutasiPageState extends State<MutasiPage> implements MutasiAbstract {
  MutasiPresenter _presenter;

  _MutasiPageState() {
    _presenter = MutasiPresenter(this);
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);
  List<MutasiValue> _listFinalMutasi = new List();

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _presenter.getMutasi(widget.tokenUser, widget.nasabah_no, context);
    });

    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    _presenter.getMutasi(widget.tokenUser, widget.nasabah_no, context);
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mutasi Rekening',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :
      SmartRefresher(
        controller: _refreshController,
        /*enablePullUp: true,*/
        child: _listFinalMutasi.length > 0 ? ListView.builder(
          shrinkWrap: true,
          itemCount: _listFinalMutasi.length,
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
                              Text(
                                _listFinalMutasi[index].jenis_transaksi,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              Spacer(),
                              Text('${DateFormat("yyyy-MM-dd hh:mm").format(_listFinalMutasi[index].created_at)}',
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
                                '-${MoneyFormatter(amount: _listFinalMutasi[index].amount.toInt()).compact}',
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
                                'Type',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Spacer(),
                              Text(
                                '${_listFinalMutasi[index].type}',
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
  void getListMutasi(List<MutasiValue> item) {
    setState(() {
      _listFinalMutasi = item;
    });

    _refreshController.refreshCompleted();
  }
}