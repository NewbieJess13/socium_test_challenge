import 'dart:convert';

import 'package:socium_test_challenge/models/products.dart';
import 'package:http/http.dart' as http;

import '../constants/api_const.dart';
import '../models/product.dart';

class ProductServices {
  Future<Products?> getProducts({int skip = 0}) async {
    String url =
        '${ApiConst.baseUrl}?limit=10&skip=$skip&select=title,price,thumbnail,stock,discountPercentage';

    var uri = Uri.parse(url);
    Products? products;
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedResponse = jsonDecode(response.body);
      products = Products.fromJson(parsedResponse);
    }
    return products;
  }

  Future<Product?> getProduct(int id) async {
    String url = '${ApiConst.baseUrl}/$id';

    var uri = Uri.parse(url);
    Product? product;
    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedResponse = jsonDecode(response.body);
      product = Product.fromJson(parsedResponse);
    }
    return product;
  }
}
