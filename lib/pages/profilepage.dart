import 'package:e_commerce_app/provider/user_provider.dart';
import 'package:e_commerce_app/services/Local/service_token.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<UserProvider>(builder: (context, userProvider, child) {
          final user = userProvider.user;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Center(
                    child: CircleAvatar(
                      maxRadius: 50,
                      backgroundImage: AssetImage('assets/4325945.png'),
                    ),
                  ),
                ),
                Text(
                  user.username,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(user.email,
                    style: TextStyle(
                      fontSize: 14,
                    )),
                SizedBox(
                  height: 22,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.black),
                      overlayColor: WidgetStateProperty.all(Colors.amber[700])),
                  onPressed: () {},
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Inventories',
                    style: TextStyle(color: Colors.grey[600], fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 136,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 219, 219, 219),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 10,
                          ),
                          child: ListTile(
                            title: Text(
                              'My store',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Icon(Icons.store_mall_directory),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_sharp),
                          )),
                      Divider(
                        height: 2,
                        endIndent: 23,
                        indent: 25,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            left: 10,
                          ),
                          child: ListTile(
                            title: Text(
                              'Support',
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            leading: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Icon(Icons.support_rounded),
                            ),
                            trailing: Icon(Icons.arrow_forward_ios_sharp),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                  width: 30,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Preferences',
                    style: TextStyle(color: Colors.grey[600], fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                onPressed: ()async {
                  ServiceToken.clearToken();
                  Navigator.pushNamed(context, '/login');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  overlayColor: MaterialStateProperty.all(Colors.red[100]),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, left: 10, bottom: 8),
                  child: ListTile(
                  title: Text(
                    'Logout',
                    style: TextStyle(fontSize: 17, color: Colors.red),
                  ),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(7),
                    ),
                    child: Icon(
                    Icons.logout,
                    color: Colors.red,
                    ),
                  ),
                  ),
                ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
