import 'package:flutter/cupertino.dart';
import 'package:store_api_flutter_course/models/categories_model.dart';

class ProductsModel with ChangeNotifier {
  int? id;
  String? title;
  int? price;
  String? description;
  CategoriesModel? category;
  List<String>? images;

  ProductsModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.images});

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'] != null
        ? new CategoriesModel.fromJson(json['category'])
        : null;
    images = json['images'].cast<String>();
  }
  static List<ProductsModel> productsFromSnapshot(List productSnapshot) {
    return productSnapshot.map((data) {
      //print('data $data');
      return ProductsModel.fromJson(data);
    }).toList();
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['title'] = this.title;
  //   data['price'] = this.price;
  //   data['description'] = this.description;
  //   if (this.category != null) {
  //     data['category'] = this.category!.toJson();
  //   }
  //   data['images'] = this.images;
  //   return data;
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['image'] = this.image;
  //   return data;
  // }
}
