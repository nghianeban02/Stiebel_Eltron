class UserModel {
  String? account;
  String? idGroupUser;
  String? nameGroupUser;
  String? username;
  Staff? staff;
  Asc? asc;
  String? fullName;
  String? partner;

  UserModel(
      {this.account,
      this.idGroupUser,
      this.nameGroupUser,
      this.username,
      this.staff,
      this.asc,
      this.fullName,
      this.partner
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    account = json['account'];
    idGroupUser = json['idGroupUser'];
    nameGroupUser = json['nameGroupUser'];
    username = json['username'];
    // staff = json['staff'] != null ? new Staff.fromJson(json['staff']) : null;
    // asc = json['asc'] != null ? new Asc.fromJson(json['asc']) : null;
    fullName = json['fullName'];
    partner = json['partner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['account'] = this.account;
    data['idGroupUser'] = this.idGroupUser;
    data['nameGroupUser'] = this.nameGroupUser;
    data['username'] = this.username;
    // if (this.staff != null) {
    //   data['staff'] = this.staff!.toJson();
    // }
    // if (this.asc != null) {
    //   data['asc'] = this.asc!.toJson();
    // }
    data['fullName'] = this.fullName;
    data['partner'] = this.partner;
    return data;
  }

  static UserModel userEmpty() {
    return UserModel(
      account: '',
      idGroupUser: '',
      nameGroupUser: '',
      username: '',
      fullName: '',
      partner: '',
    );
  }
}

class Staff {
  int? id;
  int? idAsc;
  String? nameAsc;
  String? code;
  String? surname;
  String? middleName;
  String? name;
  String? fullName;
  String? mail;
  String? phone;
  String? phone1;
  int? idCity;
  Null? cityName;
  int? idDistrict;
  Null? districtName;
  int? idWard;
  Null? wardName;
  Null? street;
  Null? fullAddress;
  Null? noIdentity;
  Null? idUserCreate;
  Null? avatar;
  String? staffCreate;
  String? createDate;
  Null? staffUpdate;
  Null? updateDate;
  bool? status;

  Staff(
      {this.id,
      this.idAsc,
      this.nameAsc,
      this.code,
      this.surname,
      this.middleName,
      this.name,
      this.fullName,
      this.mail,
      this.phone,
      this.phone1,
      this.idCity,
      this.cityName,
      this.idDistrict,
      this.districtName,
      this.idWard,
      this.wardName,
      this.street,
      this.fullAddress,
      this.noIdentity,
      this.idUserCreate,
      this.avatar,
      this.staffCreate,
      this.createDate,
      this.staffUpdate,
      this.updateDate,
      this.status});

  Staff.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idAsc = json['idAsc'];
    nameAsc = json['nameAsc'];
    code = json['code'];
    surname = json['surname'];
    middleName = json['middleName'];
    name = json['name'];
    fullName = json['fullName'];
    mail = json['mail'];
    phone = json['phone'];
    phone1 = json['phone1'];
    idCity = json['idCity'];
    cityName = json['cityName'];
    idDistrict = json['idDistrict'];
    districtName = json['districtName'];
    idWard = json['idWard'];
    wardName = json['wardName'];
    street = json['street'];
    fullAddress = json['fullAddress'];
    noIdentity = json['noIdentity'];
    idUserCreate = json['idUserCreate'];
    avatar = json['avatar'];
    staffCreate = json['staffCreate'];
    createDate = json['createDate'];
    staffUpdate = json['staffUpdate'];
    updateDate = json['updateDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idAsc'] = this.idAsc;
    data['nameAsc'] = this.nameAsc;
    data['code'] = this.code;
    data['surname'] = this.surname;
    data['middleName'] = this.middleName;
    data['name'] = this.name;
    data['fullName'] = this.fullName;
    data['mail'] = this.mail;
    data['phone'] = this.phone;
    data['phone1'] = this.phone1;
    data['idCity'] = this.idCity;
    data['cityName'] = this.cityName;
    data['idDistrict'] = this.idDistrict;
    data['districtName'] = this.districtName;
    data['idWard'] = this.idWard;
    data['wardName'] = this.wardName;
    data['street'] = this.street;
    data['fullAddress'] = this.fullAddress;
    data['noIdentity'] = this.noIdentity;
    data['idUserCreate'] = this.idUserCreate;
    data['avatar'] = this.avatar;
    data['staffCreate'] = this.staffCreate;
    data['createDate'] = this.createDate;
    data['staffUpdate'] = this.staffUpdate;
    data['updateDate'] = this.updateDate;
    data['status'] = this.status;
    return data;
  }
}

class Asc {
  int? id;
  String? code;
  String? name;
  Null? street;
  String? phone;
  Null? website;
  Null? taxCode;
  double? longitude;
  double? latitude;
  Null? phone1;
  Null? phone2;
  Null? hotline;
  int? idCity;
  Null? cityName;
  int? idDistrict;
  Null? districtName;
  int? idWard;
  Null? wardName;
  String? addressFull;
  Null? companyName;
  Null? companyAddress;
  Null? fax;
  String? email;
  Null? idBank;
  Null? bankName;
  Null? bankNo;
  String? reportName;
  Null? reportPhone;
  Null? reportEmail;
  Null? ascManager;
  Null? ascPhone;
  Null? ascEmail;
  Null? idExpress;
  String? coach;
  int? status;
  String? staffCreate;
  String? createDate;
  Null? staffUpdate;
  Null? updateDate;

  Asc(
      {this.id,
      this.code,
      this.name,
      this.street,
      this.phone,
      this.website,
      this.taxCode,
      this.longitude,
      this.latitude,
      this.phone1,
      this.phone2,
      this.hotline,
      this.idCity,
      this.cityName,
      this.idDistrict,
      this.districtName,
      this.idWard,
      this.wardName,
      this.addressFull,
      this.companyName,
      this.companyAddress,
      this.fax,
      this.email,
      this.idBank,
      this.bankName,
      this.bankNo,
      this.reportName,
      this.reportPhone,
      this.reportEmail,
      this.ascManager,
      this.ascPhone,
      this.ascEmail,
      this.idExpress,
      this.coach,
      this.status,
      this.staffCreate,
      this.createDate,
      this.staffUpdate,
      this.updateDate});

  Asc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    street = json['street'];
    phone = json['phone'];
    website = json['website'];
    taxCode = json['taxCode'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    hotline = json['hotline'];
    idCity = json['idCity'];
    cityName = json['cityName'];
    idDistrict = json['idDistrict'];
    districtName = json['districtName'];
    idWard = json['idWard'];
    wardName = json['wardName'];
    addressFull = json['addressFull'];
    companyName = json['companyName'];
    companyAddress = json['companyAddress'];
    fax = json['fax'];
    email = json['email'];
    idBank = json['idBank'];
    bankName = json['bankName'];
    bankNo = json['bankNo'];
    reportName = json['reportName'];
    reportPhone = json['reportPhone'];
    reportEmail = json['reportEmail'];
    ascManager = json['ascManager'];
    ascPhone = json['ascPhone'];
    ascEmail = json['ascEmail'];
    idExpress = json['idExpress'];
    coach = json['coach'];
    status = json['status'];
    staffCreate = json['staffCreate'];
    createDate = json['createDate'];
    staffUpdate = json['staffUpdate'];
    updateDate = json['updateDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['street'] = this.street;
    data['phone'] = this.phone;
    data['website'] = this.website;
    data['taxCode'] = this.taxCode;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['hotline'] = this.hotline;
    data['idCity'] = this.idCity;
    data['cityName'] = this.cityName;
    data['idDistrict'] = this.idDistrict;
    data['districtName'] = this.districtName;
    data['idWard'] = this.idWard;
    data['wardName'] = this.wardName;
    data['addressFull'] = this.addressFull;
    data['companyName'] = this.companyName;
    data['companyAddress'] = this.companyAddress;
    data['fax'] = this.fax;
    data['email'] = this.email;
    data['idBank'] = this.idBank;
    data['bankName'] = this.bankName;
    data['bankNo'] = this.bankNo;
    data['reportName'] = this.reportName;
    data['reportPhone'] = this.reportPhone;
    data['reportEmail'] = this.reportEmail;
    data['ascManager'] = this.ascManager;
    data['ascPhone'] = this.ascPhone;
    data['ascEmail'] = this.ascEmail;
    data['idExpress'] = this.idExpress;
    data['coach'] = this.coach;
    data['status'] = this.status;
    data['staffCreate'] = this.staffCreate;
    data['createDate'] = this.createDate;
    data['staffUpdate'] = this.staffUpdate;
    data['updateDate'] = this.updateDate;
    return data;
  }
}