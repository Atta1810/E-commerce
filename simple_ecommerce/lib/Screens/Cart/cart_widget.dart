import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  int _quantity = 1; // Default quantity
  final double _itemPrice = 99.99; // Set a base item price

  double get totalPrice => _itemPrice * _quantity; // Calculate total price

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: isDarkMode
              ? const LinearGradient(
            colors: [Colors.grey, Colors.black87],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : const LinearGradient(
            colors: [Colors.white, Colors.grey],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDarkMode
                  ? Colors.black.withOpacity(0.8)
                  : Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FancyShimmerImage(
                height: size.height * 0.18,
                width: size.height * 0.18,
                imageUrl:
                "https://image.lexica.art/full_webp/4a643ebb-1c4c-4f9d-a111-de1a414e8e2a",
              ),
            ),
            const SizedBox(width: 12),
            // Content section
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Item Title",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "This is a brief description of the item in the cart.",
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity Selector
                      OutlinedButton(
                        onPressed: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          side: BorderSide(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        child: Text(
                          '-',
                          style: TextStyle(
                            fontSize: 20,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        '$_quantity', // Show current quantity
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          side: BorderSide(
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 20,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                      // Price Display
                      Text(
                        "\$${totalPrice.toStringAsFixed(2)}", // Show dynamic price
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: isDarkMode
                              ? Colors.greenAccent
                              : Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Add to Favorites Button
                      IconButton(
                        onPressed: () {
                          // Handle adding to favorites
                        },
                        icon: Icon(
                          Icons.favorite_outline,
                          color: isDarkMode ? Colors.redAccent : Colors.red,
                        ),
                      ),
                      // Remove from Cart Button
                      IconButton(
                        onPressed: () {
                          // Handle removing from cart
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey,
                        ),
                      ),
                    ],
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