import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  Widget build(BuildContext context){

    final Stream<QuerySnapshot> adminPost = FirebaseFirestore.instance.collection('admin_post').snapshots();

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddBikeData()));
        },
        child: Icon(Icons.add,size: 40,),
        backgroundColor: Color(0xFF006847),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: adminPost,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Color(0xFF006847),));
                  }

                  return Container(
                    child: GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10
                      ),
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return Stack(
                          children: [
                            Card(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  /*boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10,
                                      offset: Offset(00, 1)
                                    ),
                                  ],*/
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  children: [
                                    Image(image: NetworkImage(data['img']),
                                    height: 100,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(data['name']),
                                    Text(data['price']),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                ),
                              ),
                            ),
                            Positioned(
                                child: Row(
                              children: [
                                IconButton(onPressed: () {
                                  
                                }, icon: Icon(Icons.delete,color: Colors.red,),
                                ),
                              ],
                            ),
                              top: -5,
                              left: -10,
                            ),
                            Positioned(
                                child: Row(
                              children: [
                                IconButton(onPressed: () {

                                }, icon: Icon(Icons.edit,color: Colors.red,),
                                ),
                              ],
                            ),
                              top: -5,
                              right: -8,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
