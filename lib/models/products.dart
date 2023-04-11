import 'package:socium_test_challenge/models/product.dart';

class Products {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  Products(this.products, this.total, this.skip, this.limit);

  factory Products.fromJson(Map<String, dynamic> json) => Products(
      (json['products'] as List)
          .map((product) => Product.fromJson(product))
          .toList(),
      json['total'],
      json['skip'],
      json['limit']);
}
