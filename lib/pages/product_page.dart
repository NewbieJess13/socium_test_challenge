import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socium_test_challenge/constants/assets_const.dart';
import 'package:socium_test_challenge/constants/text_consts.dart';
import 'package:socium_test_challenge/models/product.dart';
import 'package:star_rating/star_rating.dart';

import '../helpers/formulas.dart';
import '../services/product_api_service.dart';

class ProductPage extends StatefulWidget {
  final int id;

  const ProductPage({super.key, required this.id});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductServices _productServices = ProductServices();
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Product?>(
          future: _productServices.getProduct(widget.id),
          builder: (context, snapshot) {
            Widget widgetDisplay = Container();
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                widgetDisplay = const Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  Product product = snapshot.data!;
                  final discountedPrice = Formulas.calculateDiscount(
                          double.parse(product.discountPercentage),
                          product.price)
                      .toStringAsFixed(2);
                  widgetDisplay = CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        expandedHeight: 280,
                        // floating: true,
                        // snap: true,
                        pinned: true,
                        flexibleSpace: Hero(
                          tag: product.id,
                          child: FlutterCarousel(
                            options: CarouselOptions(
                              height: 400.0,
                              showIndicator: true,
                              slideIndicator: const CircularSlideIndicator(),
                            ),
                            items: product.images!.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return FadeInImage.assetNetwork(
                                    placeholder: AssetsConst.placeholderProdImg,
                                    image: product.thumbnailUrl,
                                    fit: BoxFit.cover,
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        sliver: SliverList(
                            delegate: SliverChildListDelegate([
                          Text(
                            product.title,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StarRating(
                            mainAxisAlignment: MainAxisAlignment.start,
                            color: Colors.yellow,
                            length: 5,
                            rating: snapshot.data!.rating!,
                            between: 5.0,
                            starSize: 20.0,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            '\$$discountedPrice',
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                                color: Colors.red),
                          ),
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.lineThrough,
                                fontSize: 15,
                                color: Colors.black.withOpacity(.5)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Brand: ${snapshot.data!.brand!}',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            snapshot.data!.description ?? '',
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ])),
                      )
                    ],
                  );
                } else {
                  widgetDisplay = const Center(
                    child: Text(
                      TextConstants.somethingWentWrong,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black45),
                    ),
                  );
                }
                break;
              default:
            }

            return widgetDisplay;
          }),
      bottomNavigationBar: Container(
        color: const Color(0xFF66347F),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: const Text(
                TextConstants.buyNowText,
                style: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              label: const Text(
                TextConstants.addToCartText,
                style: TextStyle(color: Colors.black),
              ),
              icon: SvgPicture.asset(AssetsConst.basketSvg),
            )
          ],
        ),
      ),
    );
  }
}
