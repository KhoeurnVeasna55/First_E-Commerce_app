import 'dart:developer';

import 'package:e_commerce_app/services/apis/auth_api.dart';
import 'package:e_commerce_app/utils/snackbar_page.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_textfiled_showPassword.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final txtEmail = TextEditingController();
  final txtPassWord = TextEditingController();
  final txtuser = TextEditingController();
  final txtcomfrimpass = TextEditingController();
  final fromkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 50.0),
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
                          Text('You want to Login '),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: Text('Login'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Customtextfiled(
                    controller: txtEmail,
                    hintText: 'Email',
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input your Email';
                      }
                      return null;
                    }),
                SizedBox(height: 20),
                Customtextfiled(
                    controller: txtuser,
                    hintText: "Username",
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please input your Name';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 20,
                ),
                Customtextfiled(
                  obscureText: true,
                  controller: txtPassWord,
                  hintText: 'Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please input your Password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Customtextfiled(
                  obscureText: true,
                  controller: txtcomfrimpass,
                  hintText: 'Comfrim Password',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please input your Password';
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
                    if (!fromkey.currentState!.validate()) return;

                    // Check if passwords match
                    if (txtPassWord.text != txtcomfrimpass.text) {
                      if (context.mounted) {
                        SnackbarPage.showSnackbar(
                          context,
                          'Passwords do not match. Please check and try again.',
                        );
                      }
                      return;
                    }

                    // Proceed with registration
                    var response = await AuthApi.register(
                      context,
                      txtEmail.text,
                      txtPassWord.text,
                      txtuser.text,
                    );

                    if (response == true) {
                      // Registration successful
                      if (context.mounted) {
                        // Log success message to ensure it's correctly triggering
                        log(
                            "Registration successful, navigating to login...");
                        Navigator.pushNamed(context, '/mainPage');
                      }
                    } else {
                      // Handle failure
                      if (context.mounted) {
                        SnackbarPage.showSnackbar(
                          context,
                          'Registration failed. Please try again later.',
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text('Register'),
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
                SizedBox(height: 20),
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
                SizedBox(height: 120),
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
    );
  }
}
