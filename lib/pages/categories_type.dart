

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/category_provider.dart';

class CategoriesType extends StatefulWidget {
  final void Function(String?)? onTap;

  const CategoriesType({super.key, this.onTap});

  @override
  State<CategoriesType> createState() => _CategoriesTypeState();
}

class _CategoriesTypeState extends State<CategoriesType> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        final categories = categoryProvider.categories;
        return SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (ctx, index) {
              final category = categories[index];
              final bool isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                   setState(() {
                      selectedIndex = index;
                    });
                  if (category.id == 'all') {
                    widget.onTap?.call(null);
                  } else {
                    widget.onTap?.call(category.id);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: SizedBox(
                    width: 90,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 80,
                            width: 60,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFF46322)
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              IconData(
                                int.parse(category.icon),
                                fontFamily: 'MaterialIcons',
                              ),
                              color: isSelected ? Colors.white : Colors.black,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            category.name,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
