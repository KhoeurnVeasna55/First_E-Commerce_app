import 'package:flutter/material.dart';
import 'package:flutter_add_to_cart_button/flutter_add_to_cart_button.dart';

void main() => runApp(TestApp());

class TestApp extends StatefulWidget {
  const TestApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  AddToCartButtonStateId stateId = AddToCartButtonStateId.idle;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Add To Cart'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: AddToCartButton(
                    trolley: Image.asset(
                      'assets/ic_cart.png',
                      width: 24,
                      height: 24,
                      color: Colors.white,
                    ),
                    text: Text(
                      'Add to cart',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                      ),
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
                      if (id == AddToCartButtonStateId.idle) {
                        //handle logic when pressed on idle state button.
                        setState(() {
                          stateId = AddToCartButtonStateId.loading;
                          Future.delayed(Duration(seconds: 3), () {
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
          ),
        ),
      ),
    );
  }
}