import 'package:bpr/Constants/constants.dart';
import 'package:bpr/Constants/general.dart';
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

class BantuanPage extends StatefulWidget {

  BantuanPage({Key key}) : super(key: key);

  @override
  _BantuanPageState createState() => _BantuanPageState();
}

class _BantuanPageState extends State<BantuanPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bantuan',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator()) :
      Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ExpansionTile(
                      title: new Text("Saya sudah download Aplikasi Dokatku, lalu bagaimana memulai transaksi?"),
                      children: <Widget>[
                        new ListTile(
                          title: new Text("Silahkan melakukan registrasi terlebih dahulu, dengan mengisi data di Akun Anda pada menu Akun di aplikasi, setelah itu Anda perlu mengisi deposit dengan cara transfer ke Rek BCA 7650871116 atau ke Bank Mandiri 1570007777551 a/n. PT Asia Trans Teknologi.  Setelah transfer, silahkan  lakukan konfirmasi deposit dengan upload bukti transfer ke WA admin 08111130053."),
                        )
                      ]
                  ),
                ],
              ),
            ),
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ExpansionTile(
                      title: new Text("Saya ingin jadi Agen Dokatku, apa persyaratannya?"),
                      children: <Widget>[
                        new ListTile(
                          title: new Text("Anda hanya mengisi semua data di menu Akun dan mengisi Saldo Akun Anda agar bisa melakukan transaksi kepada customer Anda.  Cara isi deposit dengan cara transfer ke Rek BCA 7650871116 atau ke Bank Mandiri 1570007777551 a/n. PT Asia Trans Teknologi.  Setelah transfer, silahkan  lakukan konfirmasi deposit dengan upload bukti transfer ke WA admin 08111130053."),
                        )
                      ]
                  ),
                ],
              ),
            ),
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ExpansionTile(
                      title: new Text("Berapa minimal Deposit jika ingin jadi Agen Dokatku?"),
                      children: <Widget>[
                        new ListTile(
                          title: new Text("Jumlah deposit minimal Anda adalah Rp. 100.000 untuk dapat memulai menjual pulsa kepada customer dan jumlah deposit maksimal adalah Rp. 10.000.000."),
                        )
                      ]
                  ),
                ],
              ),
            ),
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ExpansionTile(
                      title: new Text("Bagaimana melihat transaksi saya sebelumnya?"),
                      children: <Widget>[
                        new ListTile(
                          title: new Text("Masuk ke menu Payment, maka Anda melihat semua daftar history transaksi lengkap dengan status transaksinya."),
                        )
                      ]
                  ),
                ],
              ),
            ),
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ExpansionTile(
                      title: new Text("Tagihan apa saja yang bisa saya bayarkan?"),
                      children: <Widget>[
                        new ListTile(
                          title: new Text("Semua jenis tagihan yang terdapat dalam Aplikasi Dokatku dapat Anda bayarkan, sepanjang Saldo Akun Anda mencukupi. Pastikan Saldo Anda cukup sebelim melakukan transaksi."),
                        )
                      ]
                  ),
                ],
              ),
            ),
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ExpansionTile(
                      title: new Text("Saya tidak bisa login karena lupa password"),
                      children: <Widget>[
                        new ListTile(
                          title: new Text("Silahkan klik lupa password pada halaman login lalu isi nomor HP dan alamat email Anda lalu klik reset password. Cek email Anda beberapa saat kemudian dan login menggunakan password baru yang dikirim via email."),
                        )
                      ]
                  ),
                ],
              ),
            ),
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ExpansionTile(
                      title: new Text("Mengapa saldo Akun saya berkurang padahal transaksi belum sukses?"),
                      children: <Widget>[
                        new ListTile(
                          title: new Text("Silahkan cek staus transaksi Anda di menu Payment. Jika transaksi gagal, maka Saldo Anda akan dikembalikan secara otomatis."),
                        )
                      ]
                  ),
                ],
              ),
            ),
            new Card(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ExpansionTile(
                      title: new Text("Saya isi pulsa tapi belum masuk."),
                      children: <Widget>[
                        new ListTile(
                          title: new Text("Hal ini dimungkinkan karena signal atau jaringan kurang stabil  saat pengisian. Mohon bersabar, beberapa saat pulsa akan segera masuk ke nomor Anda."),
                        )
                      ]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}