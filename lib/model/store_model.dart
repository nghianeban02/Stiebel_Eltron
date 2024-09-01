class StoreModel {
  String? staffCreate;
  String? createDate;
  String? staffUpdate;
  String? updateDate;
  int? id;
  String? code;
  String? name;
  String? phone;
  String? phone1;
  String? phone2;
  int? longitude;
  int? latitude;
  String? hotline;
  String? addressFull;
  bool? status;

  StoreModel(
      {this.staffCreate,
      this.createDate,
      this.staffUpdate,
      this.updateDate,
      this.id,
      this.code,
      this.name,
      this.phone,
      this.phone1,
      this.phone2,
      this.longitude,
      this.latitude,
      this.hotline,
      this.addressFull,
      this.status});

  StoreModel.fromJson(Map<String, dynamic> json) {
    staffCreate = json['staffCreate'];
    createDate = json['createDate'];
    staffUpdate = json['staffUpdate'];
    updateDate = json['updateDate'];
    id = json['id'];
    code = json['code'];
    name = json['name'];
    phone = json['phone'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    hotline = json['hotline'];
    addressFull = json['addressFull'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffCreate'] = this.staffCreate;
    data['createDate'] = this.createDate;
    data['staffUpdate'] = this.staffUpdate;
    data['updateDate'] = this.updateDate;
    data['id'] = this.id;
    data['code'] = this.code;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['hotline'] = this.hotline;
    data['addressFull'] = this.addressFull;
    data['status'] = this.status;
    return data;
  }
}