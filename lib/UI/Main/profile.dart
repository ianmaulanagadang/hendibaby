import 'package:bpr/Constants/general.dart';
import 'package:bpr/Model/generalModel.dart';
import 'package:bpr/Presenter/userPresenter.dart';
import 'package:bpr/UI/Menu/bantuan.dart';
import 'package:bpr/UI/Menu/contactcs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class SettingPage extends StatefulWidget {
  String tokenUser;

  SettingPage({Key key, @required this.tokenUser}) : super(key: key);

  @override
  _SettingPage createState() => _SettingPage();
}

class _SettingPage extends State<SettingPage> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: Theme.of(context).copyWith(
          brightness: Brightness.dark,
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(''),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(user.Value.nama,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                            ),
                          ),
                          Text(user.Value.hp1.substring(0,2) == '62' ? '0${user.Value.hp1.substring(2)}': user.Value.hp1,
                            style: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                ListTile(
                  title: Text(
                    "Pengaturan Akun",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  subtitle: Text(user.Value.nama,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                    )
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    setState(() {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ProfilePage()));
                    });
                  }
                ),
                ListTile(
                  title: Text(
                    "Bantuan",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    Navigator.of(context).pushNamed('/bantuan');
                  },
                ),
                ListTile(
                  title: Text(
                    "Kontak CS",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () {
                    setState(() {
                      isLoading = true;
                    });
                    Navigator.of(context).pushNamed('/contactcs');
                  },
                ),
                ListTile(
                  title: Text(
                    "Keluar",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey.shade400,
                  ),
                  onTap: () async {
                    showAlertDialog(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget continueButton = FlatButton(
      child: Text("Ya"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove("key");
        Navigator.of(context).pushReplacementNamed('/login');
      },
    );
    Widget cancelButton = FlatButton(
      child: Text("Tidak"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Keluar"),
      content: Text(
          "Apakah Anda yakin ingin keluar dari Aplikasi?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class ProfilePage extends StatefulWidget {
  String tokenUser;

  ProfilePage({Key key, @required this.tokenUser}) : super(key: key);

  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> with SingleTickerProviderStateMixin implements ProfileAbstract {
  UserPresenter _presenter;

  final _formKey = GlobalKey<FormState>();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  List<PlaceModel> _listFinalPlace = new List();

  final TextEditingController namaController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController hpController = new TextEditingController();
  final TextEditingController hp2Controller = new TextEditingController();
  final TextEditingController alamatController = new TextEditingController();
  final TextEditingController nikController = new TextEditingController();
  final TextEditingController norekController = new TextEditingController();
  final TextEditingController bankController = new TextEditingController();
  final TextEditingController rtController = new TextEditingController();
  final TextEditingController rwController = new TextEditingController();
  final TextEditingController kelController = new TextEditingController();
  final TextEditingController kecController = new TextEditingController();
  final TextEditingController tgllahirController = new TextEditingController();
  final TextEditingController tmptlahirController = new TextEditingController();
  final TextEditingController domisiliController = new TextEditingController();
  final TextEditingController userbankController = new TextEditingController();

  final TextEditingController namafamilyController = new TextEditingController();
  final TextEditingController hpfamilyController = new TextEditingController();
  final TextEditingController alamatfamilyController = new TextEditingController();
  final TextEditingController rtfamilyController = new TextEditingController();
  final TextEditingController rwfamilyController = new TextEditingController();
  final TextEditingController kelfamilyController = new TextEditingController();
  final TextEditingController kecfamilyController = new TextEditingController();
  final TextEditingController tgllahirfamilyController = new TextEditingController();
  final TextEditingController tmptlahirfamilyController = new TextEditingController();
  final TextEditingController domisilifamilyController = new TextEditingController();

  final TextEditingController pekerjaanController = new TextEditingController();
  final TextEditingController jabatanController = new TextEditingController();
  final TextEditingController perusahaanController = new TextEditingController();
  final TextEditingController gajiController = new TextEditingController();

  final FocusNode _namaFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _hpFocus = FocusNode();
  final FocusNode _hp2Focus = FocusNode();
  final FocusNode _alamatFocus = FocusNode();
  final FocusNode _nikFocus = FocusNode();
  final FocusNode _norekFocus = FocusNode();
  final FocusNode _bankFocus = FocusNode();
  final FocusNode _rtFocus = FocusNode();
  final FocusNode _rwFocus = FocusNode();
  final FocusNode _kelFocus = FocusNode();
  final FocusNode _kecFocus = FocusNode();
  final FocusNode _userbankFocus = FocusNode();
  final FocusNode _urlsiteFocus = FocusNode();

  final FocusNode _namafamilyFocus = FocusNode();
  final FocusNode _hpfamilyFocus = FocusNode();
  final FocusNode _alamatfamilyFocus = FocusNode();
  final FocusNode _rtfamilyFocus = FocusNode();
  final FocusNode _rwfamilyFocus = FocusNode();
  final FocusNode _kelfamilyFocus = FocusNode();
  final FocusNode _kecfamilyFocus = FocusNode();

  final FocusNode _pekerjaanFocus = FocusNode();
  final FocusNode _jabatanFocus = FocusNode();
  final FocusNode _perusahaanFocus = FocusNode();
  final FocusNode _gajiFocus = FocusNode();

  List<DropdownMenuItem<String>> _dropDownMenuItems;

  TabController _controller;

  double _height, _width;
  String _dateTime, _dateTimeFamily;
  int _currentIndex = 0;
  bool _status = true;

  _ProfilePage() {
    _presenter = UserPresenter(this);
  }

  Future<void> refreshList() async {
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _presenter.getData(user.Value.token, context);
      if (_listFinalPlace.length == 0) {
        _presenter.getPlace();
      } else if (_listFinalPlace.length > 0) {
        for (int i = 0; i < _listFinalPlace.length; i++) {
          if (_listFinalPlace[i].id == user.Value.tempat_lahir) {
            tmptlahirController.text =
            '${_listFinalPlace[i].areaname} (${_listFinalPlace[i].level})';
          } else {
            tmptlahirController.text = '';
          }
          if (_listFinalPlace[i].id == user.Value.domicilecity) {
            domisiliController.text =
            '${_listFinalPlace[i].areaname} (${_listFinalPlace[i].level})';
          } else {
            domisiliController.text = '';
          }
          if (_listFinalPlace[i].id == user.Value.tempat_lahir_family) {
            tmptlahirfamilyController.text =
            '${_listFinalPlace[i].areaname} (${_listFinalPlace[i].level})';
          } else {
            tmptlahirfamilyController.text = '';
          }
          if (_listFinalPlace[i].id == user.Value.domicilecity_family) {
            domisilifamilyController.text =
            '${_listFinalPlace[i].areaname} (${_listFinalPlace[i].level})';
          } else {
            domisilifamilyController.text = '';
          }
        }
      }
      isLoading = false;
    });

    if (mounted) setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    _controller.addListener(_handleTabSelection);
    if (_presenter.items.length == 0) {
      _dropDownMenuItems = _presenter.getDropDownMenuItems();
    }
    _presenter.getData(user.Value.token, context);
    if (_listFinalPlace.length == 0) {
      _presenter.getPlace();
    } else if (_listFinalPlace.length > 0) {
      for (int i = 0; i < _listFinalPlace.length; i++) {
        if (_listFinalPlace[i].id == user.Value.tempat_lahir) {
          tmptlahirController.text =
          '${_listFinalPlace[i].areaname} (${_listFinalPlace[i].level})';
        } else {
          tmptlahirController.text = '';
        }
        if (_listFinalPlace[i].id == user.Value.domicilecity) {
          domisiliController.text =
          '${_listFinalPlace[i].areaname} (${_listFinalPlace[i].level})';
        } else {
          domisiliController.text = '';
        }
        if (_listFinalPlace[i].id == user.Value.tempat_lahir_family) {
          tmptlahirfamilyController.text =
          '${_listFinalPlace[i].areaname} (${_listFinalPlace[i].level})';
        } else {
          tmptlahirfamilyController.text = '';
        }
        if (_listFinalPlace[i].id == user.Value.domicilecity_family) {
          domisilifamilyController.text =
          '${_listFinalPlace[i].areaname} (${_listFinalPlace[i].level})';
        } else {
          domisilifamilyController.text = '';
        }
      }
    }

    if (user.Value != null) {
      namaController.text = user.Value.nama;
      emailController.text = user.Value.email;
      hpController.text = user.Value.hp1.substring(0, 2) == '62'
          ? user.Value.hp1.substring(2)
          : user.Value.hp1.substring(1);
      hp2Controller.text = user.Value.hp2.substring(0, 2) == '62'
          ? user.Value.hp2.substring(2)
          : user.Value.hp2.substring(1);
      alamatController.text = user.Value.alamat;
      nikController.text = user.Value.nik;
      norekController.text = user.Value.no_rek;
      bankController.text = user.Value.kode_bank;
      rtController.text = user.Value.nomor_rt;
      rwController.text = user.Value.nomor_rw;
      kelController.text = user.Value.kelurahan;
      kecController.text = user.Value.kecamatan;
      userbankController.text = user.Value.user_bank;
      _presenter.currentGender = user.Value.gender == '' ? null : user.Value.gender;
      tgllahirController.text = user.Value.tanggal_lahir == null
          ? ''
          : user.Value.tanggal_lahir == ''
              ? ''
              : user.Value.tanggal_lahir/*'${DateTime.parse(user.Value.tanggal_lahir).day} ${DateFormat("MMMM").format(DateTime.parse(user.Value.tanggal_lahir))} '
                  '${DateTime.parse(user.Value.tanggal_lahir).year}'*/;
      _dateTime = user.Value.tanggal_lahir;
      _presenter.currentBornPlaceID = user.Value.tempat_lahir;
      _presenter.currentDomicileID = user.Value.domicilecity;

      namafamilyController.text = user.Value.nama_family;
      hpfamilyController.text = user.Value.hp_family.substring(0, 2) == '62'
          ? user.Value.hp_family.substring(2)
          : user.Value.hp_family.substring(1);
      alamatfamilyController.text = user.Value.alamat_family;
      rtfamilyController.text = user.Value.nomor_rt_family;
      rwfamilyController.text = user.Value.nomor_rw_family;
      kelfamilyController.text = user.Value.kelurahan_family;
      kecfamilyController.text = user.Value.kecamatan_family;
      tgllahirfamilyController.text = user.Value.tanggal_lahir_family == null
          ? ''
          : user.Value.tanggal_lahir_family == ''
          ? ''
          : user.Value.tanggal_lahir_family;
      _dateTimeFamily = user.Value.tanggal_lahir_family;
      _presenter.currentBornPlaceIDFamily = user.Value.tempat_lahir_family;
      _presenter.currentDomicileIDFamily = user.Value.domicilecity_family;

      pekerjaanController.text = user.Value.nama_job;
      jabatanController.text = user.Value.jabatan;
      perusahaanController.text = user.Value.nama_perusahaan;
      gajiController.text = user.Value.salary.toString();
    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: AppBar(
        leading: user.Value.status == 'ACTIVE' ? null : Icon(Icons.account_circle),
        title: Text('Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: SmartRefresher(
        controller: _refreshController,
        child: Form(
          key: _formKey,
          child: new Container(
            child: new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    new Container(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 18.0, right: 25.0, top: 0.0),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(user.Value.status == 'ACTIVE' ? 'Informasi Personal' : 'Lengkapi Data Terlebih Dahulu',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    new Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        _status
                                            ? _getEditIcon()
                                            : _getUpdateIcon(),
                                      ],
                                    )
                                  ],
                                )),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.333,
                                  child: Divider(
                                    height: 20,
                                    color: _currentIndex == 0
                                        ? Theme.of(context).accentColor
                                        : Colors.transparent,
                                    thickness: 2,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.333,
                                  child: Divider(
                                    height: 20,
                                    color: _currentIndex == 1
                                        ? Theme.of(context).accentColor
                                        : Colors.transparent,
                                    thickness: 2,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.333,
                                  child: Divider(
                                    height: 20,
                                    color: _currentIndex == 2
                                        ? Theme.of(context).accentColor
                                        : Colors.transparent,
                                    thickness: 2,
                                  ),
                                ),
                              ],
                            ),
                            new Container(
                              alignment: Alignment.center,
                              child: new TabBar(
                                indicatorColor: Theme.of(context).accentColor,
                                labelColor: Theme.of(context).accentColor,
                                unselectedLabelColor: Colors.grey,
                                isScrollable: true,
                                controller: _controller,
                                tabs: [
                                  new Container(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Icon(Icons.person),
                                    width:
                                        MediaQuery.of(context).size.width * 0.25,
                                  ),
                                  new Container(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Icon(Icons.group),
                                    width:
                                    MediaQuery.of(context).size.width * 0.25,
                                  ),
                                  new Container(
                                    padding: EdgeInsets.only(bottom: 5.0),
                                    child: Icon(Icons.work),
                                    width:
                                        MediaQuery.of(context).size.width * 0.25,
                                  ),
                                ],
                              ),
                            ),
                            new Container(
                                height: 1000,
                                child: new TabBarView(
                                  controller: _controller,
                                  children: <Widget>[
                                    _personalInfo(),
                                    _familyInfo(),
                                    _work(),
                                  ],
                                ),
                            ),
                            /*!_status ? _getActionButtons() : new Container(),*/
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        onRefresh: refreshList,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  _handleTabSelection() {
    setState(() {
      _currentIndex = _controller.index;
    });
  }

  Widget _personalInfo() {
    return Container(
      child: Column(
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
                        'Nama',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: namaController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Nama harus diisi";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Masukkan Nama",
                      ),
                      enabled: !_status,
                      focusNode: _namaFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _namaFocus, _emailFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Email',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: emailController,
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
                      decoration:
                          const InputDecoration(hintText: "Masukkan Email"),
                      enabled: false,
                      focusNode: _emailFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _emailFocus, _hpFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Nomor Ponsel',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: hpController,
                      validator: (value) {
                        if (value.length < 9) {
                          return 'Nomor Ponsel minimal 9 digit';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if (value.substring(0, 1) == '0') {
                            hpController.clear();
                          } else if (value.substring(0, 2) == '62') {
                            hpController.clear();
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(14)
                      ],
                      decoration: const InputDecoration(
                        hintText: "Masukkan Nomor HP",
                        prefixText: "+62",
                      ),
                      enabled: false,
                      focusNode: _hpFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _hpFocus, _hp2Focus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Nomor Ponsel 2',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: hp2Controller,
                      validator: (value) {
                        if (value.length < 9) {
                          return 'Nomor Ponsel minimal 9 digit';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if (value.substring(0, 1) == '0') {
                            hp2Controller.clear();
                          } else if (value.substring(0, 2) == '62') {
                            hp2Controller.clear();
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(14)
                      ],
                      decoration: const InputDecoration(
                        hintText: "Masukkan Nomor Ponsel 2",
                        prefixText: "+62",
                      ),
                      enabled: false,
                      focusNode: _hp2Focus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _hp2Focus, _nikFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Jenis Kelamin',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
              child: DropdownButtonFormField(
                isExpanded: true,
                hint: Text('Pilih Jenis Kelamin'),
                validator: (value) {
                  if (value == null) {
                    return 'Jenis Kelamin harus dipilih';
                  }
                  return null;
                },
                value: _presenter.currentGender,
                items: _dropDownMenuItems,
                onChanged: _status == true ? _presenter.currentGender == null ? null : changedDropDownItem : changedDropDownItem,
              )),
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
                        'NIK',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: nikController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(20)
                      ],
                      decoration:
                          const InputDecoration(hintText: "Masukkan NIK"),
                      enabled: !_status,
                      focusNode: _nikFocus,
                      onFieldSubmitted: (term) {
                        _nikFocus.unfocus();
                      },
                    ),
                  ),
                ],
              )),
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
                        'Tempat Lahir',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      readOnly: true,
                      controller: tmptlahirController,
                      decoration: InputDecoration(
                        hintText: "Pilih Kota/Kab",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              _handleSearchStart();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    elevation: 16,
                                    child: MyDialogContent(
                                      place: (String p) {
                                        setState(() {
                                          tmptlahirController.text = p;
                                        });
                                      },
                                      type: 'tl',
                                      list: _listFinalPlace,
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                      enabled: !_status,
                    ),
                  ),
                ],
              )),
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
                        'Tanggal Lahir',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      readOnly: true,
                      controller: tgllahirController,
                      decoration: InputDecoration(
                        hintText: "Pilih Tanggal Lahir",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: _dateTime == ''
                                          ? DateTime.now()
                                          : DateTime.parse(_dateTime),
                                      firstDate: DateTime(1900),
                                      lastDate:
                                          DateTime(DateTime.now().year + 1))
                                  .then((date) {
                                setState(() {
                                  _dateTime =
                                      DateFormat("yyyy-MM-dd").format(date);
                                  tgllahirController.text =
                                      '${DateTime.parse(_dateTime).day} ${DateFormat("MMMM").format(DateTime.parse(_dateTime))} ${DateTime.parse(_dateTime).year}';
                                });
                              });
                            }),
                      ),
                      enabled: !_status,
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: new Text(
                        'Kode Bank',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      child: new Text(
                        'No. Rekening',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: new TextFormField(
                        controller: bankController,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: const InputDecoration(
                            hintText: "Masukkan Kode Bank"),
                        enabled: !_status,
                        focusNode: _norekFocus,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, _norekFocus, _bankFocus);
                        },
                      ),
                    ),
                    flex: 2,
                  ),
                  Flexible(
                    child: new TextFormField(
                      controller: norekController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                          hintText: "Masukkan Nomor Rekening"),
                      enabled: !_status,
                      focusNode: _bankFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _bankFocus, _userbankFocus);
                      },
                    ),
                    flex: 2,
                  ),
                ],
              )),
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
                        'Nama Akun Bank',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: userbankController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Nama Akun Bank"),
                      enabled: !_status,
                      focusNode: _userbankFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _userbankFocus, _urlsiteFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Alamat',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      maxLines: 5,
                      controller: alamatController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Alamat"),
                      maxLength: 250,
                      enabled: !_status,
                      focusNode: _alamatFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _alamatFocus, _rtFocus);
                      },
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 21.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: new Text(
                        'Nomor RT',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      child: new Text(
                        'Nomor RW',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: new TextFormField(
                        controller: rtController,
                        decoration: const InputDecoration(
                            hintText: "Masukkan Nomor RT"),
                        enabled: !_status,
                        focusNode: _rtFocus,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, _rtFocus, _rwFocus);
                        },
                      ),
                    ),
                    flex: 2,
                  ),
                  Flexible(
                    child: new TextFormField(
                      controller: rwController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Nomor RW"),
                      enabled: !_status,
                      focusNode: _rwFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _rwFocus, _kelFocus);
                      },
                    ),
                    flex: 2,
                  ),
                ],
              )),
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
                        'Kelurahan',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: kelController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Kelurahan"),
                      enabled: !_status,
                      focusNode: _kelFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _kelFocus, _kecFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Kecamatan',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: kecController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Kecamatan"),
                      enabled: !_status,
                      focusNode: _kecFocus,
                      onFieldSubmitted: (term) {
                        _kecFocus.unfocus();
                      },
                    ),
                  ),
                ],
              )),
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
                        'Kota',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      readOnly: true,
                      controller: domisiliController,
                      decoration: InputDecoration(
                        hintText: "Pilih Kota/Kab",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              _handleSearchStart();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    elevation: 16,
                                    child: MyDialogContent(
                                      place: (String p) {
                                        setState(() {
                                          domisiliController.text = p;
                                        });
                                      },
                                      type: 'ds',
                                      list: _listFinalPlace,
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                      enabled: !_status,
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
              child: Divider(
                height: 20,
                color: Theme.of(context).accentColor,
                thickness: 2,
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                        'Upload Dokumen',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: Divider(
                height: 20,
                color: Theme.of(context).accentColor,
                thickness: 2,
              )),
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
                        'Photo',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
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
                        'Photo KTP',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _familyInfo() {
    return Container(
      child: Column(
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
                        'Nama Keluarga',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: namafamilyController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Nama harus diisi";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Masukkan Nama",
                      ),
                      enabled: !_status,
                      focusNode: _namafamilyFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _namafamilyFocus, _hpfamilyFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Nomor Ponsel Keluarga',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: hpfamilyController,
                      validator: (value) {
                        if (value.length < 9) {
                          return 'Nomor Ponsel minimal 9 digit';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          if (value.substring(0, 1) == '0') {
                            hpfamilyController.clear();
                          } else if (value.substring(0, 2) == '62') {
                            hpfamilyController.clear();
                          }
                        });
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(14)
                      ],
                      decoration: const InputDecoration(
                        hintText: "Masukkan Nomor Ponsel Keluarga",
                        prefixText: "+62",
                      ),
                      enabled: false,
                      focusNode: _hpFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _hpfamilyFocus, _alamatfamilyFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Tempat Lahir Keluarga',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      readOnly: true,
                      controller: tmptlahirfamilyController,
                      decoration: InputDecoration(
                        hintText: "Pilih Kota/Kab",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              _handleSearchStart();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    elevation: 16,
                                    child: MyDialogContent(
                                      place: (String p) {
                                        setState(() {
                                          tmptlahirfamilyController.text = p;
                                        });
                                      },
                                      type: 'tlf',
                                      list: _listFinalPlace,
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                      enabled: !_status,
                    ),
                  ),
                ],
              )),
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
                        'Tanggal Lahir Keluarga',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      readOnly: true,
                      controller: tgllahirfamilyController,
                      decoration: InputDecoration(
                        hintText: "Pilih Tanggal Lahir",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              showDatePicker(
                                  context: context,
                                  initialDate: _dateTimeFamily == ''
                                      ? DateTime.now()
                                      : DateTime.parse(_dateTimeFamily),
                                  firstDate: DateTime(1900),
                                  lastDate:
                                  DateTime(DateTime.now().year + 1))
                                  .then((date) {
                                setState(() {
                                  _dateTimeFamily =
                                      DateFormat("yyyy-MM-dd").format(date);
                                  tgllahirfamilyController.text =
                                  '${DateTime.parse(_dateTimeFamily).day} ${DateFormat("MMMM").format(DateTime.parse(_dateTimeFamily))} ${DateTime.parse(_dateTimeFamily).year}';
                                });
                              });
                            }),
                      ),
                      enabled: !_status,
                    ),
                  ),
                ],
              )),
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
                        'Alamat (Keluarga yang Berbeda Tempat Tinggal)',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      maxLines: 5,
                      controller: alamatfamilyController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Alamat"),
                      maxLength: 250,
                      enabled: !_status,
                      focusNode: _alamatfamilyFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _alamatfamilyFocus, _rtfamilyFocus);
                      },
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 21.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: new Text(
                        'Nomor RT',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    child: Container(
                      child: new Text(
                        'Nomor RW',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    flex: 2,
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10.0),
                      child: new TextFormField(
                        controller: rtfamilyController,
                        decoration: const InputDecoration(
                            hintText: "Masukkan Nomor RT"),
                        enabled: !_status,
                        focusNode: _rtfamilyFocus,
                        onFieldSubmitted: (term) {
                          _fieldFocusChange(context, _rtfamilyFocus, _rwfamilyFocus);
                        },
                      ),
                    ),
                    flex: 2,
                  ),
                  Flexible(
                    child: new TextFormField(
                      controller: rwController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Nomor RW"),
                      enabled: !_status,
                      focusNode: _rwfamilyFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _rwfamilyFocus, _kelfamilyFocus);
                      },
                    ),
                    flex: 2,
                  ),
                ],
              )),
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
                        'Kelurahan',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: kelfamilyController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Kelurahan"),
                      enabled: !_status,
                      focusNode: _kelfamilyFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _kelfamilyFocus, _kecfamilyFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Kecamatan',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: kecfamilyController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Kecamatan"),
                      enabled: !_status,
                      focusNode: _kecfamilyFocus,
                      onFieldSubmitted: (term) {
                        _kecfamilyFocus.unfocus();
                      },
                    ),
                  ),
                ],
              )),
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
                        'Kota',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      readOnly: true,
                      controller: domisilifamilyController,
                      decoration: InputDecoration(
                        hintText: "Pilih Kota/Kab",
                        suffixIcon: IconButton(
                            icon: Icon(Icons.arrow_drop_down),
                            onPressed: () {
                              _handleSearchStart();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    elevation: 16,
                                    child: MyDialogContent(
                                      place: (String p) {
                                        setState(() {
                                          domisilifamilyController.text = p;
                                        });
                                      },
                                      type: 'dsf',
                                      list: _listFinalPlace,
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                      enabled: !_status,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _work() {
    return Container(
      child: Column(
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
                        'Pekerjaan',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: pekerjaanController,
                      decoration:
                          const InputDecoration(hintText: "Masukkan Nama Pekerjaan"),
                      enabled: !_status,
                      focusNode: _pekerjaanFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _pekerjaanFocus, _jabatanFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Jabatan',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: jabatanController,
                      decoration:
                          const InputDecoration(hintText: "Masukkan Jabatan"),
                      enabled: !_status,
                      focusNode: _jabatanFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _jabatanFocus, _jabatanFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Nama Perusahaan',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: perusahaanController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Nama Perusahaan"),
                      enabled: !_status,
                      focusNode: _perusahaanFocus,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _perusahaanFocus, _gajiFocus);
                      },
                    ),
                  ),
                ],
              )),
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
                        'Gaji',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
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
                      controller: gajiController,
                      decoration:
                      const InputDecoration(hintText: "Masukkan Gaji"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      enabled: !_status,
                      focusNode: _gajiFocus,
                      onFieldSubmitted: (term) {
                        _gajiFocus.unfocus();
                      },
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new Icon(
        Icons.edit,
        color: Theme.of(context).accentColor,
        size: 20.0,
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }

  Widget _getUpdateIcon() {
    return new Row(
      children: <Widget>[
        GestureDetector(
            child: new ClipOval(
          child: Material(
            color: Colors.red, // button color
            child: InkWell(
              splashColor: Colors.redAccent, // inkwell color
              child: Icon(
                Icons.clear,
                color: Colors.white,
                size: 20.0,
              ),
              onTap: () {
                setState(() {
                  _status = true;
                  FocusScope.of(context).requestFocus(new FocusNode());
                  if (user.Value != null) {
                    namaController.text = user.Value.nama;
                    emailController.text = user.Value.email;
                    hpController.text = user.Value.hp1.substring(0, 2) == '62'
                        ? user.Value.hp1.substring(2)
                        : user.Value.hp1.substring(1);
                    hp2Controller.text = user.Value.hp2.substring(0, 2) == '62'
                        ? user.Value.hp2.substring(2)
                        : user.Value.hp2.substring(1);
                    alamatController.text = user.Value.alamat;
                    nikController.text = user.Value.nik;
                    norekController.text = user.Value.no_rek;
                    bankController.text = user.Value.kode_bank;
                    rtController.text = user.Value.nomor_rt;
                    rwController.text = user.Value.nomor_rw;
                    kelController.text = user.Value.kelurahan;
                    kecController.text = user.Value.kecamatan;
                    userbankController.text = user.Value.user_bank;
                    _presenter.currentGender = user.Value.gender == '' ? null : user.Value.gender;
                    tgllahirController.text = user.Value.tanggal_lahir == ''
                        ? ''
                        : user.Value.tanggal_lahir;
                    _dateTime = user.Value.tanggal_lahir;
                    _presenter.currentBornPlaceID = user.Value.tempat_lahir;
                    _presenter.currentDomicileID = user.Value.domicilecity;

                    namafamilyController.text = user.Value.nama_family;
                    hpfamilyController.text = user.Value.hp_family.substring(0, 2) == '62'
                        ? user.Value.hp_family.substring(2)
                        : user.Value.hp_family.substring(1);
                    alamatfamilyController.text = user.Value.alamat_family;
                    rtfamilyController.text = user.Value.nomor_rt_family;
                    rwfamilyController.text = user.Value.nomor_rw_family;
                    kelfamilyController.text = user.Value.kelurahan_family;
                    kecfamilyController.text = user.Value.kecamatan_family;
                    tgllahirfamilyController.text = user.Value.tanggal_lahir_family == null
                        ? ''
                        : user.Value.tanggal_lahir_family == ''
                        ? ''
                        : user.Value.tanggal_lahir_family;
                    _dateTimeFamily = user.Value.tanggal_lahir_family;
                    _presenter.currentBornPlaceIDFamily = user.Value.tempat_lahir_family;
                    _presenter.currentDomicileIDFamily = user.Value.domicilecity_family;

                    pekerjaanController.text = user.Value.nama_job;
                    jabatanController.text = user.Value.jabatan;
                    perusahaanController.text = user.Value.nama_perusahaan;
                    gajiController.text = user.Value.salary.toString();
                  }
                });
              },
            ),
          ),
        )),
        SizedBox(
          width: 10,
        ),
        GestureDetector(
            child: new ClipOval(
          child: Material(
            color: Colors.green, // button color
            child: InkWell(
              splashColor: Colors.greenAccent, // inkwell color
              child: Icon(
                Icons.done,
                color: Colors.white,
                size: 20.0,
              ),
              onTap: () async {
                /*SharedPreferences prefs = await SharedPreferences.getInstance();*/
                setState(() {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      isLoading = true;
                      _presenter.updateData(
                          user.Value.token, namaController.text, emailController.text, '0${hpController.text}', alamatController.text, nikController.text,
                          norekController.text, bankController.text, rtController.text, rwController.text, kelController.text, kecController.text,
                          _dateTime, _presenter.currentGender, userbankController.text, /*_image == null ? '' : _image.path,*/ _presenter.currentBornPlaceID, _presenter.currentDomicileID, context);
                      _status = true;
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                  }
                });
              },
            ),
          ),
        )),
      ],
    );
  }

  void _handleSearchStart() {
    setState(() {
      _presenter.isSearching = true;
    });
  }

  void changedDropDownItem(String selectedGender) {
    setState(() {
      _presenter.currentGender = selectedGender;
    });
  }

  @override
  void getListPlace(List<PlaceModel> item) {
    setState(() {
      _listFinalPlace = item;
    });

    _refreshController.refreshCompleted();
  }
}

