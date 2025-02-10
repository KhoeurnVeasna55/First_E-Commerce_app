import 'package:cached_network_image/cached_network_image.dart';

import 'package:e_commerce_app/provider/card_provider.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartProvider cartProvider;

  @override
  // void initState() {
  //   super.initState();
  //   context.read<CartProvider>().fetchCart();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cartProvider = Provider.of<CartProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) {
        final carts = cartProvider.cart;

        return Scaffold(
          backgroundColor: const Color(0xFF0C102C),
          body: SafeArea(
              child: SingleChildScrollView(
                  child: Column(children: [
            // Header
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.26,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                              color: Colors.white,
                              size: 20,
                            ),
                            tooltip: 'Go back',
                          ),
                        ),
                        CircleAvatar(
                          maxRadius: 20,
                          backgroundColor: const Color(0xFFF46322),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/mainPage');
                            },
                            icon: const Icon(
                              Icons.home,
                              color: Colors.white,
                              size: 20,
                            ),
                            tooltip: 'View Cart',
                          ),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'My Cart',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Cart Items
            carts.items.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: const Center(
                      child: Text(
                        'Your cart is empty!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: carts.items.length,
                    itemBuilder: (context, index) {
                      final item = carts.items[index];

                      return Dismissible(
                        key: Key(item.id.toString()), // Unique key
                        direction: DismissDirection.endToStart,

                        movementDuration: Duration(seconds: 12),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),

                        onDismissed: (direction) async {
                          // Remove the item from the cart
                          await cartProvider.removeCartItem(
                            carts.id,
                            item.id,
                          ); // Call the provider method
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${item.product.name} removed from cart'),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {
                                  // Add the item back to the cart
                                  // Call the provider method
                                },
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 0, vertical:10),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    item.product.images[0],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              item.product.name ?? 'No Name',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start  ,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '\$${item.product.price}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      ' x ${item.quantity}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  'Total: \$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: SizedBox(
                                width: 103,
                                height: 30,
                                
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        cartProvider.updateQty(carts.id,
                                            item.id, item.quantity -= 1);
                                      },
                                    ),
                                    Text(
                                      '${item.quantity}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        cartProvider.updateQty(carts.id,
                                            item.id, item.quantity += 1);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ]))),
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(color: Color.fromARGB(255, 35, 44, 112),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),)
            ),
            child: Consumer<CartProvider>(builder: (ctx, cartProvider,widget){
              return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Your total price: \$${cartProvider.total.toStringAsFixed(2)}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.deepOrange)),
                          child: Text(
                            'Check out ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ))
                    ],
                  );
            } )
          ),
        );
      },
    );
  }
}
