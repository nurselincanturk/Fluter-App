// class Prices {
//   String storeId;
//   String price;
//   String productId;
//   DateTime dicountRate;

//   Prices(
//       {this.storeId,
//       this.price,
//       this.dicountRate,
//       this.productId,});
// }
class Prices {
 String storeId;
  String productId;
  DateTime dicountRate;
  List<String> price;

  Prices({this.storeId,this.dicountRate,this.price,this.productId});

  Prices.fromJson(Map<String, dynamic> json) {
    storeId = json['storeId'];    
    dicountRate = json['dicountRate'];
    productId = json['productId'];
    price = json['price'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['storeId'] = this.storeId;
    data['price'] = this.price;
    data['productId'] = this.productId;
    data['discountRate'] = this.dicountRate;

    return data;
  }
}