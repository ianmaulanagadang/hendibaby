import 'package:bpr/Model/pinjamanModel.dart';
import 'package:bpr/UI/Main/drawer.dart';
import 'package:bpr/UI/Menu/pengajuan.dart';
import 'package:bpr/Model/generalModel.dart';
import 'package:bpr/Presenter/userPresenter.dart';
import 'package:bpr/Constants/constants.dart';
import 'package:bpr/Constants/general.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';

String currentTagihan;

abstract class PinjamanAbstract {
  void getListPinjaman(List<PinjamanValue> list);
}

abstract class AngsuranAbstract {
  void getListAngsuran(List<AngsuranValue> list);
}

class PinjamanPresenter {
  PinjamanAbstract _viewPinjaman;
  AngsuranAbstract _viewAngsuran;

  PinjamanPresenter(this._viewPinjaman, this._viewAngsuran);

  List<PinjamanValue> listPinjaman = List();
  List<AngsuranValue> listAngsuran = List();
  List<MessagesModel> listMsg = List();

  bool paymentSuccess;
  var now = new DateTime.now();
  bool isSearching;
  String searchText = "";

  Default() {
    listPinjaman.clear();
    listMsg.clear();
  }

  getPinjaman(String tokenUser, nasabah_no, BuildContext context) async {
    Map data = {
      'auth': tokenUser,
      'display': "{'limit':20,'page':1,'field':'id','direction':'asc'}",
      'filterparams': "[{'field':'nasabah_no','op':'eq','value':'${nasabah_no}'}]",
    };
    var response = await http.post(
        "${url}/peminjaman/GetByParamsPeminjamanNasabah?", body: data);
    if (response.body.isNotEmpty) {
      listMsg = (json.decode(response.body)['Messages'] as List)
          .map((data) => new MessagesModel.fromJson(data)).toList();
      if (response.statusCode == 200) {
        /*Map<String, dynamic> map = json.decode(json.decode(response.body)['Value']);*/
        listPinjaman = (json.decode(response.body)['Value'] as List)
            .map((data) => new PinjamanValue.fromJson(data)).toList();
        if (listPinjaman.length > 0) {
          _viewPinjaman.getListPinjaman(listPinjaman);
        }
      } else {
        isLoading = false;
        showToast('${listMsg[0].message}', context, gravity: Toast.BOTTOM);
      }
    } else {
      isLoading = false;
      showToast('Oops, Server Error! Silahkan kontak Admin! ', context,
          gravity: Toast.BOTTOM);
    }
  }

  getAngsuran(String tokenUser, loan_no, BuildContext context) async {
    Map data = {
      'auth': tokenUser,
      'display': "{'limit':20,'page':1,'field':'id','direction':'asc'}",
      'filterparams': "[{'field':'loan_no','op':'eq','value':'${loan_no}'}]",
    };
    var response = await http.post(
        "${url}/pengangsuran/GetByParamsAngsuranNasabah?", body: data);
    if (response.body.isNotEmpty) {
      listMsg = (json.decode(response.body)['Messages'] as List)
          .map((data) => new MessagesModel.fromJson(data)).toList();
      if (response.statusCode == 200) {
        /*Map<String, dynamic> map = json.decode(json.decode(response.body)['Value']);*/
        listAngsuran = (json.decode(response.body)['Value'] as List)
            .map((data) => new AngsuranValue.fromJson(data)).toList();
        if (listAngsuran.length > 0) {
          _viewAngsuran.getListAngsuran(listAngsuran);
        }
      } else {
        isLoading = false;
        showToast('${listMsg[0].message}', context, gravity: Toast.BOTTOM);
      }
    } else {
      isLoading = false;
      showToast('Oops, Server Error! Silahkan kontak Admin! ', context,
          gravity: Toast.BOTTOM);
    }
  }
}