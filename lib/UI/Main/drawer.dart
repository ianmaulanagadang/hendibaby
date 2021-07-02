import 'package:bpr/UI/Menu/pinjaman.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'profile.dart';
import 'package:bpr/Constants/general.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerPage extends StatefulWidget {
  String tokenUser;
  String nasabah_no;
  String phoneNumber;

  DrawerPage({Key key, @required this.tokenUser, @required this.nasabah_no, @required this.phoneNumber}) : super(key: key);

  @override
  _Drawer createState() => _Drawer();
}

class _Drawer extends State<DrawerPage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double _height;
  double _width;
  int index = 0;

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text('Home', style: TextStyle(fontWeight: FontWeight.bold,)),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.view_list),
        title: Text('Pinjaman', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    ];
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        HomePage(tokenUser: widget.tokenUser, nasabah_no: widget.nasabah_no, phoneNumber: widget.phoneNumber),
        DaftarPinjamanPage(tokenUser: widget.tokenUser, nasabah_no: widget.nasabah_no, appBarAva: false,),
        SettingPage(),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  void pageChanged(int index) {
    setState(() {
      this.index = index;
    });
  }

  void bottomTapped(int index) {
    setState(() {
      this.index = index;
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return PageView(
      children: <Widget>[
        Scaffold(
          backgroundColor: Colors.white,
          appBar: _mainAppBar(_height, _width, index, context),
          body: buildPageView(),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index,
            onTap: (int index) {
              bottomTapped(index);
            },
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 9,
            items: buildBottomNavBarItems(),
          ),
        ),
      ],
    );
  }
}

AppBar _mainAppBar(double _height, double _width, int index, BuildContext context) {
  return AppBar(
    elevation: 0.0,
    leading: Opacity(
      opacity: 1.0,
      child: GestureDetector(
          onTap: (){},
          child: Icon(Icons.account_balance_wallet, color: Colors.white,size: 28,)),
    ),
    title: index == 0 ? new Text('BPR',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),) : index == 1 ? new Text('Daftar Pinjaman',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),) : new Text('Profile',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
    actions: <Widget>[
      index == 0 ?
      Opacity(
        opacity: 1.0,
        child: GestureDetector(
            onTap: () async {},
            child: Icon(Icons.notifications, color: Colors.white,size: 28,)),
      ) /*: index == 2 ?
      Opacity(
        opacity: 1.0,
        child: GestureDetector(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove("key");
              Navigator.of(context).pushReplacementNamed('/login');
            },
            child: Icon(Icons.exit_to_app, color: Colors.white,size: 28,)),
      )*/ : Opacity(
        opacity: 1.0,
        /*child: GestureDetector(
            onTap: (){},
            child: Icon(Icons.notifications, color: Colors.white,size: 28,)),*/
      ),
    ],
  );
}
