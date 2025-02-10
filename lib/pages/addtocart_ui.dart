
import 'package:flutter/material.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';
import 'package:provider/provider.dart';

import '../models/cart_medels.dart';
import '../models/products_models.dart';
import '../provider/card_provider.dart';

class AddtocartUi extends StatefulWidget {
  final ProductItems products;
  const AddtocartUi(
      {super.key, required this.products});

  @override
  State<AddtocartUi> createState() => _AddtocartUiState();
}

class _AddtocartUiState extends State<AddtocartUi> {
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: AddToCartButton(
              trolley: Image.asset(
                'assets/image.png',
                width: 24,
                height: 24,
                color: Colors.white,
              ),
              text: Text(
                'Add to cart',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.fade,
              ),
              check: SizedBox(
                width: 48,
                height: 48,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              borderRadius: BorderRadius.circular(24),
              backgroundColor: Colors.deepOrangeAccent,
              onPressed: (id) {
                
                context.read<CartProvider>().addCart(CartItem(id:'', product:widget.products , quantity:1));
                if (id == AddToCartButtonStateId.idle) {
                  //handle logic when pressed on idle state button.
                  setState(() {
                    stateId = AddToCartButtonStateId.loading;
                    Future.delayed(Duration(seconds: 2), () {
                      setState(() {
                        stateId = AddToCartButtonStateId.done;
                      });
                    });
                  });
                } else if (id == AddToCartButtonStateId.done) {
                  //handle logic when pressed on done state button.
                  setState(() {
                    stateId = AddToCartButtonStateId.idle;
                  });
                }
              },
              stateId: stateId,
            ),
          ),
        ),
      ],
    );
  }
}
