import 'dart:io';

import 'package:firebase_project/custom_things/custom_text_feild/custom_text_feild.dart';
import 'package:firebase_project/helper/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'add_data.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Admin Panal',style: TextStyle(
          color: Colors.black,
        ),),
        actions: [
          IconButton(onPressed: () {
            FireBaseHelper().signOut(context);
          }, icon: Icon(Icons.logout),color: Colors.red,iconSize: 25,)
        ],
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddBikeData()));
              }, child: Text('Add Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF006847),
              ),
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
