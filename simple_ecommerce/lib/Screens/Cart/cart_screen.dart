import 'package:flutter/material.dart';
import 'package:simple_ecommerce/Screens/Cart/cart_bottom_checkout.dart';
import 'package:simple_ecommerce/Screens/Cart/cart_widget.dart';
import 'package:simple_ecommerce/Widgets/empty_bag.dart';
import 'package:simple_ecommerce/Widgets/title_text.dart';
import '../../Services/assets_manger.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final bool isEmpty = false; // Change this to true to simulate an empty cart

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return isEmpty
        ? Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue[100]!,
              Colors.white,
            ], // Background gradient
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: EmptyBagWidget(
            imagePath: AssetsManager.shoppingBasket,
            title: "Your Cart is Empty",
            subtitle:
            'It looks like you haven’t added anything to your cart yet.\n'
                'Start exploring our products and add your favorites!',
            buttonText: "Shop Now",
          ),
        ),
      ),
    )
        : Scaffold(
      bottomSheet: CartBottomCheckout(totalAmount: _calculateTotalAmount()), // Pass total amount
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        title: const TitlesTextWidget(label: "Cart (5)"),
        actions: [
          IconButton(
            onPressed: () {
              // Handle clearing the cart
            },
            icon: const Icon(Icons.delete_forever_rounded),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: 15, // Replace with the actual number of items in the cart
        itemBuilder: (context, index) {
          return const CartWidget(); // Display individual cart items
        },
      ),
    );
  }

  double _calculateTotalAmount() {
    // Replace with logic to calculate the total amount from the cart items
    double total = 0.0;
    for (int i = 0; i < 20; i++) { // Assuming 15 items for the example
      total += 99.99; // Assuming each item costs $99.99
    }
    return total;
  }
}
