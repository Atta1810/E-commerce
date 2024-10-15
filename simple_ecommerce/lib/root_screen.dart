import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:simple_ecommerce/Screens/Cart/cart_screen.dart';
import 'package:simple_ecommerce/Screens/home_screen.dart';
import 'package:simple_ecommerce/Screens/profile_screen.dart';
import 'package:simple_ecommerce/Screens/search_screen.dart';

class RootScreen extends StatefulWidget {
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
    const ProfileScreen(),
  ];

  @override
  void initState() {
    controller = PageController(initialPage: currentScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        destinations: const [
          NavigationDestination(
              selectedIcon: Icon(IconlyBold.home),
              icon: Icon(IconlyLight.home),
              label: "Home"),
          NavigationDestination(
              selectedIcon: Icon(IconlyBold.search),
              icon: Icon(IconlyLight.search),
              label: "Search"),
          NavigationDestination(
              selectedIcon: Icon(IconlyBold.bag),
              icon: Badge(label: Text("6"), child: Icon(IconlyLight.bag)),
              label: "Cart"),
          NavigationDestination(
              selectedIcon: Icon(IconlyBold.profile),
              icon: Icon(IconlyLight.profile),
              label: "Profile"),
        ],
      ),
    );
  }
}
