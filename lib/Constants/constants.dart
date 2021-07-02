import 'package:bpr/UI/Menu/bantuan.dart';
import 'package:bpr/UI/Menu/contactcs.dart';
import 'package:bpr/UI/Menu/mutasi.dart';
import 'package:bpr/UI/Menu/pembayaran.dart';
import 'package:bpr/UI/Menu/pengajuan.dart';
import 'package:bpr/UI/Menu/pinjaman.dart';
import 'package:bpr/UI/Menu/tabungan.dart';
import 'package:flutter/material.dart';
import 'package:bpr/UI/Widgets/splash_screen.dart';
import 'package:bpr/UI/Main/drawer.dart';
import 'package:bpr/UI/Login/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => AnimatedSplashScreen()
        );
      break;
      case '/login':
        return MaterialPageRoute(
            builder: (_) => LoginPage()
        );
        break;
      case '/home':
        final DrawerPage args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => DrawerPage(tokenUser: args.tokenUser, nasabah_no: args.nasabah_no)
        );
        break;
      case '/pengajuan':
        final PengajuanPage args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => PengajuanPage(tokenUser: args.tokenUser)
        );
        break;
      case '/pembayaran':
        final PembayaranPage args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => PembayaranPage(tokenUser: args.tokenUser, nasabah_no:  args.nasabah_no)
        );
        break;
      case '/mutasi':
        final MutasiPage args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => MutasiPage(tokenUser: args.tokenUser, nasabah_no:  args.nasabah_no)
        );
        break;
      case '/tabungan':
        final TabunganPage args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => TabunganPage(tokenUser: args.tokenUser)
        );
        break;
      case '/pinjaman':
        final DaftarPinjamanPage args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => DaftarPinjamanPage(tokenUser: args.tokenUser, nasabah_no:  args.nasabah_no, appBarAva: args.appBarAva,)
        );
        break;
      case '/bantuan':
        return MaterialPageRoute(
            builder: (_) => BantuanPage()
        );
        break;
      case '/contactcs':
        return MaterialPageRoute(
            builder: (_) => ContactCSPage()
        );
        break;

      default:
      // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Undefined Page'),
        ),
        body: Center(
          child: Text('Undefined Page'),
        ),
      );
    });
  }
}

