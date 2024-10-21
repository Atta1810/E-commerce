import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ecommerce/Provider/cart_provider.dart';
import 'package:simple_ecommerce/Screens/Cart/cart_bottom_checkout.dart';
import 'package:simple_ecommerce/Screens/Cart/cart_widget.dart';
import 'package:simple_ecommerce/Widgets/empty_bag.dart';
import 'package:simple_ecommerce/Widgets/title_text.dart';
import '../../Services/assets_manger.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
      body: Center(
        child: EmptyBagWidget(
          imagePath: AssetsManager.shoppingBasket,
          title: "Your Cart is Empty",
          subtitle: 'It looks like you haven’t added anything to your cart yet.\n'
              'Start exploring our products and add your favorites!',
          buttonText: "Shop Now",
        ),
      ),
    )
        : Scaffold(
      bottomSheet: CartBottomCheckout(
        totalAmount: _calculateTotalAmount(),

      ),
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(size.width * 0.02), 
          child: Image.asset(AssetsManager.shoppingCart),
        ),
        title: TitlesTextWidget(label: "Cart (${cartProvider.getCartItems.length})"), // Update item count dynamically
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
        itemCount: cartProvider.getCartItems.length,
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: cartProvider.getCartItems.values.toList()[index],
            child: CartWidget(),
          );
        },
      ),
    );
  }

  double _calculateTotalAmount() {
    // Replace with logic to calculate the total amount from the cart items
    double total = 0.0;
    for (int i = 0; i < 20; i++) {
      total += 99.99; // Assuming each item costs $99.99
    }
    return total;
  }
}
