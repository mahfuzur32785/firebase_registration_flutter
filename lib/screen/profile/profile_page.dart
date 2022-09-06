import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helper/firebase_helper.dart';
import '../../model_class/user_model.dart';
import 'edit_profile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final myiconList = UserModel().icon;
  final mytextList = UserModel().title;

  String? name, email, phone, address, img;

  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if(snapshot.hasError){
            return Container(
              padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                      width: MediaQuery.of(context).size.width*1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFF006847),
                        child: Icon(Icons.photo_camera,size: 50,),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: ListView.builder(itemBuilder: (context, index) {
                        return ListTile(
                          leading: myiconList[index],
                          title: Text(mytextList[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          subtitle: Text('somethhing wrong',
                            style: TextStyle(
                                fontSize: 14,fontWeight: FontWeight.bold,
                                color: Colors.red
                            ),),
                        );
                      }, itemCount: myiconList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Divider(
                            color: Colors.red,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                          ElevatedButton.icon(
                            onPressed: () {

                            },
                            icon: Icon(Icons.edit),
                            label: Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(MediaQuery.of(context).size.width*1, MediaQuery.of(context).size.height*0.06),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              backgroundColor: Color(0xFF006847),
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Set New Password'),
                        subtitle: Text('Update Password'),
                      ),
                    ),GestureDetector(
                      onTap: () {
                        FireBaseHelper().signOut(context);
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.logout,color: Colors.red,),
                          title: Text('Go Out From the App'),
                          subtitle: Text('Log Out'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          else if(snapshot.connectionState == ConnectionState.waiting){
            return Container(
              padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                      width: MediaQuery.of(context).size.width*1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFF006847),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: ListView.builder(itemBuilder: (context, index) {
                        return ListTile(
                          leading: myiconList[index],
                          title: Text(mytextList[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          subtitle: Text('loading...',
                            style: TextStyle(
                                fontSize: 14,fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),),
                        );
                      }, itemCount: myiconList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Divider(
                            color: Colors.red,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                          ElevatedButton.icon(
                            onPressed: () {

                            },
                            icon: Icon(Icons.edit),
                            label: Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(MediaQuery.of(context).size.width*1, MediaQuery.of(context).size.height*0.06),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              backgroundColor: Color(0xFF006847),
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Set New Password'),
                        subtitle: Text('Update Password'),
                      ),
                    ),GestureDetector(
                      onTap: () {
                        FireBaseHelper().signOut(context);
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.logout,color: Colors.red,),
                          title: Text('Go Out From the App'),
                          subtitle: Text('Log Out'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          else if(snapshot.hasData && !snapshot.data!.exists){
            return Container(
              padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                      width: MediaQuery.of(context).size.width*1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Color(0xFF006847),
                        child: Icon(Icons.photo_camera,size: 50,),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: ListView.builder(itemBuilder: (context, index) {
                        return ListTile(
                          leading: myiconList[index],
                          title: Text(mytextList[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          subtitle: Text('. . . . . . . .',
                            style: TextStyle(
                                fontSize: 18,fontWeight: FontWeight.bold,
                                color: Colors.black
                            ),),
                        );
                      }, itemCount: myiconList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Divider(
                            color: Colors.red,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                          ElevatedButton.icon(
                            onPressed: () {

                            },
                            icon: Icon(Icons.edit),
                            label: Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(MediaQuery.of(context).size.width*1, MediaQuery.of(context).size.height*0.06),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              backgroundColor: Color(0xFF006847),
                            ),
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Set New Password'),
                        subtitle: Text('Update Password'),
                      ),
                    ),GestureDetector(
                      onTap: () {
                        FireBaseHelper().signOut(context);
                      },
                      child: Card(
                        child: ListTile(
                          leading: Icon(Icons.logout,color: Colors.red,),
                          title: Text('Go Out From the App'),
                          subtitle: Text('Log Out'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
            //return Text('Pro Doc Id is $docId');
          }
          else if(snapshot.connectionState == ConnectionState.done){

            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

            name = data['name'];
            email = data['email'];
            phone = data['phone'];
            address = data['address'];
            img = data['img'];

            return Container(
              padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 100),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                      width: MediaQuery.of(context).size.width*1,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: data['img']==null? Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundColor: Color(0xFF006847),
                              child: Icon(Icons.photo_camera,size: 50,),
                            ),
                          ],
                        ),
                      ): Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: NetworkImage(data['img']),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15,),
                      width: MediaQuery.of(context).size.width*1,
                      height: MediaQuery.of(context).size.height*0.36,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: ListView.separated(itemBuilder: (context, index) {
                        return ListTile(
                          leading: myiconList[index],
                          title: Text(mytextList[index],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          subtitle: Text(index==0?data['name']:index==1?data['email']:index==2&& data['phone']!=null?data['phone']:index==3&& data['address']!=null?data['address']:'update profile',
                            style: TextStyle(
                            fontSize: 18,fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                        );
                      }, itemCount: myiconList.length,
                      shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 0,);
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30,right: 30,bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Divider(
                            color: Colors.red,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditProfile(
                                name: name, phone: phone, address: address, img: img,
                              )));
                            },
                            icon: Icon(Icons.edit),
                            label: Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(MediaQuery.of(context).size.width*1, MediaQuery.of(context).size.height*0.06),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              backgroundColor: Color(0xFF006847),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 2,
                          offset: Offset(0, 1)
                        )]
                      ),
                      width: MediaQuery.of(context).size.width*1,
                      child: ListTile(
                        leading: Icon(Icons.lock),
                        title: Text('Set New Password'),
                        subtitle: Text('Update Password'),
                      ),
                    ),
                    SizedBox(height: 5,),
                    GestureDetector(
                      onTap: () {
                        FireBaseHelper().signOut(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: Offset(0, 1)
                            )]
                        ),
                        width: MediaQuery.of(context).size.width*1,
                        child: ListTile(
                          leading: Icon(Icons.logout,color: Colors.red,),
                          title: Text('Go Out From the App'),
                          subtitle: Text('Log Out'),
                        ),
                      ),
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
            );
          }
          return Container(
            padding: EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 100),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                    width: MediaQuery.of(context).size.width*1,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Color(0xFF006847),
                      child: Icon(Icons.photo_camera,size: 50,),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width*1,
                    height: MediaQuery.of(context).size.height*0.36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: ListView.builder(itemBuilder: (context, index) {
                      return ListTile(
                        leading: myiconList[index],
                        title: Text(mytextList[index],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        subtitle: Text('somethings wrong',
                          style: TextStyle(
                              fontSize: 14,fontWeight: FontWeight.bold,
                              color: Colors.red
                          ),),
                      );
                    }, itemCount: myiconList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30,right: 30,bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Divider(
                          color: Colors.red,
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                        ElevatedButton.icon(
                          onPressed: () {

                          },
                          icon: Icon(Icons.edit),
                          label: Text('Edit Profile'),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(MediaQuery.of(context).size.width*1, MediaQuery.of(context).size.height*0.06),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            backgroundColor: Color(0xFF006847),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.lock),
                      title: Text('Set New Password'),
                      subtitle: Text('Update Password'),
                    ),
                  ),GestureDetector(
                    onTap: () {
                      FireBaseHelper().signOut(context);
                    },
                    child: Card(
                      child: ListTile(
                        leading: Icon(Icons.logout,color: Colors.red,),
                        title: Text('Go Out From the App'),
                        subtitle: Text('Log Out'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
