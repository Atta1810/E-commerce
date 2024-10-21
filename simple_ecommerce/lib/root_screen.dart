import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:simple_ecommerce/Provider/cart_provider.dart';
import 'package:simple_ecommerce/Screens/Cart/cart_screen.dart';
import 'package:simple_ecommerce/Screens/home_screen.dart';
import 'package:simple_ecommerce/Screens/profile_screen.dart';
import 'package:simple_ecommerce/Screens/search_screen.dart';

class RootScreen extends StatefulWidget {
  static const routName = '/RootScreen';
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late PageController controller;
  int currentScreen = 0;
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const CartScreen(),
     ProfileScreen(),
  ];

  @override
  void initState() {
    controller = PageController(initialPage: currentScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider=Provider.of<CartProvider>(context);
    return Scaffold(
      body: PageView(
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 3,
        selectedIndex: currentScreen,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations:  [
          const NavigationDestination(
              selectedIcon:  Icon(IconlyBold.home),
              icon: Icon(IconlyLight.home),
              label: "Home"),
          const NavigationDestination(
              selectedIcon: Icon(IconlyBold.search),
              icon: Icon(IconlyLight.search),
              label: "Search"),
          NavigationDestination(
              selectedIcon: const Icon(IconlyBold.bag),
              icon: Badge(label: Text( cartProvider.getCartItems.length.toString()), child: const Icon(IconlyLight.bag)),
              label: cartProvider.getCartItems.length.toString()),
          const NavigationDestination(
              selectedIcon: Icon(IconlyBold.profile),
              icon: Icon(IconlyLight.profile),
              label: "Profile"),
        ],
      ),
    );
  }
}


