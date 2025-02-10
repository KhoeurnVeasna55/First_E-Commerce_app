import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/products_models.dart';
import 'package:e_commerce_app/pages/addtocart_ui.dart';
import 'package:e_commerce_app/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating/flutter_rating.dart';
import 'package:provider/provider.dart';
import 'show_shop_detail.dart';

class DetailProducts extends StatefulWidget {
  const DetailProducts({super.key, required this.products});
  final ProductItems products;

  @override
  State<DetailProducts> createState() => _DetailProductsState();
}

class _DetailProductsState extends State<DetailProducts>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this); // Fixed 'vsync' issue
    
  }
@override
  void didChangeDependencies() {
    super.didChangeDependencies();
     Provider.of<WishlistProvider>(context);
  }
  @override
  void dispose() {
    _tabController
        .dispose(); // Dispose of TabController to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF0C102C);
    const appBarIconColor = Colors.white;
    const buttonColor = Color(0xFFF46322);
    const borderRadius = 25.0;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(7),
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: 60,
                padding: EdgeInsets.only(bottom: 5),
                child: nameAndFavorite(),
              )),
          expandedHeight: 470,
          automaticallyImplyLeading: false,
          pinned: true,
          backgroundColor: const Color(0xFF00142B),
          flexibleSpace: FlexibleSpaceBar(
            background: Column(children: [
              Container(
                color: appBarIconColor,
                child: SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: const Color(0xFF1B2944),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: appBarIconColor,
                            size: 20,
                          ),
                          tooltip: 'Go back',
                        ),
                      ),
                      const Text(
                        'Product Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      CircleAvatar(
                        maxRadius: 20,
                        backgroundColor: buttonColor,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/cartPage');
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: appBarIconColor,
                            size: 20,
                          ),
                          tooltip: 'View Cart',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Hero(
                tag: widget.products.id,
                transitionOnUserGestures: true,
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      bottomRight: Radius.circular(borderRadius),
                    ),
                    image: widget.products.images.isNotEmpty
                        ? DecorationImage(
                            image: CachedNetworkImageProvider(
                                widget.products.images[0]),
                            fit: BoxFit.fitHeight,
                          )
                        : null,
                  ),
                ),
              ),
            ]),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 15),
              ratingStar(),
              const SizedBox(height: 10),
              tabBarAndContent(),
            ],
          ),
        ),
      ]),
      bottomSheet: Container(
          height: 100,
          width: double.infinity,
          color: Color(0xFF0C102C),
          child: SizedBox(
              width: 300,
              height: 150,
              child: AddtocartUi(products: widget.products))),
    );
  }

  Widget nameAndFavorite() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 45,
            width: 140,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 47, 53, 99),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                widget.products.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Consumer<WishlistProvider>(
              builder: (context, wishlistProvider, child) {
             final bool checkFavorite = wishlistProvider.isInWishlist(widget.products.id);
              
            return CircleAvatar(
              backgroundColor: Colors.grey.shade700,
              child: IconButton(
                onPressed: ()async {
                 
                 await wishlistProvider.toggleWishlist(widget.products);
                },
                icon: const Icon(Icons.favorite),
                color: checkFavorite ? Colors.red: Colors.white,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget ratingStar() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: Row(
        children: [
          StarRating(
            rating: widget.products.ratings.toDouble() ?? 0.0,
            filledIcon: Icons.star,
            halfFilledIcon: Icons.star,
            emptyIcon: Icons.star,
            size: 20,
            color: Colors.orange,
            borderColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget tabBarAndContent() {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          dividerHeight: 0,
          tabs: const [
            Tab(text: 'Shop'),
            Tab(text: 'Description'),
          ],
          indicator: UnderlineTabIndicator(),
          indicatorColor: Colors.white,
        ),
        // Use SizedBox instead of Expanded
        SizedBox(
          height: 600, // You can adjust the height based on your needs
          child: TabBarView(
            controller: _tabController,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: ShowshopDetail(
                  products: widget.products,
                ), // shopShow handles its own spacing
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(
                  widget.products.description,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
