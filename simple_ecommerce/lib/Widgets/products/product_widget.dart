import 'dart:developer';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ecommerce/Provider/cart_provider.dart';

import '../../Provider/product_provider.dart';
import '../../Screens/inner_screens/product_details.dart';
import '../../models/product_model.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({Key? key, required this.productId}) : super(key: key);

  final String productId;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct = productProvider.findByProdId(widget.productId);
    final cartProvider = Provider.of<CartProvider>(context);

    Size size = MediaQuery.of(context).size;

    // Return an empty SizedBox if the product is not found
    return getCurrProduct == null
        ? const SizedBox.shrink()
        : InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: getCurrProduct.productId);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: size.width * 0.02,
          vertical: size.height * 0.01,
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Colors.grey.shade200],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius:
                const BorderRadius.vertical(top: Radius.circular(15)),
                child: FancyShimmerImage(
                  imageUrl: getCurrProduct.productImage,
                  height: size.height * 0.15,
                  width: double.infinity,
                  boxFit: BoxFit.cover,
                ),
              ),
              // Product Details
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title
                    Text(
                      getCurrProduct.productTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Product Price with Favorite Icon
                    Row(
                      children: [
                        Text(
                          getCurrProduct.productPrice,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.teal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.favorite_border,
                          color: Colors.pinkAccent,
                          size: 28,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    // Product Description
                     Text(
                      getCurrProduct.productDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              // Add to Cart Button
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle add to cart
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(size.width * 0.4, 40),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add to Cart',
                        style:
                        TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orangeAccent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            // Handle cart icon tap if needed
                            if (cartProvider.isProductInCart(
                                productId: getCurrProduct.productId)) {
                              return;
                            }

                            cartProvider.addProductToCart(
                                productId: getCurrProduct.productId);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              cartProvider.isProductInCart(
                                  productId: getCurrProduct.productId)
                                  ? Icons.check
                                  : Icons.shopping_cart_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
