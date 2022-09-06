import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
        leading: IconButton(onPressed: (){
          drawerKey.currentState?.openDrawer();
        }, icon: Icon(Icons.menu,color: Color(0xFF000000),)),
        centerTitle: true,
        title: Text(
          _index == 0 ? 'HomePage' : _index == 1 ? 'Contact Page' : 'Profile',
          style: TextStyle(
            fontFamily: 'sf_Pro',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF000000),
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
        backgroundColor: Colors.white,
        elevation: 50,
        selectedBackgroundColor: Color(0xFF006847),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xFF006847),
        itemBorderRadius: 5,
        margin: EdgeInsets.all(20),
      ),

    );
  }
}
