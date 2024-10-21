import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart'; // Import the fancy_shimmer_image package
import '../../Provider/product_provider.dart';
import '../../Widgets/app_name_text.dart';
import '../../Widgets/products/heart_button.dart';
import '../../Widgets/subtilte_text.dart';
import '../../widgets/title_text.dart';


class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider =
    Provider.of<ProductProvider>(context, listen: false);

    // Retrieve productId from route arguments
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProvider.findByProdId(productId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const AppNameTextWidget(fontSize: 20),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : null;
          },
          icon: const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
        ),
      ),
      body: getCurrProduct == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            // Product Image with Fancy Shimmer Effect
            Card(
              elevation: 8,
              shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(40)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(40)),
                child: FancyShimmerImage(
                  imageUrl: getCurrProduct.productImage, // Ensure this path is correct
                  height: size.height * 0.45,
                  width: double.infinity,
                  boxFit: BoxFit.cover,
                  shimmerDuration: const Duration(seconds: 2),
                  errorWidget: Image.asset('assets/images/placeholder.png'), // Optional: your placeholder image
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Product Details
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Title
                  Text(
                    getCurrProduct.productTitle,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Price
                  Text(
                    getCurrProduct.productPrice,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Action Buttons
                  Row(
                    children: [
                      const HeartButtonWidget(color: Colors.blue),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding:
                            const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {
                            // Handle Add to Cart action
                          },
                          icon: const Icon(Icons.add_shopping_cart,
                              size: 20,color: Colors.white),
                          label: const Text("Add to Cart",
                              style: TextStyle(fontSize: 16,color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // About this item
                  const TitlesTextWidget(label: "About this item"),
                  const SizedBox(height: 10),
                  // Description
                   SubtitleTextWidget(
                    label:
                    "• ${getCurrProduct.productDescription}",
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
