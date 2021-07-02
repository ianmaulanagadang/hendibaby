import 'package:bpr/Model/generalModel.dart';

class Mutasi {
  List<MutasiValue> value;
  bool status;
  List<MessagesModel> messages;

  Mutasi({this.value, this.status, this.messages});

  Mutasi.fromJson(Map<String, dynamic> json) {
    if (json['Value'] != null) {
      value = new List<MutasiValue>();
      json['Value'].forEach((v) {
        value.add(new MutasiValue.fromJson(v));
      });
    }
    status = json['Status'];
    if (json['Messages'] != null) {
      messages = new List<MessagesModel>();
      json['Messages'].forEach((v) {
        messages.add(new MessagesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['Value'] = this.value.map((v) => v.toJson()).toList();
    }
    data['Status'] = this.status;
    if (this.messages != null) {
      data['Messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MutasiValue {
  String id;
  String order_no;
  String nasabah_no;
  String type;
  String jenis_transaksi;
  int amount;
  int saldo_terakhir;
  String transaction_date;
  DateTime created_at;

  MutasiValue(
      {this.id,
        this.order_no,
        this.nasabah_no,
        this.type,
        this.jenis_transaksi,
        this.amount,
        this.saldo_terakhir,
        this.transaction_date,
        this.created_at});

  MutasiValue.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? '' : json['id'];
    order_no = json['order_no'] == null ? '' : json['order_no'];
    nasabah_no = json['nasabah_no'] == null ? '' : json['nasabah_no'];
    type = json['type'] == null ? '' : json['type'];
    jenis_transaksi = json['jenis_transaksi'] == null ? '' : json['jenis_transaksi'];
    amount = json['amount'] == null ? 0 : json['amount'] == '' ? 0 : int.parse(json['amount'].toString());
    saldo_terakhir = json['saldo_terakhir'] == null ? 0 : json['saldo_terakhir'] == '' ? 0 : int.parse(json['saldo_terakhir'].toString());
    transaction_date = json['transaction_date'] == null ? '' : json['transaction_date'];
    created_at = json['created_at'] == null ? '' : json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_no'] = this.order_no;
    data['nasabah_no'] = this.nasabah_no;
    data['type'] = this.type;
    data['jenis_transaksi'] = this.jenis_transaksi;
    data['amount'] = this.amount;
    data['saldo_terakhir'] = this.saldo_terakhir;
    data['transaction_date'] = this.transaction_date;
    data['created_at'] = this.created_at;
    return data;
  }
}