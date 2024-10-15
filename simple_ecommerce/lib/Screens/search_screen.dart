import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package

import '../Services/assets_manger.dart';
import '../Widgets/products/prouct_widget.dart';

class SearchScreen extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: Colors.blue, // Choose a base color
            highlightColor: Colors.white, // Choose a highlight color
            child: const Text(
              "Search",
              style: TextStyle(
                fontSize: 24, // Increased font size
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.shoppingCart),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: searchTextController,
                decoration: InputDecoration(
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
                onChanged: (value) {},
                onSubmitted: (value) {
                  log(searchTextController.text);
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: DynamicHeightGridView(
                  crossAxisCount: 2,
                  itemCount: 20,
                  builder: (context, index) {
                    return const ProductWidget(); // Marking as const
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
