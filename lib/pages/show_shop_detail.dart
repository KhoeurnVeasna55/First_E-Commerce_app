import 'package:e_commerce_app/models/products_models.dart';
import 'package:flutter/material.dart';

class ShowshopDetail extends StatelessWidget {
  const ShowshopDetail({super.key, required this.products});
  final ProductItems products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0C102C), // Dark background
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconWithText(icon: Icons.memory, text: 'Brand: ${products.name}'),
              IconWithText(
                  icon: Icons.money, text: 'Price: \$${products.price}'),
              IconWithText(
                  icon: Icons.add_box, text: 'Stock: ${products.stock}'),
            ],
          ),
          Row(
            children: [
              
            ],
          )
        ],
      ),
      
    );
  }
}

class IconWithText extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconWithText({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}
