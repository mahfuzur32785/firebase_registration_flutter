import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/custom_things/nav_bar/custom_btm_nav_bar.dart';
import 'package:firebase_project/helper/firebase_helper.dart';
import 'package:flutter/material.dart';

class CardDetailsPage extends StatefulWidget {
  CardDetailsPage({Key? key}) : super(key: key);

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  final Stream<QuerySnapshot> _cartStream = FirebaseFirestore.instance
      .collection('users_card')
      .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  int cnt = 1;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await Navigator.push(context,
            MaterialPageRoute(builder: (context) => CustomBottomNavBar()));
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Color(0xFFFFFFFF),
          foregroundColor: Colors.black,
          elevation: 0,
          title: Text('My Cart'),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomBottomNavBar()));
            },
            icon: Icon(Icons.arrow_back),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: StreamBuilder(
            stream: _cartStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('Something went wrong'));
              }
              else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: CircularProgressIndicator(color: Color(0xFF006847)));
              }
              else if (snapshot.hasData && snapshot.data!.docs.length != 0) {
                return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var _data = snapshot.data!.docs[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Item${snapshot.data!.docs.length}"),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image(
                                            image: NetworkImage(
                                                '${_data['img']}')),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${_data['name']}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              'TK. ${_data['price']}',
                                              style: TextStyle(
                                                  color: Colors.deepOrange),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          FireBaseHelper().deleteData(
                                              snapshot.data.docs[index].id);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 30,
                                        ))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (cnt <= 1) {
                                            } else {
                                              setState(() {
                                                cnt--;
                                              });
                                            }
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: Colors.red,
                                                  width: 0.3,
                                                )),
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF006847)),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 8),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: Colors.red,
                                                  width: 0.3,
                                                )),
                                            child: Text('${cnt}')),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              cnt++;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: Colors.red,
                                                  width: 0.3,
                                                )),
                                            child: Text('+',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF006847))),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(((int.parse(_data['price'])) * cnt).toString())
                                    /*Text(
                                    "TK. " "${_data['price']}",
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: snapshot.data.docs.length,
                );
              }
              return Center(
                child: Text(
                  'Your Cart is Empty Now',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
