import 'package:bpr/Model/mutasiModel.dart';
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

abstract class MutasiAbstract {
  void getListMutasi(List<MutasiValue> list);
}

class MutasiPresenter {
  MutasiAbstract _view;

  MutasiPresenter(this._view);

  List<MutasiValue> listMutasi = List();
  List<MessagesModel> listMsg = List();

  bool paymentSuccess;
  var now = new DateTime.now();
  bool isSearching;
  String searchText = "";

  Default() {
    listMutasi.clear();
    listMsg.clear();
  }

  getMutasi(String tokenUser, nasabah_no, BuildContext context) async {
    Map data = {
      'auth': tokenUser,
      'display': "{'limit':20,'page':1,'field':'id','direction':'asc'}",
      'filterparams': "[{'field':'nasabah_no','op':'eq','value':'${nasabah_no}'}]",
    };
    var response = await http.post(
        "${url}/admin/GetByParamsPaymentNasabah?", body: data);
    if (response.body.isNotEmpty) {
      listMsg = (json.decode(response.body)['Messages'] as List)
          .map((data) => new MessagesModel.fromJson(data)).toList();
      if (response.statusCode == 200) {
        /*Map<String, dynamic> map = json.decode(json.decode(response.body)['Value']);*/
        listMutasi = (json.decode(response.body)['Value'] as List)
            .map((data) => new MutasiValue.fromJson(data)).toList();
        if (listMutasi.length > 0) {
          _view.getListMutasi(listMutasi);
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