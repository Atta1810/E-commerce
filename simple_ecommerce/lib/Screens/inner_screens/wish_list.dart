import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import '../../Services/assets_manger.dart';
import '../../Widgets/empty_bag.dart';
import '../../Widgets/products/prouct_widget.dart';
import '../../Widgets/title_text.dart';

class WishlistScreen extends StatefulWidget {
  static const routeName = '/WishlistScreen';
  const WishlistScreen({super.key});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<int> wishlistProducts = List.generate(5, (index) => index); // Example product list
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    isEmpty = wishlistProducts.isEmpty;

    return isEmpty
        ? Scaffold(
      appBar: AppBar(

        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Back button functionality
          },
        ),

      ),
      body: EmptyBagWidget(
        imagePath: AssetsManager.bagWish,
        title: "Your wishlist is empty",
        subtitle:
        'Looks like you didn\'t add anything yet to your wishlist.\nGo ahead and start shopping now!',
        buttonText: "Shop Now",
      ),
    )
        : Scaffold(
      appBar: AppBar(
        title: TitlesTextWidget(label: "Wishlist (${wishlistProducts.length})"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Back button functionality
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                wishlistProducts.clear(); // Clears the wishlist
              });
            },
            icon: const Icon(
              Icons.delete_forever_rounded,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: DynamicHeightGridView(
        itemCount: wishlistProducts.length,
        builder: (context, index) {
          return Stack(
            children: [
              const ProductWidget(), // Display the product
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      wishlistProducts.removeAt(index); // Remove individual product
                    });
                  },
                ),
              ),
            ],
          );
        },
        crossAxisCount: 2,
      ),
    );
  }
}
