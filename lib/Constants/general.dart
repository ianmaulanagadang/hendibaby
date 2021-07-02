import 'package:bpr/Model/userModel.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:toast/toast.dart';

String url = 'https://bpr.asiatrans.id';
bool isLoading = false;
User user;

final numformat = new NumberFormat("#,###");

class MoneyFormatter {
  MoneyFormatter({@required this.amount,}){}

  int amount;

  String get compact {
    String compacted = NumberFormat("#,###").format(amount);
    return 'Rp. $compacted';
  }
  String get compactNonSymbol {
    String compacted = NumberFormat.compact(locale: "in").format(amount);
    return '$compacted';
  }
  String get compactNonSymbolStandart {
    String compacted = NumberFormat("#,###").format(amount);
    return '$compacted';
  }
}

void showToast(String msg, BuildContext context,
    { int duration, int gravity}) {
  Toast.show(msg, context, duration: duration, gravity: gravity);
}