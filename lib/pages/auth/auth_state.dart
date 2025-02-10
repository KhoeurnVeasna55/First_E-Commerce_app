import 'package:e_commerce_app/pages/login.dart';
import 'package:e_commerce_app/pages/main_page.dart';
import 'package:e_commerce_app/services/Local/service_token.dart';
import 'package:flutter/material.dart';

class IsLoogin extends StatefulWidget {
  const IsLoogin({
    super.key,
  });

  @override
  State<IsLoogin> createState() => _IsLooginState();
}

class _IsLooginState extends State<IsLoogin> {
  bool? isLoogin;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    try {
      final result = await ServiceToken.getToken();
      setState(() {
        isLoogin = result != null;
      });
    } catch (e) {
      setState(() {
        isLoogin = false; // Fallback to not logged in on error
      });
      debugPrint('Error checking login status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoogin == null) {
      // While checking login status, show a loading indicator
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              const Text('Checking login status...'),
            ],
          ),
        ),
      );
    }

    // Show appropriate page based on login status
    return isLoogin! ? MainPage() : const LoginPage();
  }
}
