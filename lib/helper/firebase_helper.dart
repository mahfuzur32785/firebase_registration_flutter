import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/admin/admin_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../auth_screen/signin_page.dart';
import '../custom_things/nav_bar/custom_btm_nav_bar.dart';

class FireBaseHelper with ChangeNotifier {
  bool userSignInLoading = false;
  bool signUpLoading = false;
  bool profileUpdateLoading = false;
  bool adminSignInLoading = false;
  bool addBikeDalaLoading = false;
  bool userCardLoading = false;

  //FOR SIGNUP ++++++++++++++++++++++++++++++++
  Future<void> createUser({user_name, user_email, user_pass, context}) async {
    signUpLoading = true;
    notifyListeners();
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user_email, password: user_pass)
          .then((value) {
        signUpLoading = false;
        notifyListeners();
        signUpSuccessfulMassege(user_name, user_email, user_pass, context);
      }).catchError((error) {
        signUpLoading = false;
        notifyListeners();
        signUpUnsuccessfulmassege(context, error);
      });

      try {
        final user = FirebaseAuth.instance.currentUser;
        await user!.sendEmailVerification();
      } catch (error) {
        signUpLoading = false;
        notifyListeners();
        print(error);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        signUpLoading = false;
        notifyListeners();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        signUpLoading = false;
        notifyListeners();
        print('The account already exists for that email.');
      }
    } catch (e) {
      signUpLoading = false;
      notifyListeners();
      print(e);
    }
  }
  //FOR SIGNUP ---------------------------------

  //FOR STORE USER INFO IN FIRESTORE DATABASE ++++++++++++++++++++++++++++++++
  Future<void> addUser({user_name, user_email, user_pass, context}) {
    // Call the user's CollectionReference to add a new user
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final getId = FirebaseAuth.instance.currentUser!.uid;
    //final docId = getId.id;
    //print('Doc Id is '+getId.id);

    return users.doc(getId).set({
      'id': getId,
      'name': user_name,
      'email': user_email,
      'password': user_pass
    });
/*
        .add({'name': user_name, 'email': user_email, 'password': user_pass})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));*/
  }
  //FOR STORE USER INFO IN FIRESTORE DATABASE --------------------------------

  //FOR SignUp SUCCESSFUL Dialog MASSEGE+++++++++++++++
  signUpSuccessfulMassege(user_name, user_email, user_pass, context) {
    addUser(
        user_name: user_name,
        user_email: user_email,
        user_pass: user_pass,
        context: context);
    Alert(
      context: context,
      buttons: [
        DialogButton(
          child: Text(
            'Go Sign In',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignInPage()),
                (route) => false);
          },
          color: Color(0xFF006847),
        )
      ],
      title: "Sign Up Successful",
      desc:
          "A Verification email has sent to your registered email. Please verify email before Sign In",
      style: AlertStyle(
        descStyle: TextStyle(
          fontSize: 14,
        ),
        isOverlayTapDismiss: false,
      ),
      image: Image(
        image: AssetImage('assets/images/checked.png'),
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ).show();
  }
  //FOR Signup SUCCESSFUL Dialog MASSEGE---------------

  //FOR UNSUCCESSFUL Dialog MASSEGE+++++++++++++++
  signUpUnsuccessfulmassege(context, value) {
    signUpLoading = false;
    notifyListeners();
    Alert(
      context: context,
      buttons: [],
      title: "Sign Up Unsuccessful",
      desc: "Their have something error. $value",
      style: AlertStyle(
        descStyle: TextStyle(
          fontSize: 14,
        ),
        isOverlayTapDismiss: false,
      ),
      image: Image(
        image: AssetImage('assets/images/cancel.png'),
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ).show();
  }
  //FOR UNSUCCESSFUL Dialog MASSEGE-----------------

  //FOR USER SIGN IN+++++++++++++++++++++++++++++++++++++++++++++
  userSignin({user_email, user_pass, context}) async {
    userSignInLoading = true;
    notifyListeners();

    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user_email, password: user_pass);

      final user = credential.user;

      if (user!.uid.isNotEmpty) {
        if (user.emailVerified) {
          print('Sign in successful');
          userSignInLoading = false;
          notifyListeners();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
              (route) => false);
        } else {
          print('Email is not verified');
          userSignInLoading = false;
          notifyListeners();
          signInFailedMassege(context, 'Email is not verified');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Their have no user with this email');
        userSignInLoading = false;
        notifyListeners();
        signInFailedMassege(context, e);
      } else if (e.code == 'wrong-password') {
        print('Your Given password is wrong');
        userSignInLoading = false;
        notifyListeners();
        signInFailedMassege(context, e);
      }
    }
  }
  //FOR USER SIGN IN------------------------------------------

  //FOR SIGN IN FAILED Dialog+++++++++++++++++++
  signInFailedMassege(context, e) {
    Alert(
      context: context,
      buttons: [],
      title: "Sign In Failed",
      desc: "Their have something error. $e",
      style: AlertStyle(
        descStyle: TextStyle(
          fontSize: 14,
        ),
        isOverlayTapDismiss: true,
      ),
      image: Image(
        image: AssetImage('assets/images/cancel.png'),
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ).show();
  }
  //FOR SIGN IN FAILED Dialog---------------------

  // FOR ADMIN SIGN IN+++++++++++++++++++++++++++++++++++++++++++++
  adminSignin({user_email, user_pass, context}) async {
    adminSignInLoading = true;
    notifyListeners();

    Future<bool> userExists(user_email, user_pass) async {
      return await FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: user_email)
          .where('pass', isEqualTo: user_pass)
          .get()
          .then((value) => value.size > 0 ? true : false);
    }

    bool result = await userExists(user_email, user_pass);
    if (result == true) {
      adminSignInLoading = false;
      notifyListeners();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AdminPage()),
        (route) => false,
      );
    } else {
      adminSignInLoading = false;
      notifyListeners();
      adminSignInFailedMassege(
          context, 'Admin not found with this email and password');
    }
  }
  //FOR ADMIN SIGN IN------------------------------------------

  //FOR ADMIN SIGN IN FAILED Dialog+++++++++++++++++++
  adminSignInFailedMassege(context, e) {
    Alert(
      context: context,
      buttons: [],
      title: "Admin Sign In Failed",
      desc: "Their have something error. $e",
      style: AlertStyle(
        descStyle: TextStyle(
          fontSize: 14,
        ),
        isOverlayTapDismiss: true,
      ),
      image: Image(
        image: AssetImage('assets/images/cancel.png'),
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ).show();
  }
  //FOR ADMIN SIGN IN FAILED Dialog---------------------

  //FOR USER SIGN OUT++++++++++++++++++++++++++++++
  Future<void> signOut(context) async {
    await FirebaseAuth.instance
        .signOut()
        .then((value) => signOutDialog(context));
  }
  //FOR USER SIGN OUT--------------------------------

  //FOR SIGN OUT CONFIRM DIALOG ++++++++++++++++++++++++++++
  signOutDialog(context) {
    Alert(
      context: context,
      buttons: [
        DialogButton(
          color: Color(0xFF006847),
          child: Text(
            'No',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        DialogButton(
          color: Color(0xFF006847),
          child: Text(
            'Yes',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => SignInPage()),
                (route) => false);
          },
        ),
      ],
      title: "Are you Sure?",
      desc: "Do you want to sign out from this app",
      style: AlertStyle(
        descStyle: TextStyle(
          fontSize: 14,
        ),
        isOverlayTapDismiss: true,
      ),
      image: Image(
        image: AssetImage('assets/images/warning.png'),
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ).show();
  }
  //FOR SIGN OUT CONFIRM DIALOG ------------------------------

  //FOR PROFILE UPDATE AFTER EDIT+++++++++++++++++++++++++++++
  Future<void> updateUserProfile(
      {img, user_name, user_phone, user_address, imageFile, context}) async {
    profileUpdateLoading = true;
    notifyListeners();

    if (imageFile != null) {
      print(imageFile);
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      UploadTask uploadTask =
          firebaseStorage.ref('profile').child('imageFile').putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final getId = FirebaseAuth.instance.currentUser!.uid;
      return users.doc(getId).update({
        'name': user_name,
        'phone': user_phone,
        'address': user_address,
        'img': imageUrl
      }).then((value) {
        profileUpdateLoading = false;
        notifyListeners();
        profileUpdateSuccessfulMassege(context);
      });
    } else {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      final getId = FirebaseAuth.instance.currentUser!.uid;
      return users.doc(getId).update({'img': img}).then((value) {
        profileUpdateLoading = true;
        notifyListeners();
        profileUpdateSuccessfulMassege(context);
      });
    }
  }
  //FOR PROFILE UPDATE AFTER EDIT-------------------------------------------

  //FOR SUCCESSFUL Dialog MASSEGE+++++++++++++++
  profileUpdateSuccessfulMassege(context) {
    profileUpdateLoading = false;
    notifyListeners();
    Alert(
      context: context,
      buttons: [
        DialogButton(
          child: Text(
            'Go Home',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
                (route) => false);
            //Navigator.of(context,rootNavigator: true).pop();
          },
          color: Color(0xFF006847),
        )
      ],
      title: "Profile Update Successful",
      style: AlertStyle(
        descStyle: TextStyle(
          fontSize: 14,
        ),
        isOverlayTapDismiss: false,
        isCloseButton: false,
      ),
      image: Image(
        image: AssetImage('assets/images/checked.png'),
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ).show();
  }
  //FOR SUCCESSFUL Dialog MASSEGE---------------

  //FOR UPLOAD BIKE INFORMATION++++++++++++++++++++++++
  addBikeData(
      {name,
      price,
      length,
      height,
      width,
      wheel_base,
      ground_clear,
      weight,
      fuel_capacity,
      engine_type,
      displacement,
      max_power,
      max_tork,
      stering_type,
      gear_type,
      number_gear,
      tyre_f_size,
      tyre_r_size,
      wheel_size,
      front_break,
      rear_break,
      battery_type,
      head_lemp,
      imageFile,
        category,
      context}) async {

    addBikeDalaLoading = true;
    notifyListeners();

    try{
      FirebaseStorage firebaseStorage = FirebaseStorage.instance;

      UploadTask uploadTask =
      firebaseStorage.ref('bike_image').child('${name}').putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      final adminPost = FirebaseFirestore.instance.collection('admin_post').doc();

      return adminPost.set({
        'name': name,
        'price': price,
        'length': length,
        'height': height,
        'width': width,
        'wheel_base': wheel_base,
        'ground_clear': ground_clear,
        'weight': weight,
        'fuel_capacity': fuel_capacity,
        'engine_type': engine_type,
        'displacement': displacement,
        'max_power': max_power,
        'max_tork': max_tork,
        'stering_type': stering_type,
        'gear_type': gear_type,
        'number_gear': number_gear,
        'tyre_f_size': tyre_f_size,
        'tyre_r_size': tyre_r_size,
        'wheel_size': wheel_size,
        'front_break': front_break,
        'rear_break': rear_break,
        'battery_type': battery_type,
        'head_lemp': head_lemp,
        'img': imageUrl,
        'category': category
      }).then((value) {
        addBikeDalaLoading = false;
        notifyListeners();
        bikeDataUploadSuccessMessagge(context);
      }).catchError((error){
        addBikeDalaLoading = false;
        notifyListeners();
        print('Something Error Ghotece $error');
        bikeDataUploadErrorMessagge(context, error);
      });
    }catch(e){
      addBikeDalaLoading = false;
      notifyListeners();
      print('Something Error Ghotece Aikhane $e');
      bikeDataUploadErrorMessagge(context, e);
    }
  }
  //FOR UPLOAD BIKE INFORMATION------------------------------


  //FOR BIKe Data Upload Dialog MASSEGE+++++++++++++++
  bikeDataUploadSuccessMessagge(context) {
    Alert(
      context: context,
      buttons: [
        DialogButton(
          child: Text(
            'Go Home',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AdminPage()),
                    (route) => false);
            //Navigator.of(context,rootNavigator: true).pop();
          },
          color: Color(0xFF006847),
        )
      ],
      title: "Data Added Successful",
      style: AlertStyle(
        descStyle: TextStyle(
          fontSize: 14,
        ),
        isOverlayTapDismiss: false,
        isCloseButton: false,
      ),
      image: Image(
        image: AssetImage('assets/images/checked.png'),
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ).show();
  }
  //FOR BIKe Data Upload Dialog MASSEGE---------------


  //FOR BIKe Data Upload Dialog MASSEGE+++++++++++++++
  bikeDataUploadErrorMessagge(context, error) {
    Alert(
      context: context,
      buttons: [
        DialogButton(
          child: Text(
            'Go Home',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => AdminPage()),
                    (route) => false);
            //Navigator.of(context,rootNavigator: true).pop();
          },
          color: Color(0xFF006847),
        )
      ],
      title: "${error}",
      style: AlertStyle(
        descStyle: TextStyle(
          fontSize: 14,
        ),
        isOverlayTapDismiss: false,
        isCloseButton: false,
      ),
      image: Image(
        image: AssetImage('assets/images/checked.png'),
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ).show();
  }
  //FOR BIKe Data Upload Dialog MASSEGE---------------

  //User Order Card++++++++++++++++++++++++
  userOrderCardAdd({name, img, price, context}){
    userCardLoading = true;
    notifyListeners();

    CollectionReference users_card =
    FirebaseFirestore.instance.collection('users_card');
    final getId = FirebaseAuth.instance.currentUser!.uid;

    return users_card.add(
        {
          'name': name,
          'price': price,
          'img': img,
          'id': getId
        }
    ).then((value) {
      userCardLoading = false;
      notifyListeners();
      print('User Card Added');
      userCardADDSuccessfulMassege(context);
    });
  }
  //User Order Card----------------------------

  //User Order Card ADD SUCCESS MESSAGE++++++++++++++++++++++++
  userCardADDSuccessfulMassege(context) {
    Alert(
      context: context,
      buttons: [
        DialogButton(
          child: Text(
            'Go Home',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
                    (route) => false);
            //Navigator.of(context,rootNavigator: true).pop();
          },
          color: Color(0xFF006847),
        )
      ],
      title: "Card Added Successfully",
      style: AlertStyle(
        descStyle: TextStyle(
          fontSize: 14,
        ),
        isOverlayTapDismiss: false,
        isCloseButton: false,
      ),
      image: Image(
        image: AssetImage('assets/images/checked.png'),
        height: MediaQuery.of(context).size.height * 0.1,
      ),
    ).show();
  }
  //User Order Card ADD SUCCESS MESSAGE++++++++++++++++++++++++

}
