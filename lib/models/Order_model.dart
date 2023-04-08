class OrdersModel {
  String? date;
  String? orderval;
  String? totalbags;
  String? orderno;
  String? myearning;
  Items? items;

  OrdersModel(
      {this.date,
      this.orderval,
      this.totalbags,
      this.orderno,
      this.myearning,
      this.items});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    orderval = json['orderval'];
    totalbags = json['totalbags'];
    orderno = json['orderno'];
    myearning = json['myearning'];
    items = json['items'] != null ? new Items.fromJson(json['items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['orderval'] = this.orderval;
    data['totalbags'] = this.totalbags;
    data['orderno'] = this.orderno;
    data['myearning'] = this.myearning;
    if (this.items != null) {
      data['items'] = this.items!.toJson();
    }
    return data;
  }
}

class Items {
  String? totalBags;
  String? churi;
  String? binola;
  String? khal;
  String? cattleFeed;

  Items({this.totalBags, this.churi, this.binola, this.khal, this.cattleFeed});

  Items.fromJson(Map<String, dynamic> json) {
    totalBags = json['Total Bags'];
    churi = json['Churi'];
    binola = json['Binola'];
    khal = json['Khal'];
    cattleFeed = json['Cattle Feed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Total Bags'] = this.totalBags;
    data['Churi'] = this.churi;
    data['Binola'] = this.binola;
    data['Khal'] = this.khal;
    data['Cattle Feed'] = this.cattleFeed;
    return data;
  }
}