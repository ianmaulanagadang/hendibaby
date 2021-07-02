import 'package:bpr/UI/Menu/mutasi.dart';
import 'package:bpr/UI/Menu/pembayaran.dart';
import 'package:bpr/UI/Menu/pengajuan.dart';
import 'package:bpr/UI/Menu/pinjaman.dart';
import 'package:bpr/UI/Menu/tabungan.dart';
import 'package:bpr/Presenter/userPresenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'dart:async';
import 'package:bpr/UI/Widgets/custom_shape.dart';
import 'package:bpr/Constants/general.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class HomePage extends StatefulWidget {
  String tokenUser;
  String nasabah_no;
  String phoneNumber;

  HomePage(
      {Key key,
      @required this.tokenUser,
      @required this.nasabah_no,
      @required this.phoneNumber,})
      : super(key: key);

  @override
  _Home createState() => _Home();
}

class _Home extends State<HomePage> with SingleTickerProviderStateMixin {
  UserPresenter _presenter;
  int _current = 0;
  int _selectedIndex = -1;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  _Home() {
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      body: SmartRefresher(
        controller: _refreshController,
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 80.0,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Positioned(
                    bottom: 50,
                    left: -40,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(70),
                          color: Colors.grey.withOpacity(0.1)),
                    )),
                /*Positioned(
                    top: -20,
                    left: 100,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(150),
                          color: Colors.grey.withOpacity(0.1)),
                    )),*/
                Positioned(
                    top: -50,
                    left: 0,
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.1)),
                    )),
                Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      width: 50,
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
                          Text(user.Value.nama,
                            style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          ),
                          RaisedButton(
                            child: Text(user.Value.status,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                            onPressed: () {},
                            elevation: 1.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                      child: Text(user.Value.hp1.substring(0,2) == '62' ? '0${user.Value.hp1.substring(2)}': user.Value.hp1,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.70),
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          elevation: 2.0,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Saldo',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '7567.86',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      'INR',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )*/
                  ],
                ),
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  CarouselSlider(
                    items: imageSliders,
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.map((url) {
                      int index = imgList.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == index
                              ? Colors.white
                              : Colors.grey,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            getGridView()
          ],
        ),
        onRefresh: refreshList,
        physics: BouncingScrollPhysics(),
      ),
    );
  }


  Widget getGridView() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      primary: false,
      childAspectRatio: (MediaQuery
          .of(context)
          .size
          .width - 60 / 2) / 280,
      children: <Widget>[
        createTile(0,_selectedIndex, false, 'Mutasi Rekening', Colors.lightBlue, Icons.library_books, (){
          setState(() {
            _selectedIndex = 0;
            Navigator.of(context).pushNamed('/mutasi',
                arguments: MutasiPage(
                    tokenUser: widget.tokenUser,
                    nasabah_no: widget.nasabah_no
                ));
          });
        }),
        createTile(1,_selectedIndex, true, 'Informasi  Saldo', Colors.pink, Icons.local_atm, (){
          setState(() {
            _selectedIndex = 1;
            Navigator.of(context).pushNamed('/tabungan',
                arguments: TabunganPage(
                  tokenUser: widget.tokenUser,
                ));
          });
        }),
        createTile(2,_selectedIndex, false, 'Daftar Pinjaman', Colors.teal, Icons.view_list, (){
          setState(() {
            _selectedIndex = 2;
            Navigator.of(context).pushNamed('/pinjaman',
                arguments: DaftarPinjamanPage(
                  tokenUser: widget.tokenUser,
                  nasabah_no: widget.nasabah_no,
                  appBarAva: true,
                ));
          });
        }),
        createTile(3,_selectedIndex, true, 'Pengajuan Pinjaman', Colors.blueGrey, Icons.account_balance, (){
          setState(() {
            _selectedIndex = 3;
            Navigator.of(context).pushNamed('/pengajuan',
                arguments: PengajuanPage(
                  tokenUser: widget.tokenUser,
                ));
          });
        }),
        createTile(4,_selectedIndex, false, 'Pembayaran', Colors.deepPurple, Icons.payment, (){
          setState(() {
            _selectedIndex = 4;
            Navigator.of(context).pushNamed('/pembayaran',
                arguments: PembayaranPage(
                  tokenUser: widget.tokenUser,
                  nasabah_no: widget.nasabah_no,
                ));
          });
        }),
        createTile(5,_selectedIndex, true, 'Bantuan', Colors.black, Icons.info_outline, (){
          setState(() {
            _selectedIndex = 5;
            Navigator.of(context).pushNamed('/bantuan');
          });
        }),
      ],
    );
  }

  Widget createTile(int index,int selectedIndex,bool isEven, String title, Color color, IconData icon, Function function) {
    return Padding(
      padding: EdgeInsets.only(
          left:  isEven?10:20, right: isEven?20:10, top: 10, bottom: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: function,
          child: Material(
            elevation: 3.0,
            color: _selectedIndex == index ? Colors.grey : Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            child: Padding(
              padding: const EdgeInsets.only(left: 20,top: 20,bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(icon,color: _selectedIndex==index?Colors.white:color,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _selectedIndex==index?Colors.white:Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:2.0),
                        child: Container(
                          height: 3.0,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            color: _selectedIndex==index?Colors.white:color,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final List<Widget> imageSliders = imgList.map((item) => Container(
    child: Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.network(item, fit: BoxFit.cover, width: 1000.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'No. ${imgList.indexOf(item)} image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ),
    ),
  )).toList();

  /*@override
  void getListTopUpData(List<TopUpModel> item) {
    setState(() {
      _listFinalData = item;
    });

    _refreshController.refreshCompleted();
  }*/
}
