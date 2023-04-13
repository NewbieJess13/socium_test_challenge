import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:socium_test_challenge/constants/enums.dart';
import 'package:socium_test_challenge/constants/text_consts.dart';
import 'package:socium_test_challenge/models/products.dart';
import 'package:socium_test_challenge/pages/product_page.dart';
import 'package:socium_test_challenge/services/product_api_service.dart';
// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:socium_test_challenge/widgets/product_tile.dart';
import 'package:socium_test_challenge/widgets/shimmer_product%20_tile.dart';

import '../models/product.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ProductServices _productServices = ProductServices();
  final ScrollController _scrollController = ScrollController();
  LoadMoreProductsStatus _loadMoreProductsStatus =
      LoadMoreProductsStatus.stable;
  CancelableOperation? productsOperation;
  late List<Product> productList;
  bool loading = true;
  int _skips = 0;

  @override
  void initState() {
    populateProducts();
    super.initState();
  }

  @override
  void dispose() {
    productsOperation?.cancel();
    super.dispose();
  }

  void populateProducts() async {
    Products? products = await _productServices.getProducts(skip: _skips);
    setState(() {
      loading = false;
    });
    productList = products!.products;
  }

  bool onNotifyProductReloader(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      if (_scrollController.position.maxScrollExtent >
              _scrollController.offset &&
          _scrollController.position.maxScrollExtent -
                  _scrollController.offset <=
              50) {
        if (_loadMoreProductsStatus == LoadMoreProductsStatus.stable) {
          _loadMoreProductsStatus = LoadMoreProductsStatus.loading;
          _skips += 10;
          productsOperation = CancelableOperation.fromFuture(_productServices
              .getProducts(skip: _skips)
              .then((Products? products) {
            _loadMoreProductsStatus = LoadMoreProductsStatus.stable;
            setState(() => productList.addAll(products!.products));
          }));
        }
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(TextConstants.productsText),
        ),
        body: loading
            ? MasonryGridView.count(
                itemCount: 10,
                physics: const AlwaysScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                padding:
                    const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                itemBuilder: (context, index) {
                  return const ShimmerProductTile();
                },
              )
            : productList.isEmpty
                ? const Center(
                    child: Text(
                      TextConstants.noItemsToDisplay,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Colors.black45),
                    ),
                  )
                : NotificationListener(
                    onNotification: onNotifyProductReloader,
                    child: MasonryGridView.count(
                      itemCount: productList.length,
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      itemBuilder: (context, index) {
                        final Product product = productList[index];
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductPage(id: product.id)));
                            },
                            child: ProductTile(product: product));
                      },
                    ),
                  ));
  }
}
