import 'package:e_commerce_app/models/products_models.dart';
import 'package:e_commerce_app/pages/cart_page.dart';
import 'package:e_commerce_app/pages/profilepage.dart';
import 'package:flutter/material.dart';

import '../pages/auth/auth_state.dart';
import '../pages/homepage.dart';
import '../pages/main_page.dart';
import '../pages/search_page.dart';
import '../pages/detail_products.dart';
import '../pages/login.dart';
import '../pages/register_page.dart';

class Routes {
  static const loginPage = '/login';
  static const registerPage = '/register';
  static const homePage = '/homePage';
  static const isLogin = '/isLogin';
  static const searchPage = '/searchPage';
  static const mainPage = '/mainPage';
  static const detailPage = '/detailProducts';
  static const cartPage = '/cartPage';
  static const profilepage = '/profilePage';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case registerPage:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case isLogin:
        return MaterialPageRoute(builder: (_) => IsLoogin());
      case searchPage:
        return MaterialPageRoute(builder: (_) => SearchPage());
      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());
      case cartPage:
        return MaterialPageRoute(builder: (_) => CartPage());
      case detailPage:
        if (settings.arguments is ProductItems) {
          final product = settings.arguments as ProductItems;
          return MaterialPageRoute(
            builder: (_) => DetailProducts(products: product), // Fixed here
          );
        }

        return _errorRoute();
      case profilepage:
        return MaterialPageRoute(builder: (_) => Profilepage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text('No route defined for this path'),
        ),
      ),
    );
  }
}
