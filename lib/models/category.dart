
class Category {
  String catName;

  Category({this.catName});

  Category.fromJson(Map<String, dynamic> json) {
    catName = json['catName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catName'] = this.catName;
    return data;
  }
}