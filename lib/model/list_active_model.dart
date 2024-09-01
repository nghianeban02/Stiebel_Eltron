class ListActiveModel {
  int? pageIndex;
  int? pageSize;
  int? totalPages;
  int? totalData;
  List<ListDataActive>? listData;

  ListActiveModel(
      {this.pageIndex,
      this.pageSize,
      this.totalPages,
      this.totalData,
      this.listData});

  ListActiveModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalPages = json['totalPages'];
    totalData = json['totalData'];
    if (json['listData'] != null) {
      listData = <ListDataActive>[];
      json['listData'].forEach((v) {
        listData!.add(new ListDataActive.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalPages'] = this.totalPages;
    data['totalData'] = this.totalData;
    if (this.listData != null) {
      data['listData'] = this.listData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListDataActive {
  String? staffCreate;
  String? createDate;
  String? staffUpdate;
  String? updateDate;
  int? status;
  int? id;
  String? serial;
  int? modelId;
  String? modelName;
  String? modelCode;
  int? categoryId;
  String? categoryName;
  String? categoryCode;
  double? price;
  String? yearManufacture;
  String? dateExportStock;
  int? partnerId;
  String? partnerName;
  String? partnerCode;
  int? statusActive;
  String? customerIdActiveData;
  String? customerNameActiveData;
  String? sku;

  ListDataActive(
      {this.staffCreate,
      this.createDate,
      this.staffUpdate,
      this.updateDate,
      this.status,
      this.id,
      this.serial,
      this.modelId,
      this.modelName,
      this.modelCode,
      this.categoryId,
      this.categoryName,
      this.categoryCode,
      this.price,
      this.yearManufacture,
      this.dateExportStock,
      this.partnerId,
      this.partnerName,
      this.partnerCode,
      this.statusActive,
      this.customerIdActiveData,
      this.customerNameActiveData,
      this.sku});

  ListDataActive.fromJson(Map<String, dynamic> json) {
    staffCreate = json['staffCreate'];
    createDate = json['createDate']??DateTime.now().toString();
    staffUpdate = json['staffUpdate'];
    updateDate = json['updateDate'];
    status = json['status'];
    id = json['id'];
    serial = json['serial'];
    modelId = json['modelId'];
    modelName = json['modelName'];
    modelCode = json['modelCode'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    categoryCode = json['categoryCode'];
    price = json['price'];
    yearManufacture = json['yearManufacture'];
    dateExportStock = json['dateExportStock'];
    partnerId = json['partnerId'];
    partnerName = json['partnerName'];
    partnerCode = json['partnerCode'];
    statusActive = json['statusActive'];
    customerIdActiveData = json['customerIdActiveData'];
    customerNameActiveData = json['customerNameActiveData'];
    sku = json['sku'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staffCreate'] = this.staffCreate;
    data['createDate'] = this.createDate;
    data['staffUpdate'] = this.staffUpdate;
    data['updateDate'] = this.updateDate;
    data['status'] = this.status;
    data['id'] = this.id;
    data['serial'] = this.serial;
    data['modelId'] = this.modelId;
    data['modelName'] = this.modelName;
    data['modelCode'] = this.modelCode;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['categoryCode'] = this.categoryCode;
    data['price'] = this.price;
    data['yearManufacture'] = this.yearManufacture;
    data['dateExportStock'] = this.dateExportStock;
    data['partnerId'] = this.partnerId;
    data['partnerName'] = this.partnerName;
    data['partnerCode'] = this.partnerCode;
    data['statusActive'] = this.statusActive;
    data['customerIdActiveData'] = this.customerIdActiveData;
    data['customerNameActiveData'] = this.customerNameActiveData;
    data['sku'] = this.sku;
    return data;
  }
  String get getStatus=> status==1?'Thành công':status==0?"Chờ duyệt":"Từ chối";

}
