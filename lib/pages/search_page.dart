import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  final VoidCallback? onCancel ;
  const SearchPage({super.key , this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          hintText: 'Search...',
                          hintStyle: TextStyle(color: Colors.grey.shade600),
                          border: InputBorder.none,
                          // prefixIcon: Icon(Icons.search, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (onCancel != null) {
                        onCancel!();
                      }
                      Navigator.pushNamed(context, '/mainPage');
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
