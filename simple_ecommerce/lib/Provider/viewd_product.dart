import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/viewd_product.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProdModel> _viewedProdItems = {};

  Map<String, ViewedProdModel> get getviewedProdItems {
    return _viewedProdItems;
  }

  // bool isProductInviewedProd({required String productId}) {
  //   return _viewedProdItems.containsKey(productId);
  // }

  void addProductToHistory({required String productId}) {
    _viewedProdItems.putIfAbsent(
      productId,
          () => ViewedProdModel(
        id: const Uuid().v4(),
        productId: productId,
      ),
    );

    notifyListeners();
  }

// void clearLocalviewedProd() {
//   _viewedProdItems.clear();
//   notifyListeners();
// }
}
