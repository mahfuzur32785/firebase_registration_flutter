import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import '../custom_things/custom_txt_style/txt_style.dart';
import '../helper/firebase_helper.dart';

class ItemDetails extends StatefulWidget {
  ItemDetails({Key? key, this.index, this.snapshot}) : super(key: key);

  var index;
  AsyncSnapshot<QuerySnapshot>? snapshot;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    //final Stream<QuerySnapshot> adminPost = FirebaseFirestore.instance.collection('admin_post').snapshots();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          'Item Details',
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10,right: 10,top: 10,bottom: 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //image
              Container(
                height: 250,
                width: double.infinity,
                color: Colors.grey,
                child: Image(
                  image: NetworkImage(
                      '${widget.snapshot!.data!.docs[widget.index]['img']}'),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //name and price
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Text(
                        '${widget.snapshot!.data!.docs[widget.index]['name']}',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                        border: Border.all(color: Colors.black, width: 0.5),
                        color: Color(0xfffcf5f6),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      alignment: Alignment.center,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      child: Text(
                        'Price: ' +
                            '${widget.snapshot!.data!.docs[widget.index]['price']}' +
                            ' BDT',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                        color: Color(0xfffcf5f6),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.05,
                      alignment: Alignment.center,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              //body dymention details
              Text(
                'Body & Dimension',
                style: myStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Length / Width / Height',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['length']}' +
                              ' / ' +
                              '${widget.snapshot!.data!.docs[widget.index]['width']}' +
                              ' / ' +
                              '${widget.snapshot!.data!.docs[widget.index]['height']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Wheel Base',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['wheel_base']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Ground Clearance',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['ground_clear']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Weight',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['weight']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Text(
                          'Fuel Cepacity',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['wheel_base']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //ENGINE TYPE DETAILS
              Text(
                'Engine Details',
                style: myStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Type',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['engine_type']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Displacement',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['displacement']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Max Power',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['max_power']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Max Torque',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['max_tork']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Text(
                          'Starting Mathod',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['stering_type']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //Transmission DETAILS
              Text(
                'Transmission Details',
                style: myStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Gear Type',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['gear_type']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Number of Gear',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['number_gear']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //Tyres and Breaks
              Text(
                'Tyres & Breaks',
                style: myStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tyre Size (Front)',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['tyre_f_size']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tyre Size (Rear)',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['tyre_r_size']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Wheel Size',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['wheel_size']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Front Break',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['front_break']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Rear Break',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['rear_break']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //Electrical Details
              Text(
                'Electrical',
                style: myStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Battery',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['battery_type']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //margin: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Head Lamp',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Color(0xfffcf5f6),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.snapshot!.data!.docs[widget.index]['head_lemp']}',
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.1,
                          ),
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          Provider.of<FireBaseHelper>(context, listen: false).userOrderCardAdd(
              name: widget.snapshot!.data!.docs[widget.index]['name'],
              img: widget.snapshot!.data!.docs[widget.index]['img'],
              price: widget.snapshot!.data!.docs[widget.index]['price'],
              context: context
          );
        },
        child: Container(
          height: 50,
          width: double.maxFinite,
          alignment: Alignment.center,
          color: Color(0xFF006847),
          child: (Provider.of<FireBaseHelper>(context).userCardLoading)?
          CircularProgressIndicator(color: Colors.white,)
              :Text(
            'Add to Card',
            style: myStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16
            ),
          ),
        ),
      ),
    );
  }
}
