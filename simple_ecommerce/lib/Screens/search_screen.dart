import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../Provider/product_provider.dart';
import '../Services/assets_manger.dart';
import '../Widgets/products/product_widget.dart';
import '../Widgets/title_text.dart';
import '../models/product_model.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/SearchScreen';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchTextController;

  @override
  void initState() {
    searchTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  List<ProductModel> productListSearch = [];


  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    // Retrieve the category passed from the category widget
    String? passedCategory = ModalRoute.of(context)!.settings.arguments as String?;

    // If a category is passed, filter products by that category, otherwise show all products
    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(ctgName: passedCategory);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: Colors.blue,
            highlightColor: Colors.white,
            child: const Text(
              "Search",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back button icon
            onPressed: () {
              Navigator.pop(context); // Navigate back
            },
          ),
        ),
        body: productList.isEmpty
            ? const Center(
          child: TitlesTextWidget(label: "No product found"),
        )
            : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(

                controller: searchTextController,
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      searchTextController.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    productListSearch = productProvider.searchQuery(
                        searchText: searchTextController.text);
                  });
                },
                onSubmitted: (value) {
                  setState(() {
                    productListSearch = productProvider.searchQuery(
                        searchText: searchTextController.text);
                  });
                },
              ),
              const SizedBox(height: 10),
              if (searchTextController.text.isNotEmpty &&
                  productListSearch.isEmpty) ...[
                const Center(
                    child: TitlesTextWidget(
                      label: "No results found",
                      fontSize: 40,
                    ))
              ],
              Expanded(
                child: DynamicHeightGridView(
                  itemCount: searchTextController.text.isNotEmpty
                      ? productListSearch.length
                      : productList.length,
                  builder: ((context, index) {
                    return ProductWidget(
                      productId: searchTextController.text.isNotEmpty
                          ? productListSearch[index].productId
                          : productList[index].productId,
                    );
                  }),
                  crossAxisCount: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
