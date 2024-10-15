import 'package:flutter/material.dart';
import '../../Widgets/app_name_text.dart';
import '../../Widgets/products/heart_button.dart';
import '../../Widgets/subtilte_text.dart';
import '../../widgets/title_text.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image with Card Design
            Card(
              elevation: 8,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
                child: Image.asset(
                  "assets/images/iphone.png", // Ensure this path is correct
                  height: size.height * 0.45,
                  width: double.infinity,
                  fit: BoxFit.cover,
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
                  const Text(
                    "Premium Quality Smartphone",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Price
                  const Text(
                    "\$166.50",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Action Buttons
                  Row(
                    children: [
                      HeartButtonWidget(color: Colors.blue.shade300),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.add_shopping_cart, size: 20),
                          label: const Text("Add to Cart", style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // About this item
                  const TitlesTextWidget(label: "About this item"),
                  const SizedBox(height: 10),
                  // Description
                  const SubtitleTextWidget(
                    label: "• High-resolution camera\n• Long-lasting battery\n• 5G connectivity\n• Latest OS with new features",
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
