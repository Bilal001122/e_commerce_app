import 'package:e_commerce_app/constants.dart';
import 'package:e_commerce_app/services/database.dart';
import 'package:e_commerce_app/widgets/custom_action_bar.dart';
import 'package:flutter/material.dart';
import '../models/product.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String? productId;

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
                          product.name!,
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
                          product.description!,
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
                      _ProductSize(sizes: product.sizes!),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 30,
                          bottom: 20,
                          left: 24,
                          right: 24,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFDCDCDC),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              width: 60,
                              height: 60,
                              child: Center(
                                child: Icon(
                                  Icons.bookmark_outline,
                                  size: 30,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  height: 60,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(left: 16),
                                  child: Text(
                                    'Add To Cart',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                onTap: () async {
                                  await DatabaseService()
                                      .addToCart(widget.productId!);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Product added to the card',
                                      ),
                                    ),
                                  );
                                  print('done');
                                },
                              ),
                            )
                          ],
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
              for (int i = 0; i < widget.product.images!.length; i++)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: i == 0
                      ? Hero(
                          tag: widget.product.images![0],
                          child: Image.network(
                            widget.product.images![0],
                            height: 250,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Image.network(
                          widget.product.images![i],
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
                for (int i = 0; i < widget.product.images!.length; i++)
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

class _ProductSize extends StatefulWidget {
  final List<dynamic> sizes;

  const _ProductSize({Key? key, required this.sizes}) : super(key: key);

  @override
  State<_ProductSize> createState() => _ProductSizeState();
}

class _ProductSizeState extends State<_ProductSize> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Row(
        children: [
          for (int i = 0; i < widget.sizes.length; i++)
            Container(
              margin: EdgeInsets.only(left: 4, right: 4, bottom: 10),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: selectedSize == i
                    ? Color(0xFFFF1E00).withOpacity(0.9)
                    : Color(0xFFDCDCDC),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  splashColor: Colors.black12,
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    setState(() {
                      selectedSize = i;
                    });
                  },
                  child: Center(
                    child: Text(
                      widget.sizes[i],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
