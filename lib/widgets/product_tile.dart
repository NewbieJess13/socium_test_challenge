import 'package:flutter/material.dart';
import 'package:socium_test_challenge/constants/assets_const.dart';
import 'package:socium_test_challenge/models/product.dart';

import '../helpers/formulas.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});

  final Product product;

  bool isLimitedStocks() => product.stock <= 20;

  @override
  Widget build(BuildContext context) {
    final discountedPrice = Formulas.calculateDiscount(
            double.parse(product.discountPercentage), product.price)
        .toStringAsFixed(2);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  spreadRadius: 3,
                  blurRadius: 3,
                  color: Colors.black26,
                  offset: Offset(2, 3))
            ],
            borderRadius: BorderRadius.circular(6),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                  tag: product.id,
                  child: FadeInImage.assetNetwork(
                    placeholder: AssetsConst.placeholderProdImg,
                    image: product.thumbnailUrl,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '\$$discountedPrice',
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.red),
                    ),
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.lineThrough,
                          fontSize: 10,
                          color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        isLimitedStocks()
            ? Positioned(
                top: 5,
                right: 5,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 230, 102, 92),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    'Only ${product.stock} items left',
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
