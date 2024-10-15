import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ecommerce/Screens/inner_screens/wish_list.dart';
import 'package:simple_ecommerce/Widgets/app_name_text.dart';
import '../Provider/theme_provider.dart';
import '../Services/assets_manger.dart';
import '../Services/my_app_method.dart';
import '../Widgets/custom_list_tile.dart';
import '../Widgets/subtilte_text.dart';
import '../Widgets/title_text.dart';
import 'auth/login_screen.dart';
import 'inner_screens/orders/order_screen.dart';
import 'inner_screens/viewed_recently.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const AppNameTextWidget(fontSize: 30,),
        leading: Image.asset(AssetsManager.shoppingCart),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            // Profile Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      // Profile Picture
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).cardColor,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                              color: Theme.of(context).colorScheme.surface,
                              width: 3),
                          image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/myimg.jpg",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Name and Email
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitlesTextWidget(label: "Abdulrahman Akram"),
                            SubtitleTextWidget(
                                label: "abdoakramsami2020@gmail.com"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            // General Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitlesTextWidget(label: "General"),
                  const SizedBox(height: 12),
                  CustomListTile(
                    imagePath: AssetsManager.orderSvg,
                    text: "All orders",
                    function: () async{
                      await Navigator.pushNamed(
                        context,
                        OrdersScreenFree.routeName,
                      );
                    },
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.wishlistSvg,
                    text: "Wishlist",
                    function: () {

                      Navigator.pushNamed(context, WishlistScreen.routeName);

                    },
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.recent,
                    text: "Viewed recently",
                    function: () {

                      Navigator.pushNamed(context, ViewedRecentlyScreen.routeName);

                    },
                  ),
                  CustomListTile(
                    imagePath: AssetsManager.address,
                    text: "Address",
                    function: () {},
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, height: 40),
            // Settings Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitlesTextWidget(label: "Settings"),
                  const SizedBox(height: 12),
                  SwitchListTile(
                    secondary: Image.asset(
                      AssetsManager.theme,
                      height: 30,
                    ),
                    title: Text(themeProvider.getIsDarkTheme
                        ? "Dark mode"
                        : "Light mode"),
                    value: themeProvider.getIsDarkTheme,
                    onChanged: (value) {
                      themeProvider.setDarkTheme(themeValue: value);
                    },
                  ),
                ],
              ),
            ),
            const Divider(thickness: 1, height: 40),
            // Login Button
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  shape: const StadiumBorder(), // Changed to a pill-shaped button
                  elevation: 8,
                  backgroundColor:
                      Colors.teal, // Changed to teal for a fresh look
                  shadowColor: Colors.tealAccent.withOpacity(0.4),
                ),
                onPressed: () async {

                  await Navigator.pushNamed(
                    context,
                    LoginScreen.routeName,
                  );

                  //MyAppMethods.showErrorORWarningDialog(
                   //   context: context,
                   //   subtitle: "Are you sure?",
                   //   fct: () {},
                   //   isError: false);
                },
                icon: const Icon(Icons.lock_open_rounded,
                    color: Colors.white, size: 26), // New lock icon
                label: const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
