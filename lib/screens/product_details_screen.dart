import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/services/database.dart';
import 'package:e_commerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productId;

  const ProductDetailsScreen({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            StreamBuilder<List<Product>>(
              stream: DatabaseService().products,
              builder: (context, snapshot) {
                print(snapshot.connectionState);
                final products = snapshot.data;
                late final Product product;
                products?.forEach((element) {
                  if (element.id == widget.productId) {
                    product = element;
                  }
                });
                if (snapshot.connectionState == ConnectionState.active) {
                  return ListView(
                    children: [
                      _ImageSwipe(product: product),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 4),
                        child: Text(
                          product.name,
                          style: Constants.boldHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 24,
                        ),
                        child: Text(
                          '\$${product.price.toString()}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFF1E00),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 24,
                        ),
                        child: Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 24,
                        ),
                        child: Text(
                          'Select Size',
                          style: Constants.regularDarkText,
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFFF1E00),
                  ),
                );
              },
            ),
            CustomActionBar(
              hasBackArrow: true,
              hasTitle: false,
            ),
          ],
        ),
      ),
    );
  }
}

class _ImageSwipe extends StatefulWidget {
  final Product product;

  const _ImageSwipe({Key? key, required this.product}) : super(key: key);

  @override
  State<_ImageSwipe> createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<_ImageSwipe> {
  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 300,
      child: Stack(
        children: [
          PageView(
            scrollDirection: Axis.horizontal,
            onPageChanged: (value) {
              setState(() {
                selectedPage = value;
              });
            },
            children: [
              for (int i = 0; i < widget.product.images.length; i++)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: i == 0
                      ? Hero(
                          tag: 'firstHero',
                          child: Image.network(
                            widget.product.images[i],
                            height: 250,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Image.network(
                          widget.product.images[i],
                          height: 250,
                          fit: BoxFit.fitHeight,
                        ),
                ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.product.images.length; i++)
                  AnimatedContainer(
                    duration: Duration(
                      milliseconds: 300,
                    ),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    width: selectedPage == i ? 25 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xFFFF1E00).withOpacity(0.9),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
