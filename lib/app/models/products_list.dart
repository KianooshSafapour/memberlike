import 'package:memberlike/app/models/response/product_response.dart';

class ProductList {
  String title;
  List<Product> products;

  ProductList({required this.title, required this.products});

  ProductList.fromJson(Map<String, dynamic> json, List<Product> serviceProducts)
    : title = json["title"],
      products = serviceProducts;
}
