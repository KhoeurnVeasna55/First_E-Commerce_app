import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/category_models.dart';
import 'package:e_commerce_app/pages/categories_type.dart';
import 'package:e_commerce_app/pages/containner_show.dart';

import 'package:e_commerce_app/provider/product_provider.dart';
import 'package:e_commerce_app/services/Local/service_token.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/products_models.dart';
import '../routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ProductItems> products = [];
  late ProductProvider productProvider;
  List<CategoryModels> categories =[

  ];
  void Function()? onTap;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    productProvider = Provider.of<ProductProvider>(context);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Color(0xFFF46322),
                      image: DecorationImage(
                        image: AssetImage('assets/7611770.png'),
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/searchPage');
                    },
                    child: Container(
                      width: 280,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 10),
                            Text(
                              'Search',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await ServiceToken.clearToken();
                      if(!context.mounted)return;
                      Navigator.pushNamed(
                        context, '/login');
                    },
                    icon: Icon(
                      Icons.logout,
                      size: 25,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hot Sales',
                    style: GoogleFonts.roboto(
                      fontSize: 23,
                      fontWeight: FontWeight.w600, // SemiBold (600)
                      fontStyle: FontStyle.italic, // Italic
                    ),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'see more',
                        style: TextStyle(color: Colors.grey),
                      )),
                      
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //Show Hot sales
              ContainnerShow(),
              headerCategory(),
              SizedBox(height: 5),
              CategoriesType(
                onTap: (categoryId) {
                  if(categoryId == null){
                    productProvider.fetchProducts();
                  }
                  else{
                    productProvider.fetchProductsByCategory(categoryId);
                  }
                  
                },
              ),
              productItems(),
            ]),
          ),
        ),
      ),
    );
  }

  Widget productItems() {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) => GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: productProvider.products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
            crossAxisSpacing: 10.0, // Space between columns
            mainAxisSpacing: 10.0, // Space between rows
          ),
          itemBuilder: (BuildContext ctx, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  Routes.detailPage,
                  arguments: productProvider.products[index],
                );
              },
              child: Card(
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Hero(
                        tag: productProvider.products[index].id,
                        child: Container(
                          height: 150,
                          width: 180,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  productProvider.products[index].images[0]),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Text(
                      productProvider.products[index].name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget headerCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Select Category',
          style: GoogleFonts.roboto(
            fontSize: 23,
            fontWeight: FontWeight.w600, // SemiBold (600)
            fontStyle: FontStyle.italic, // Italic
          ),
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'view all',
              style: TextStyle(color: Colors.grey),
            )),
      ],
    );
  }
}
