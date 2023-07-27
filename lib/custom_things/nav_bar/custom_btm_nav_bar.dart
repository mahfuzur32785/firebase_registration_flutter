import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/custom_things/custom_txt_style/txt_style.dart';
import 'package:flutter/material.dart';
import '../../screen/card_details.dart';
import '../../screen/contact_page.dart';
import '../../screen/home_page.dart';
import '../../screen/profile/profile_page.dart';
import '../drawer/custom_drawer.dart';
import 'my_buttom_nav_bar.dart';
import 'my_nav_item.dart';

class CustomBottomNavBar extends StatefulWidget {
  CustomBottomNavBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {

  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  int _index = 0;
  List bodyList = [HomePage(),ContactPage(),ProfilePage()];
  List<DocumentSnapshot> docs = [];

  @override
  void didChangeDependencies() async{
     await FirebaseFirestore.instance
        .collection('users_card')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get().then((value) {
          docs = value.docs;
          setState(() {

          });
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => showExitPopup(context),
        child: Scaffold(
          key: drawerKey,
          appBar: AppBar(
            toolbarHeight: 70,
            backgroundColor: Color(0xFFFFFFFF),
            foregroundColor: Colors.black,
            elevation: 0,
            actions: [
              Stack(
                children: [
                  Center(
                    child: IconButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CardDetailsPage()));
                    },
                      icon: Icon(
                        Icons.shopping_cart, color: Colors.deepOrange,),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Text('${docs.length}', style: TextStyle(
                      color: Colors.red
                    ),),
                  ),
                ],
              )
            ],
            leading: IconButton(onPressed: () {
              drawerKey.currentState?.openDrawer();
            }, icon: Icon(Icons.menu)),
            centerTitle: true,
            title: Text(
              _index == 0 ? 'HomePage' : _index == 1
                  ? 'Contact Page'
                  : 'Profile',
              style: TextStyle(
                fontFamily: 'sf_Pro',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //key: drawerKey,
          body: bodyList[_index],
          drawer: CustomDrawer(),
          //If you want to show body behind the navbar, it should be true
          extendBody: true,
          bottomNavigationBar: MyNavBar(
            onTap: (int value) {
              setState(() {
                _index = value;
              });
            },
            currentIndex: _index,
            items: [
              MyNavbarItem(icon: Icons.home, title: 'Home'),
              MyNavbarItem(icon: Icons.contact_page, title: 'Contact'),
              MyNavbarItem(icon: Icons.person, title: 'Profile'),
            ],
            iconSize: 20,
            backgroundColor: Colors.white,
            elevation: 50,
            selectedBackgroundColor: Color(0xFF006847),
            selectedItemColor: Colors.white,
            unselectedItemColor: Color(0xFF006847),
            itemBorderRadius: 5,
            margin: EdgeInsets.all(20),
          ),
        ),
    );
  }
  Future<bool> showExitPopup(context) async{
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('assets/images/warning.png'),
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(child: Text("Are You Sure?")),
                  SizedBox(height: 10),
                  Center(child: Text("Do you want to close this app?")),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('no selected');
                              Navigator.of(context).pop();
                            },
                            child: Text("No", style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                          )),
                      SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade800),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });

}
}