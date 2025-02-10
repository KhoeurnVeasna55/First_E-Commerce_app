import 'package:flutter/material.dart';

class ContainnerShow extends StatelessWidget {
  const ContainnerShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Container
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height *
              0.25, // Height of the container
          decoration: BoxDecoration(
            color: Color(0xFF0C102C), // Background color of the container
            borderRadius: BorderRadius.circular(10), // Rounded corners
          ),
        ),

        // Image Positioned Higher than the Container
        Positioned(
          top: -50, // Negative value to make the image overflow the top
          right: 3, // Align the image to the right
          bottom: -30,
          child: Image.asset(
            'assets/pngwing.com.png', // Path to your image
            width:  MediaQuery.of(context).size.width*0.42, // Width of the image
            height: MediaQuery.of(context).size.height*0.42, // Height of the image
            fit: BoxFit.contain, // Scale the image to fit
          ),
        ),

        // Text and Button
        Positioned(
          bottom: 125, // Position from the bottom of the container
          left: 20, // Position from the left of the container
          child: Text(
            'iPhone 14',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 90, // Position from the bottom of the container
          left: 20, // Position from the left of the container
          child: Text(
            'Best For You',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 20, // Position from the bottom of the container
          left: 10, // Position from the left of the container
          child: TextButton(
            onPressed: () {},
            child: Container(
              width: 120,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'Buy Now!',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