class MyDialogContent extends StatefulWidget {
  MyDialogContent({
    this.place,
    this.type,
    this.list,
    Key key,
  }) : super(key: key);

  Function(String p) place;
  String type;
  List<PlaceModel> list;

  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {
  UserPresenter _presenter;

  final TextEditingController searchController = new TextEditingController();

  _MyDialogContentState() {
    _presenter = UserPresenter(null);
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        setState(() {
          _presenter.isSearching = false;
          _presenter.searchText = "";
        });
      } else {
        setState(() {
          _presenter.isSearching = true;
          _presenter.searchText = searchController.text;
          if(_presenter.listplace.length == 0)
            {
              _presenter.listplace = widget.list;
            }
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  _getContent() {
    return Column(
      children: <Widget>[
        Container(
          child: Material(
            borderRadius: BorderRadius.circular(5.0),
            elevation: 8,
            child: Container(
              child: TextFormField(
                controller: searchController,
                style: new TextStyle(
                  color: Theme.of(context).accentColor,  fontSize: 20,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  prefixIcon: Icon(Icons.search),
                  hintText: "Cari Kota/Kab",
                  hintStyle: new TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      borderSide: BorderSide.none),
                ),
                onChanged: _presenter.searchOperation,
              ),
            ),
          ),
        ),
        widget.list.length > 0
            ? _presenter.searchresult.length != 0 || searchController.text.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _presenter.searchresult.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RadioListTile(
                          value: _presenter.searchresult[index].id,
                          groupValue: widget.type == 'tl'
                              ? _presenter.currentBornPlaceID : widget.type == 'ds'
                              ? _presenter.currentDomicileID  : widget.type == 'tlf'
                              ? _presenter.currentBornPlaceIDFamily : _presenter.currentDomicileIDFamily,
                          onChanged: (newValue) {
                            setState(() {
                              widget.type == 'tl'
                                  ? _presenter.currentBornPlaceID = newValue : widget.type == 'ds'
                                  ? _presenter.currentDomicileID = newValue : widget.type == 'tlf'
                                  ? _presenter.currentBornPlaceIDFamily = newValue : _presenter.currentDomicileIDFamily = newValue;
                              widget.place(
                                  '${_presenter.searchresult[index].areaname} (${_presenter.searchresult[index].level})');
                              Navigator.of(context).pop();
                              _handleSearchEnd();
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          title: new Text(
                              '${_presenter.searchresult[index].areaname} (${_presenter.searchresult[index].level})'),
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return RadioListTile(
                          value: widget.list[index].id,
                          groupValue: widget.type == 'tl'
                              ? _presenter.currentBornPlaceID : widget.type == 'ds'
                              ? _presenter.currentDomicileID  : widget.type == 'tlf'
                              ? _presenter.currentBornPlaceIDFamily : _presenter.currentDomicileIDFamily,
                          onChanged: (newValue) {
                            setState(() {
                              widget.type == 'tl'
                                  ? _presenter.currentBornPlaceID = newValue : widget.type == 'ds'
                                  ? _presenter.currentDomicileID = newValue : widget.type == 'tlf'
                                  ? _presenter.currentBornPlaceIDFamily = newValue : _presenter.currentDomicileIDFamily = newValue;
                              widget.place(
                                  '${widget.list[index].areaname} (${widget.list[index].level})');
                              Navigator.of(context).pop();
                              _handleSearchEnd();
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          title: new Text(
                              '${widget.list[index].areaname} (${widget.list[index].level})'),
                        );
                      },
                    ),
                  )
            : Center(child: CircularProgressIndicator()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getContent();
  }

  void _handleSearchEnd() {
    setState(() {
      _presenter.isSearching = false;
      searchController.clear();
      _presenter.searchresult.clear();
    });
  }
}
