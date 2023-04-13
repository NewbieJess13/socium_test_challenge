import 'package:flutter_test/flutter_test.dart';
import 'package:socium_test_challenge/models/product.dart';
import 'package:socium_test_challenge/models/products.dart';
import 'package:socium_test_challenge/services/product_api_service.dart';

void main() {
  ProductServices productServices = ProductServices();
  test("Fetching products from api", () async {
    bool success = false;

    Products? result = await productServices.getProducts();

    if (result != null) {
      success = true;
    }

    expect(success, true);
  });

  test("Fetching single product from api", () async {
    bool success = false;
    int sampleId = 22;
    Product? result = await productServices.getProduct(sampleId);

    if (result != null) {
      success = true;
    }

    expect(success, true);
  });
}
