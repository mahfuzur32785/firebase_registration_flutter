import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  ItemDetails({Key? key,this.index, this.snapshot}) : super(key: key);

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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text('Item Details',),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              height: 110,
              width: double.infinity,
              color: Colors.grey,
              child: Image(image: NetworkImage('${widget.snapshot!.data!.docs[widget.index]['img']}'),),
            ),
            Text('${widget.snapshot!.data!.docs[widget.index]['name']}'),
          ],
        ),
      )
    );
  }
}
