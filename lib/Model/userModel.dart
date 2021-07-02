import 'package:bpr/Model/generalModel.dart';

class GenderModel {
  String code;
  String gender;

  GenderModel({
    this.code
    , this.gender});

  factory GenderModel.fromJson(Map<String, dynamic> json) {
    return new GenderModel(
      code: json['code'] == null ? '' : json['code'],
      gender: json['gender'] == null ? '' : json['gender'],
    );
  }
}

class User {
  UserModel Value;
  bool status;
  List<MessagesModel> messages;

  User({this.Value, this.status, this.messages});

  User.fromJson(Map<String, dynamic> json) {
    Value =
    json['Value'] != null ? new UserModel.fromJson(json['Value']) : null;
    status = json['Status'];
    if (json['Messages'] != null) {
      messages = new List<MessagesModel>();
      json['Messages'].forEach((v) {
        messages.add(new MessagesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.Value != null) {
      data['Value'] = this.Value.toJson();
    }
    data['Status'] = this.status;
    if (this.messages != null) {
      data['Messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserModel {
  String id;
  String token;
  String nasabah_no ;
  String status;
  String nama;
  String gender;
  String hp1;
  String hp2;
  double balance;
  String email;
  String password;
  int tempat_lahir;
  String tanggal_lahir;
  String user_bank;
  String no_rek;
  String nama_bank;
  String kode_bank;
  String alamat;
  String nomor_rt;
  String nomor_rw;
  int domicilecity;
  String kelurahan;
  String kecamatan;
  String photo;
  String photo_ktp;
  String nik;
  String nama_family;
  String hp_family;
  int tempat_lahir_family;
  String tanggal_lahir_family;
  String alamat_family;
  String nomor_rt_family;
  String nomor_rw_family;
  int domicilecity_family;
  String kelurahan_family;
  String kecamatan_family;
  String nama_job;
  String jabatan;
  String nama_perusahaan;
  double salary;
  DateTime created_at;
  DateTime updated_at;

  UserModel(
      {this.id,
        this.token,
        this.nasabah_no,
        this.status,
        this.nama,
        this.gender,
        this.hp1,
        this.hp2,
        this.balance,
        this.email,
        this.password,
        this.tempat_lahir,
        this.tanggal_lahir,
        this.user_bank,
        this.no_rek,
        this.nama_bank,
        this.kode_bank,
        this.alamat,
        this.nomor_rt,
        this.nomor_rw,
        this.domicilecity,
        this.kelurahan,
        this.kecamatan,
        this.photo,
        this.photo_ktp,
        this.nik,
        this.nama_family,
        this.hp_family,
        this.tempat_lahir_family,
        this.tanggal_lahir_family,
        this.alamat_family,
        this.nomor_rt_family,
        this.nomor_rw_family,
        this.domicilecity_family,
        this.kelurahan_family,
        this.kecamatan_family,
        this.nama_job,
        this.jabatan,
        this.nama_perusahaan,
        this.salary,
        this.created_at,
        this.updated_at});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] == null ? '' : json['id'],
      token: json['token'] == null ? '' : json['token'],
      nasabah_no: json['nasabah_no'] == null ? '' : json['nasabah_no'],
      status: json['status'] == null ? '' : json['status'],
      nama: json['nama'] == null ? '' : json['nama'],
      gender: json['gender'] == null ? '' : json['gender'],
      hp1: json['hp1'] == null ? '' : json['hp1'],
      hp2: json['hp2'] == null ? '' : json['hp2'],
      balance: json['balance'] == null ? 0 : json['balance'] == '' ? 0 : double.parse(json['balance'].toString()),
      tempat_lahir: json['tempat_lahir'] == null ? 0 : json['tempat_lahir'] == '' ? 0 : int.parse(json['tempat_lahir'].toString()),
      email: json['email'] == null ? '' : json['email'],
      password: json['password'] == null ? '' : json['password'],
      tanggal_lahir: json['tanggal_lahir'] == null ? '' : json['tanggal_lahir'],
      user_bank: json['user_bank'] == null ? '' : json['user_bank'],
      no_rek: json['no_rek'] == null ? '' : json['no_rek'],
      nama_bank: json['nama_bank'] == null ? '' : json['nama_bank'],
      kode_bank: json['kode_bank'] == null ? '' : json['kode_bank'],
      alamat: json['alamat'] == null ? '' : json['alamat'],
      nomor_rt: json['nomor_rt'] == null ? '' : json['nomor_rt'],
      nomor_rw: json['nomor_rw'] == null ? '' : json['nomor_rw'],
      domicilecity: json['domicilecity'] == null ? 0 : json['domicilecity'] == '' ? 0 : int.parse(json['domicilecity'].toString()),
      kelurahan: json['kelurahan'] == null ? '' : json['kelurahan'],
      kecamatan: json['kecamatan'] == null ? '' : json['kecamatan'],
      photo: json['photo'] == null ? '' : json['photo'],
      photo_ktp: json['photo_ktp'] == null ? '' : json['photo_ktp'],
      nik: json['nik'] == null ? '' : json['nik'],
      nama_family: json['nama_family'] == null ? '' : json['nama_family'],
      hp_family: json['hp_family'] == null ? '' : json['hp_family'],
      tempat_lahir_family: json['tempat_lahir_family'] == null ? 0 : json['tempat_lahir_family'] == ''
          ? 0 : int.parse(json['tempat_lahir_family'].toString()),
      tanggal_lahir_family: json['tanggal_lahir_family'] == null ? '' : json['tanggal_lahir_family'],
      alamat_family: json['alamat_family'] == null ? '' : json['alamat_family'],
      nomor_rt_family: json['nomor_rt_family'] == null ? '' : json['nomor_rt_family'],
      nomor_rw_family: json['nomor_rw_family'] == null ? '' : json['nomor_rw'],
      domicilecity_family: json['domicilecity_family'] == null ? 0 : json['domicilecity_family'] == ''
          ? 0 : int.parse(json['domicilecity_family'].toString()),
      kelurahan_family: json['kelurahan_family'] == null ? '' : json['kelurahan_family'],
      kecamatan_family: json['kecamatan_family'] == null ? '' : json['kecamatan_family'],
      nama_job: json['nama_job'] == null ? '' : json['nama_job'],
      jabatan: json['jabatan'] == null ? '' : json['jabatan'],
      nama_perusahaan: json['nama_perusahaan'] == null ? '' : json['nama_perusahaan'],
      salary: json['salary'] == null ? 0 : json['salary'] == '' ? 0 : double.parse(json['salary'].toString()),
      created_at: json['created_at'] == null ? '' : DateTime.parse(json['created_at'].toString()),
      updated_at: json['updated_at'] == null ? '' : DateTime.parse(json['updated_at'].toString()),
    );
  }

  Map toJson() => {
    'token' : token == null ? '' : token,
    'nasabah_no' : nasabah_no == null ? '' : nasabah_no,
    'status' : status == null ? '' : status,
    'nama': nama == null ? '' : nama,
    'gender': gender == null ? '' : gender,
    'hp1': hp1 == null ? '' : hp1,
    'hp2': hp2 == null ? '' : hp2,
    'email': email == null ? '' : email,
    'password': password == null ? '' : password,
    'tempat_lahir': tempat_lahir.toString() == null ? '' : tempat_lahir,
    'tanggal_lahir': tanggal_lahir == null ? '' : tanggal_lahir,
    'user_bank': user_bank == null ? '' : user_bank,
    'no_rek': no_rek == null ? '' : no_rek,
    'nama_bank': nama_bank == null ? '' : nama_bank,
    'kode_bank': kode_bank == null ? '' : kode_bank,
    'alamat': alamat == null ? '' : alamat,
    'nomor_rt': nomor_rt == null ? '' : nomor_rt,
    'nomor_rw': nomor_rw == null ? '' : nomor_rw,
    'domicilecity': domicilecity.toString() == null ? '' : domicilecity.toString(),
    'kelurahan': kelurahan == null ? '' : kelurahan,
    'kecamatan': kecamatan == null ? '' : kecamatan,
    'photo': photo == null ? '' : photo,
    'photo_ktp': photo_ktp == null ? '' : photo_ktp,
    'nik': nik == null ? '' : nik,
    'nama_family': nama_family == null ? '' : nama_family,
    'hp_family': hp_family == null ? '' : hp_family,
    'tempat_lahir_family': tempat_lahir_family.toString() == null ? '' : tempat_lahir_family,
    'tanggal_lahir_family': tanggal_lahir_family == null ? '' : tanggal_lahir_family,
    'alamat_family': alamat_family == null ? '' : alamat_family,
    'nomor_rt_family': nomor_rt_family == null ? '' : nomor_rt_family,
    'nomor_rw_family': nomor_rw_family == null ? '' : nomor_rw_family,
    'domicilecity_family': domicilecity_family.toString() == null ? '' : domicilecity_family.toString(),
    'kelurahan_family': kelurahan_family == null ? '' : kelurahan_family,
    'kecamatan_family': kecamatan_family == null ? '' : kecamatan_family,
    'nama_job': nama_job == null ? '' : nama_job,
    'jabatan': jabatan == null ? '' : jabatan,
    'nama_perusahaan': nama_perusahaan == null ? '' : nama_perusahaan,
    'salary': salary == null ? '' : salary,
    'created_at': created_at.toString() == null ? '' : created_at.toString(),
    'updated_at': updated_at.toString() == null ? '' : updated_at.toString(),
  };
}
