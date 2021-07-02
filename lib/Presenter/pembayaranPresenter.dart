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

String currentAngsuran;

class PembayaranPresenter {

  PembayaranPresenter();

  List<AngsuranValue> listAngsuran = List();
  List<PinjamanValue> listPinjaman = List();
  List<MessagesModel> listMsg = List();

  bool paymentSuccess;
  var now = new DateTime.now();
  bool isSearching;
  String searchText = "";

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (var angsuran in listAngsuran) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(
          value: angsuran.angsuran_no,
          child: new Text('${DateFormat("MMMM").format(DateTime.parse(angsuran.jatuh_tempo))} '
              '${DateFormat("yyyy").format(DateTime.parse(angsuran.jatuh_tempo))}')
      ));
    }
    return items;
  }

  getPinjaman(String tokenUser, nasabah_no, BuildContext context) async {
    Map data = {
      'auth': tokenUser,
      'display': "{'limit':20,'page':1,'field':'id','direction':'asc'}",
      'filterparams': "[{'field':'nasabah_no','op':'eq','value':'${nasabah_no}'},{'field':'status_pembayaran','op':'eq','value':'UNPAID'}]",
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
        getAngsuranBayar(tokenUser, listPinjaman[0].loan_no, context);
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

  getAngsuranBayar(String tokenUser, loan_no, BuildContext context) async {
    Map data = {
      'auth': tokenUser,
      'display': "{'limit':20,'page':1,'field':'id','direction':'asc'}",
      'filterparams': "[{'field':'loan_no','op':'eq','value':'${loan_no}'},{'field':'status_pembayaran','op':'eq','value':'UNPAID'}]",
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

  Pembayaran(String tokenUser, angsuran_no, total_pembayaran, bukti_pembayaran, BuildContext context) async {
    Map data = {
      'auth': tokenUser,
      'angsuran_no': angsuran_no,
      'total_pembayaran': total_pembayaran,
      'bukti_pembayaran': bukti_pembayaran,
    };
    var response = await http.post(
        "${url}/pengangsuran/pembayaran?", body: data);
    if (response.body.isNotEmpty) {
      listMsg = (json.decode(response.body)['Messages'] as List)
          .map((data) => new MessagesModel.fromJson(data)).toList();
      if (response.statusCode == 200) {
        showToast('Transaksi sedang dalam proses pengecekan', context,
            gravity: Toast.BOTTOM);
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