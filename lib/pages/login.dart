

import 'package:flutter/material.dart';

import '../services/apis/auth_api.dart';
import '../widgets/custom_textfiled_showPassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final txtEmail = TextEditingController();
  final txtPassWord = TextEditingController();
  final fromkey = GlobalKey<FormState>();
  final FocusNode _nodeEmail = FocusNode();
  final FocusNode _nodePassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
            child: Form(
              key: fromkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Login to your account',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text('Register'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Customtextfiled(
                    focusNode: _nodeEmail,
                    controller: txtEmail,
                    obscureText: false,
                    hintText: 'Email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  Customtextfiled(
                    focusNode: _nodePassword,
                    controller: txtPassWord,
                    obscureText: true,
                    hintText: 'Password',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input Password';
                      }
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        // Handle forgot password
                      },
                      child: Text('Forgot Password?'),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (fromkey.currentState!.validate()) {
                        await AuthApi.login(
                            context, txtEmail.text, txtPassWord.text);

                        if (!context.mounted) return;
                        Navigator.pushNamed(context, '/mainPage');
                      }
                      if (txtEmail.text.isEmpty) {
                        FocusScope.of(context).requestFocus(_nodeEmail);
                      } else if (txtPassWord.text.isEmpty) {
                        FocusScope.of(context).requestFocus(_nodePassword);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text('Login'),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'or Login with',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                          onPressed: () {
                            // Handle Google Sign In
                          },
                          icon: Image.asset('assets/7611770.png', height: 30),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                          onPressed: () {
                            // Handle Facebook Sign In
                          },
                          icon: Image.asset('assets/747.png', height: 30),
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey[200],
                        child: IconButton(
                          onPressed: () {
                            // Handle Facebook Sign In
                          },
                          icon: Image.asset('assets/Facebook_Logo_2023.png',
                              height: 30),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 70),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'By clicking Login, you agree to our Terms and Conditions',
                          style: TextStyle(color: Colors.black, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                // Navigate to Terms of Use
                              },
                              child: Text('Terms of Use',
                                  style: TextStyle(fontSize: 12)),
                            ),
                            Text('and', style: TextStyle(fontSize: 12)),
                            TextButton(
                              onPressed: () {
                                // Navigate to Privacy Policy
                              },
                              child: Text('Privacy Policy',
                                  style: TextStyle(fontSize: 12)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
