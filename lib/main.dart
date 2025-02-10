import 'package:e_commerce_app/provider/category_provider.dart';
import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:e_commerce_app/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';


import 'provider/card_provider.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter is initialized
  await GetStorage.init(); // Initializes GetStorage
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => CategoryProvider()),
      ChangeNotifierProvider(create: (_)=> ProductProvider()),
      ChangeNotifierProvider(create: (_)=> CartProvider()),
      ChangeNotifierProvider(create: (_) => WishlistProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider())
    ],
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRoute, // Route generator
      initialRoute: Routes.mainPage, // Starting route
    );
  }
}
