import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ecommerce/Provider/theme_provider.dart';
import 'package:simple_ecommerce/Screens/auth/register_screen.dart';
import 'package:simple_ecommerce/Screens/inner_screens/product_details.dart';
import 'package:simple_ecommerce/constants/theme_data.dart';

import 'Screens/auth/forget_password.dart';
import 'Screens/auth/login_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/inner_screens/orders/order_screen.dart';
import 'Screens/inner_screens/viewed_recently.dart';
import 'Screens/inner_screens/wish_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          routes: {
            ProductDetails.routeName: (context) => const ProductDetails(),
            WishlistScreen.routeName: (context) => const WishlistScreen(),
            HomeScreen.routeName: (context) => const HomeScreen(),
            ViewedRecentlyScreen.routeName: (context) =>
                const ViewedRecentlyScreen(), // Register the route
            LoginScreen.routeName: (context) => const LoginScreen(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            OrdersScreenFree.routeName: (context) => const OrdersScreenFree(),
            ForgotPasswordScreen.routeName: (context) =>
                const ForgotPasswordScreen(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Depi E-commerce',
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const RegisterScreen(),
        );
      }),
    );
  }
}