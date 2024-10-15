import 'dart:developer';

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_ecommerce/constants/app_constants.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: () {
        log("InkWell tapped successfully!");
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: size.width * 0.02, vertical: size.height * 0.01),
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
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: FancyShimmerImage(
                  imageUrl: AppConstants.productImageUrl,
                  height: size.height * 0.15,
                  width: double.infinity, // Full width image
                  boxFit: BoxFit.cover,
                ),
              ),
              // Product Details
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Title
                    Text(
                      "Product Name", // Replace with dynamic name
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 5),
                    // Product Price with Favorite Icon
                    Row(
                      children: [
                        Text(
                          "\$29.99", // Replace with dynamic price
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.teal, // Updated price color
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.favorite_border,
                          color: Colors.pinkAccent, // Updated favorite icon color
                          size: 28,
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    // Product Description
                    Text(
                      "This is a short description of the product.", // Replace with dynamic description
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              // Add to Cart Button
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle add to cart
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange, // Updated button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(size.width * 0.4, 40),
                    padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Add to Cart',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.orangeAccent, // Icon background color
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            // Handle cart icon tap if needed
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.shopping_cart_rounded,
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
