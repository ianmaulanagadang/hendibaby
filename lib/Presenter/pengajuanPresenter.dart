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

String currentPeruntukan, currentJaminan;

abstract class PengajuanAbstract {
}

class PengajuanPresenter {
  PengajuanAbstract _view;

  PengajuanPresenter(this._view);

  List<PlaceModel> listPlace = List();
  List<MessagesModel> listMsg = List();
  List<DropdownMenuItem<String>> items = new List();

  Default() {
    listPlace.clear();
    listMsg.clear();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    items.add(new DropdownMenuItem(value: 'L', child: new Text('Laki-laki')));
    items.add(new DropdownMenuItem(value: 'P', child: new Text('Perempuan')));

    return items;
  }

  regis(String hp, name, email, pass, BuildContext context) async {
    Map data = {
      'tokenNasabah': hp,
      'nama_paket': name,
      'total_pinjaman': email,
      'lama_pinjaman': pass,
      'lama_pinjaman': pass,
      'lama_pinjaman': pass,
    };
    var response = await http.post("${url}/Peminjaman/Peminjaman?", body: data);
    listMsg = (json.decode(response.body)['Messages'] as List)
        .map((data) => new MessagesModel.fromJson(data))
        .toList();
    if (response.statusCode == 200 && listMsg[0].type == 200) {
      isLoading = false;
      Navigator.of(context).pop();
      showToast("Informasi sudah tersubmit. Terima Kasih", context,
          gravity: Toast.BOTTOM);
    } else {
      isLoading = false;
      showToast('Oops, Server Error! Silahkan kontak Admin! ', context,
          gravity: Toast.BOTTOM);
    }
  }
}