import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';


import 'package:e_commerce_app/provider/wishlist_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorites',style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: [
          IconButton(onPressed:(){} ,icon: Icon(Icons.shopping_bag), )
        ],
      ),
      body: Consumer<WishlistProvider>(builder: (context, wishlistProvider, child) {
        final favorites = wishlistProvider.wishlistModels;
        
        return favorites.products.isEmpty ? Center(
            child: Text('No Favorite found!'),
        ) :
        
        ListView.builder(
          itemCount:favorites.products.length,
          
          itemBuilder: (BuildContext ctx,int index){
           final item = favorites.products[index];
          return Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(item.images[0]),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                    SizedBox(height: 10,),
                    Text('\$${item.price.toString()}',style: TextStyle(color: Colors.grey,fontSize: 14),),
                  ],
                ),
                Spacer(),
                IconButton(onPressed: (){
                  wishlistProvider.toggleWishlist(item);
                }, icon: Icon(Icons.favorite_sharp,color: Colors.red,))
              ],
            ),
          );
        });
      }
      ),
    );
  }
}