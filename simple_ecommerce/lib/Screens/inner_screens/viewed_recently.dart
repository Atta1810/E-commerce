import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import '../../Services/assets_manger.dart';
import '../../Widgets/empty_bag.dart';
import '../../Widgets/products/prouct_widget.dart';
import '../../Widgets/title_text.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen'; // Route name

  const ViewedRecentlyScreen({super.key});

  @override
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  List<int> viewedProducts = List.generate(5, (index) => index); // Example product list
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    isEmpty = viewedProducts.isEmpty;

    return isEmpty
        ? Scaffold(
      body: EmptyBagWidget(
        imagePath: AssetsManager.shoppingBasket,
        title: "Your viewed recently is empty",
        subtitle:
        'Looks like you didn\'t add anything yet to your cart. \nGo ahead and start shopping now!',
        buttonText: "Shop Now",
      ),
    )
        : Scaffold(
      appBar: AppBar(
        title: TitlesTextWidget(label: "Viewed recently (${viewedProducts.length})"),
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
                viewedProducts.clear(); // Clears the product list
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
        itemCount: viewedProducts.length,
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
                      viewedProducts.removeAt(index); // Remove individual product
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
