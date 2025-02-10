
import 'package:e_commerce_app/pages/cart_page.dart';
import 'package:e_commerce_app/pages/homepage.dart';
import 'package:badges/badges.dart' as badges;
import 'package:e_commerce_app/pages/profilepage.dart';
import 'package:e_commerce_app/pages/wishlist_page.dart';
import 'package:e_commerce_app/provider/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
 
  late final List<Widget> _pages;
  
  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      
      WishlistPage(),
      CartPage(),
      Profilepage(),
    ];
    Provider.of<CartProvider>(context,listen: false);
  }

  void onCancel() {
    setState(() {
      currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _pages.elementAt(currentIndex),
          ),
        ],
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context,cartProvider,child){
          return 
         SizedBox(
          child: DotNavigationBar(
            currentIndex: currentIndex,
            dotIndicatorColor: Colors.white,
            enablePaddingAnimation: false,
            
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            unselectedItemColor: Colors.grey[300],
            splashBorderRadius: 50,
            backgroundColor: Color(0xFF1B2944),
            enableFloatingNavBar: false,
            items: [
              DotNavigationBarItem(
                  icon: Icon(Icons.home), selectedColor: Color(0xFFF46322)),
              DotNavigationBarItem(
                  icon: Icon(Icons.favorite), selectedColor: Color(0xFFF46322)),
              DotNavigationBarItem(
                  icon: badges.Badge (badgeContent: Text('${cartProvider.cart.items.length}'),position: badges.BadgePosition.topEnd(),child: Icon(Icons.shopping_cart)
                  ,
                  ),
                  selectedColor: Color(0xFFF46322)),
              DotNavigationBarItem(
                  icon: Icon(Icons.person), selectedColor: Color(0xFFF46322)),
            ],
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        );
        }
      ),
    );
  }
}
