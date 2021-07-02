import 'package:bpr/Model/userModel.dart';
import 'package:bpr/Model/generalModel.dart';
import 'package:bpr/Constants/constants.dart';
import 'package:bpr/Constants/general.dart';
import 'package:bpr/UI/Main/profile.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:bpr/UI/Main/drawer.dart';
import 'package:bpr/UI/Main/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

abstract class ProfileAbstract {
  void getListPlace(List<PlaceModel> list);
}

class UserPresenter {
  ProfileAbstract _view;

  UserPresenter(this._view);

  List<PlaceModel> listPlace = List();
  List<PlaceModel> listplace = List();
  List<ListSearchPlace> searchresult = new List();
  List<GenderModel> listGender = List();
  List<MessagesModel> listMsg = List();
  List<DropdownMenuItem<String>> items = new List();
  int currentBornPlaceID, currentDomicileID, currentBornPlaceIDFamily, currentDomicileIDFamily;
  bool isSearching;
  String searchText = '', currentGender = null;
  var images = null;

  Default() {
    listPlace.clear();
    listGender.clear();
    items.clear();
    searchresult.clear();
    listMsg.clear();
  }

  getPlace() async {
    var response = await http.post("http://jktprod.asiatrans.id/area/get/");
    listPlace = (json.decode(response.body)['Value'] as List)
        .map((data) => new PlaceModel.fromJson(data))
        .toList();
    _view.getListPlace(listPlace);
  }

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    items.add(new DropdownMenuItem(value: 'L', child: new Text('Laki-laki')));
    items.add(new DropdownMenuItem(value: 'P', child: new Text('Perempuan')));

    return items;
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (isSearching != null) {
      for (int i = 0; i < listplace.length; i++) {
        if (listplace[i].areaname.toLowerCase().contains(searchText.toLowerCase())) {
          searchresult.add(ListSearchPlace(
              id: listplace[i].id,
              areaname: listplace[i].areaname,
              level: listplace[i].level,
              created_at: listplace[i].created_at,
              updated_at: listplace[i].updated_at));
        }
      }
    }
  }

  signIn(String hp, String pass, BuildContext context) async {
    Map data = {'cellular': hp, 'password': pass};
    /*var jsonResponse = null;*/
    var response = await http.post("${url}/Nasabah/Auth?", body: data);
    if (response.body.isNotEmpty) {
      /*listMsg = (json.decode(response.body)['Messages'] as List)
        .map((data) => new MessagesModel.fromJson(data)).toList();
    if (response.statusCode == 200 && listMsg[0].type == 200) {*/
      user = new User.fromJson(json.decode(response.body));
      if (user.status == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("key", json.encode(user.toJson()));
        isLoading = false;
        if (user.Value.status == 'ACTIVE') {
          Navigator.of(context).pushReplacementNamed(
            '/home',
            arguments: DrawerPage(
              tokenUser: user.Value.token,
              nasabah_no: user.Value.nasabah_no,
              phoneNumber: user.Value.hp1,
            ),
          );
        } else {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ProfilePage()));
        }
      } else {
        isLoading = false;
        showToast("Username atau password salah!", context,
            gravity: Toast.BOTTOM);
      }
    } else {
      isLoading = false;
      showToast('Oops, Server Error! Silahkan kontak Admin! ', context,
          gravity: Toast.BOTTOM);
    }
  }

  regis(String hp, name, email, pass, BuildContext context) async {
    Map data = {
      'hp1': hp,
      'nama': name,
      'email': email,
      'password': pass,
    };
    var response = await http.post("${url}/Nasabah/Registration?", body: data);
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

  updateData(String token, nama, email, hp1, alamat, nik, no_rek, kode_bank, nomor_rt, nomor_rw, kelurahan, kecamatan,
      tanggal_lahir, gender, user_bank, /*photo_ktp,*/ int tempat_lahir, domicilecity, BuildContext context) async {
    Map<String, String> header = {
      "Accept": "application/json",
      "Content-Type": "application/x-www-form-urlencoded;"
    };
    Map<String, dynamic> data = {
      'token': token,
      'nama': nama,
      'email': email,
      'hp1': hp1,
      'alamat': alamat,
      'nik': nik,
      'no_rek': no_rek,
      'kode_bank': kode_bank,
      'nomor_rt': nomor_rt,
      'nomor_rw': nomor_rw,
      'kelurahan': kelurahan,
      'kecamatan': kecamatan,
      'tanggal_lahir': tanggal_lahir,
      'gender': gender == null ? '' : gender,
      'user_bank': user_bank,
      'tempat_lahir': tempat_lahir.toString(),
      'domicilecity': domicilecity.toString(),
    };
    var request = await http.MultipartRequest('POST', Uri.parse("${url}/Nasabah/Update?"));
    request.headers.addAll(header);
    data.forEach((key, value){
      request.fields[key] = value;
    });
    /*request.files.add(
        await http.MultipartFile.fromBytes(
          'photo_ktp',
          File(photo_ktp).readAsBytesSync(),
          filename: 'ktp.jpg',
          contentType: MediaType('image', 'jpg'),
        )
    );*/
    var res = await request.send();
    if (res.statusCode < 200 || res.statusCode > 400 || json == null) {
      throw new Exception('Error while fetching data');
    } else {
      isLoading = false;
      getData(token, context);
      showToast("Informasi sudah terupdate. Terima Kasih", context,
          gravity: Toast.BOTTOM);
    }

    return json.decode(await res.stream.bytesToString());
    /*String encodedBody = data.keys.map((key) => "$key=${data[key]}").join("&");
  var response = await http.post("${url}/user/update?",
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: encodedBody,
      encoding: Encoding.getByName("utf-8"));
  listMsg = (json.decode(response.body)['Messages'] as List)
      .map((data) => new MessagesModel.fromJson(data))
      .toList();
  if (response.statusCode == 200 && listMsg[0].type == 200) {
    isLoading = false;
    updateSuccess = true;
    getData(token, context);
  } else {
    isLoading = false;
    showToast('Oops, Server Error! Silahkan kontak Admin! ', context,
        gravity: Toast.BOTTOM);
  }*/
  }

  getData(String tokenUser, BuildContext context) async {
    Map data = {
      'tokenUser': tokenUser,
    };
    /*var jsonResponse = null;*/
    var response = await http.post("${url}/Nasabah/GetByTokenUser?", body: data);
    if (response.body.isNotEmpty) {
      user = new User.fromJson(json.decode(response.body));
      if (user.status == true) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('key');
        prefs.setString("key", json.encode(user.toJson()));
        isLoading = false;
      }
    } else {
      isLoading = false;
      showToast('Oops, Server Error! Silahkan kontak Admin! ', context,
          gravity: Toast.BOTTOM);
    }
  }

  forgotpassword(String hp, email, BuildContext context) async {
    Map data = {
      'email': email,
      'hp1': hp,
    };
    var response = await http.post("${url}/Nasabah/ForgotPassword", body: data);
    listMsg = (json.decode(response.body)['Messages'] as List)
        .map((data) => new MessagesModel.fromJson(data))
        .toList();
    isLoading = false;
    Navigator.of(context).pop();
    if (response.statusCode == 200 && listMsg[0].type == 200) {
    } else {
      showToast('Oops, Server Error! Silahkan kontak Admin! ', context,
          gravity: Toast.BOTTOM);
    }
  }
}