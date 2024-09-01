class SearchActiveModel {
  int? id;
  int? modelId;
  String? modelName;
  int? categoryId;
  String? categoryCode;
  String? categoryName;
  int? statusActive;

  SearchActiveModel(
      {this.id,
      this.modelId,
      this.modelName,
      this.categoryId,
      this.categoryCode,
      this.categoryName,
      this.statusActive});

  SearchActiveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelId = json['modelId'];
    modelName = json['modelName'];
    categoryId = json['categoryId'];
    categoryCode = json['categoryCode'];
    categoryName = json['categoryName'];
    statusActive = json['statusActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['modelId'] = this.modelId;
    data['modelName'] = this.modelName;
    data['categoryId'] = this.categoryId;
    data['categoryCode'] = this.categoryCode;
    data['categoryName'] = this.categoryName;
    data['statusActive'] = this.statusActive;
    return data;
  }
}