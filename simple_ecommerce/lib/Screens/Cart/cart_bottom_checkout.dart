import 'package:flutter/material.dart';
import 'package:simple_ecommerce/Widgets/title_text.dart';

class CartBottomCheckout extends StatelessWidget {
  final double totalAmount;

  const CartBottomCheckout({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[900] // Dark mode background color
              : Colors.white,    // Light mode background color
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Total amount display
            TitlesTextWidget(label: "Total: \$${totalAmount.toStringAsFixed(2)}"),
            // Checkout Button
            ElevatedButton(
              onPressed: () {
                // Handle checkout logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Proceeding to Checkout")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor, // Use theme primary color
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Checkout",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white // Text color for dark theme
                      : Colors.black, // Text color for light theme
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
