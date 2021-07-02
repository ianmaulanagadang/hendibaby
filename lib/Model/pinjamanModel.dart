import 'package:bpr/Model/generalModel.dart';

class PaketPinjaman {
  PaketPinjamanValue value;
  bool status;
  List<MessagesModel> messages;

  PaketPinjaman({this.value, this.status, this.messages});

  PaketPinjaman.fromJson(Map<String, dynamic> json) {
    value = json['Value'] != null ? new PaketPinjamanValue.fromJson(json['Value']) : null;
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
      data['Value'] = this.value.toJson();
    }
    data['Status'] = this.status;
    if (this.messages != null) {
      data['Messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaketPinjamanValue {
  String id;
  String id_paket;
  String nama_paket;
  double bunga;
  int angsuran_maksimal;
  int pinjaman_maksimal;
  String status;
  String admin_no;
  String admin_name;
  DateTime created_at;
  DateTime updated_at;

  PaketPinjamanValue(
      {this.id,
        this.id_paket,
        this.nama_paket,
        this.bunga,
        this.angsuran_maksimal,
        this.pinjaman_maksimal,
        this.status,
        this.admin_no,
        this.admin_name,
        this.created_at,
        this.updated_at});

  PaketPinjamanValue.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? '' : json['id'];
    id_paket = json['id_paket'] == null ? '' : json['id_paket'];
    nama_paket = json['nama_paket'] == null ? '' : json['nama_paket'];
    bunga = json['bunga'] == null ? '' : json['bunga'];
    angsuran_maksimal = json['angsuran_maksimal'] == null ? 0 : json['angsuran_maksimal'] == '' ? 0 : int.parse(json['angsuran_maksimal'].toString());
    pinjaman_maksimal = json['pinjaman_maksimal'] == null ? 0 : json['pinjaman_maksimal'] == '' ? 0 : int.parse(json['pinjaman_maksimal'].toString());
    status = json['status'] == null ? '' : json['status'];
    admin_no = json['admin_no'] == null ? '' : json['admin_no'];
    admin_name = json['admin_name'] == null ? '' : json['admin_name'];
    created_at = json['created_at'] == null ? '' : json['created_at'];
    updated_at = json['updated_at'] == null ? '' : json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_paket'] = this.id_paket;
    data['nama_paket'] = this.nama_paket;
    data['bunga'] = this.bunga;
    data['angsuran_maksimal'] = this.angsuran_maksimal;
    data['pinjaman_maksimal'] = this.pinjaman_maksimal;
    data['status'] = this.status;
    data['admin_no'] = this.admin_no;
    data['admin_name'] = this.admin_name;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}

class Kalkulasi {
  KalkulasiValue value;
  bool status;
  List<MessagesModel> messages;

  Kalkulasi({this.value, this.status, this.messages});

  Kalkulasi.fromJson(Map<String, dynamic> json) {
    value = json['Value'] != null ? new KalkulasiValue.fromJson(json['Value']) : null;
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
      data['Value'] = this.value.toJson();
    }
    data['Status'] = this.status;
    if (this.messages != null) {
      data['Messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class KalkulasiValue {
  String nama_paket;
  int total_pinjaman;
  int lama_pinjaman;
  double bunga;
  int angsuran_total;
  int angsuran_pokok;
  int angsuran_bunga;

  KalkulasiValue(
      {this.nama_paket,
        this.total_pinjaman,
        this.lama_pinjaman,
        this.bunga,
        this.angsuran_total,
        this.angsuran_pokok,
        this.angsuran_bunga});

  KalkulasiValue.fromJson(Map<String, dynamic> json) {
    nama_paket = json['nama_paket'] == null ? '' : json['nama_paket'];
    total_pinjaman = json['total_pinjaman'] == null ? 0 : json['total_pinjaman'] == '' ? 0 : int.parse(json['total_pinjaman'].toString());
    lama_pinjaman = json['lama_pinjaman'] == null ? 0 : json['lama_pinjaman'] == '' ? 0 : int.parse(json['lama_pinjaman'].toString());
    bunga = json['bunga'] == null ? 0 : json['bunga'] == '' ? 0 : double.parse(json['bunga'].toString());
    angsuran_total = json['angsuran_total'] == null ? 0 : json['angsuran_total'] == '' ? 0 : int.parse(json['angsuran_total'].toString());
    angsuran_pokok = json['angsuran_pokok'] == null ? 0 : json['angsuran_pokok'] == '' ? 0 : int.parse(json['angsuran_pokok'].toString());
    angsuran_bunga = json['angsuran_bunga'] == null ? 0 : json['angsuran_bunga'] == '' ? 0 : int.parse(json['angsuran_bunga'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nama_paket'] = this.nama_paket;
    data['total_pinjaman'] = this.total_pinjaman;
    data['lama_pinjaman'] = this.lama_pinjaman;
    data['bunga'] = this.bunga;
    data['angsuran_total'] = this.angsuran_total;
    data['angsuran_pokok'] = this.angsuran_pokok;
    data['angsuran_bunga'] = this.angsuran_bunga;
    return data;
  }
}

class Angsuran {
  List<AngsuranValue> value;
  bool status;
  List<MessagesModel> messages;

  Angsuran({this.value, this.status, this.messages});

  Angsuran.fromJson(Map<String, dynamic> json) {
    if (json['Value'] != null) {
      value = new List<AngsuranValue>();
      json['Value'].forEach((v) {
        value.add(new AngsuranValue.fromJson(v));
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

class AngsuranValue {
  String id;
  String loan_no;
  String angsuran_no;
  String nasabah_no;
  String nama_nasabah;
  String hp1;
  String no_rek;
  String kode_bank;
  int angsuran_ke;
  int angsuran;
  int denda;
  int jumlah_pembayaran;
  int total_pembayaran;
  String status;
  String status_pembayaran;
  String bukti_pembayaran;
  String admin_no;
  String admin_name;
  String tanggal_pembayaran;
  String jatuh_tempo;
  DateTime created_at;
  DateTime updated_at;

  AngsuranValue(
      {this.id,
        this.loan_no,
        this.angsuran_no,
        this.nasabah_no,
        this.nama_nasabah,
        this.hp1,
        this.no_rek,
        this.kode_bank,
        this.angsuran_ke,
        this.angsuran,
        this.denda,
        this.jumlah_pembayaran,
        this.total_pembayaran,
        this.status,
        this.status_pembayaran,
        this.bukti_pembayaran,
        this.admin_no,
        this.admin_name,
        this.tanggal_pembayaran,
        this.jatuh_tempo,
        this.created_at,
        this.updated_at});

  AngsuranValue.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? '' : json['id'];
    loan_no = json['loan_no'] == null ? '' : json['loan_no'];
    angsuran_no = json['angsuran_no'] == null ? '' : json['angsuran_no'];
    nasabah_no = json['nasabah_no'] == null ? '' : json['nasabah_no'];
    nama_nasabah = json['nama_nasabah'] == null ? '' : json['nama_nasabah'];
    hp1 = json['hp1'] == null ? '' : json['hp1'];
    no_rek = json['no_rek'] == null ? '' : json['no_rek'];
    kode_bank = json['kode_bank'] == null ? '' : json['kode_bank'];
    angsuran_ke = json['angsuran_ke'] == null ? 0 : json['angsuran_ke'] == '' ? 0 : int.parse(json['angsuran_ke'].toString());
    angsuran = json['angsuran'] == null ? 0 : json['angsuran'] == '' ? 0 : int.parse(json['angsuran'].toString());
    denda = json['denda'] == null ? 0 : json['denda'] == '' ? 0 : int.parse(json['denda'].toString());
    jumlah_pembayaran = json['jumlah_pembayaran'] == null ? 0 : json['jumlah_pembayaran'] == '' ? 0 : int.parse(json['jumlah_pembayaran'].toString());
    total_pembayaran = json['total_pembayaran'] == null ? 0 : json['total_pembayaran'] == '' ? 0 : int.parse(json['total_pembayaran'].toString());
    status = json['status'] == null ? '' : json['status'];
    status_pembayaran = json['status_pembayaran'] == null ? '' : json['status_pembayaran'];
    bukti_pembayaran = json['bukti_pembayaran'] == null ? '' : json['bukti_pembayaran'];
    admin_no = json['admin_no'] == null ? '' : json['admin_no'];
    admin_name = json['admin_name'] == null ? '' : json['admin_name'];
    tanggal_pembayaran = json['tanggal_pembayaran'] == null ? '' : json['tanggal_pembayaran'];
    jatuh_tempo = json['jatuh_tempo'] == null ? '' : json['jatuh_tempo'];
    created_at = json['created_at'] == null ? '' : json['created_at'];
    updated_at = json['updated_at'] == null ? '' : json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loan_no'] = this.loan_no;
    data['angsuran_no'] = this.angsuran_no;
    data['nasabah_no'] = this.nasabah_no;
    data['nama_nasabah'] = this.nama_nasabah;
    data['hp1'] = this.hp1;
    data['no_rek'] = this.no_rek;
    data['kode_bank'] = this.kode_bank;
    data['angsuran_ke'] = this.angsuran_ke;
    data['angsuran'] = this.angsuran;
    data['denda'] = this.denda;
    data['jumlah_pembayaran'] = this.jumlah_pembayaran;
    data['total_pembayaran'] = this.total_pembayaran;
    data['status'] = this.status;
    data['status_pembayaran'] = this.status_pembayaran;
    data['bukti_pembayaran'] = this.bukti_pembayaran;
    data['admin_no'] = this.admin_no;
    data['admin_name'] = this.admin_name;
    data['tanggal_pembayaran'] = this.tanggal_pembayaran;
    data['jatuh_tempo'] = this.jatuh_tempo;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}

class Pinjaman {
  PinjamanValue value;
  bool status;
  List<MessagesModel> messages;

  Pinjaman({this.value, this.status, this.messages});

  Pinjaman.fromJson(Map<String, dynamic> json) {
    value = json['Value'] != null ? new PinjamanValue.fromJson(json['Value']) : null;
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
      data['Value'] = this.value.toJson();
    }
    data['Status'] = this.status;
    if (this.messages != null) {
      data['Messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PinjamanValue {
  String id;
  String loan_no;
  String nasabah_no;
  String nama_nasabah;
  String hp1;
  String kode_bank;
  String no_rek;
  String status;
  String nama_paket;
  int total_pinjaman;
  int lama_pinjaman;
  double bunga;
  int angsuran_total;
  int angsuran_pokok;
  int angsuran_bunga;
  int bunga_total;
  String admin_no;
  String admin_name;
  String tanggal_pencairan;
  DateTime created_at;
  DateTime updated_at;

  PinjamanValue(
      {this.id,
        this.loan_no,
        this.nasabah_no,
        this.nama_nasabah,
        this.hp1,
        this.kode_bank,
        this.no_rek,
        this.status,
        this.nama_paket,
        this.total_pinjaman,
        this.lama_pinjaman,
        this.bunga,
        this.angsuran_total,
        this.angsuran_pokok,
        this.angsuran_bunga,
        this.bunga_total,
        this.admin_no,
        this.admin_name,
        this.tanggal_pencairan,
        this.created_at,
        this.updated_at});

  PinjamanValue.fromJson(Map<String, dynamic> json) {
    id = json['id'] == null ? '' : json['id'];
    loan_no = json['loan_no'] == null ? '' : json['loan_no'];
    nasabah_no = json['nasabah_no'] == null ? '' : json['nasabah_no'];
    nama_nasabah = json['nama_nasabah'] == null ? '' : json['nama_nasabah'];
    hp1 = json['hp1'] == null ? '' : json['hp1'];
    kode_bank = json['kode_bank'] == null ? '' : json['kode_bank'];
    no_rek = json['no_rek'] == null ? '' : json['no_rek'];
    status = json['status'] == null ? '' : json['status'];
    nama_paket = json['nama_paket'] == null ? '' : json['nama_paket'];
    total_pinjaman = json['total_pinjaman'] == null ? 0 : json['total_pinjaman'] == '' ? 0 : int.parse(json['total_pinjaman'].toString());
    lama_pinjaman = json['lama_pinjaman'] == null ? 0 : json['lama_pinjaman'] == '' ? 0 : int.parse(json['lama_pinjaman'].toString());
    bunga = json['bunga'] == null ? 0 : json['bunga'] == '' ? 0 : double.parse(json['bunga'].toString());
    angsuran_total = json['angsuran_total'] == null ? 0 : json['angsuran_total'] == '' ? 0 : int.parse(json['angsuran_total'].toString());
    angsuran_pokok = json['angsuran_pokok'] == null ? 0 : json['angsuran_pokok'] == '' ? 0 : int.parse(json['angsuran_pokok'].toString());
    angsuran_bunga = json['angsuran_bunga'] == null ? 0 : json['angsuran_bunga'] == '' ? 0 : int.parse(json['angsuran_bunga'].toString());
    bunga_total = json['bunga_total'] == null ? 0 : json['bunga_total'] == '' ? 0 : int.parse(json['bunga_total'].toString());
    admin_no = json['admin_no'] == null ? '' : json['admin_no'];
    admin_name = json['admin_name'] == null ? '' : json['admin_name'];
    tanggal_pencairan = json['tanggal_pencairan'] == null ? '' : json['tanggal_pencairan'];
    created_at = json['created_at'] == null ? '' : json['created_at'];
    updated_at = json['updated_at'] == null ? '' : json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loan_no'] = this.loan_no;
    data['nasabah_no'] = this.nasabah_no;
    data['nama_nasabah'] = this.nama_nasabah;
    data['hp1'] = this.hp1;
    data['kode_bank'] = this.kode_bank;
    data['no_rek'] = this.no_rek;
    data['status'] = this.status;
    data['nama_paket'] = this.nama_paket;
    data['total_pinjaman'] = this.total_pinjaman;
    data['lama_pinjaman'] = this.lama_pinjaman;
    data['bunga'] = this.bunga;
    data['angsuran_total'] = this.angsuran_total;
    data['angsuran_pokok'] = this.angsuran_pokok;
    data['angsuran_bunga'] = this.angsuran_bunga;
    data['bunga_total'] = this.bunga_total;
    data['admin_no'] = this.admin_no;
    data['admin_name'] = this.admin_name;
    data['tanggal_pencairan'] = this.tanggal_pencairan;
    data['created_at'] = this.created_at;
    data['updated_at'] = this.updated_at;
    return data;
  }
}