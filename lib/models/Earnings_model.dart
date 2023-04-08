class EarningsModel {
  String? monthearnings;
  String? totalorder;
  String? month;

  EarningsModel({this.monthearnings, this.totalorder});

  EarningsModel.fromJson(Map<String, dynamic> json) {
    monthearnings = json['monthearnings'];
    totalorder = json['totalorder'];
    month = json["month"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['monthearnings'] = this.monthearnings;
    data['totalorder'] = this.totalorder;
    data["month"] = this.month;
    return data;
  }
}