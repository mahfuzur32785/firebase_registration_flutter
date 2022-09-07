import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../auth_screen/signin_page.dart';
import '../custom_things/nav_bar/custom_btm_nav_bar.dart';

class FireBaseHelper with ChangeNotifier{
  bool signInLoading =false;
  bool signUpLoading = false;
  bool profileUpdateLoading = false;

  //FOR SIGNUP ++++++++++++++++++++++++++++++++
  Future<void> createUser({user_name, user_email, user_pass, context}) async {

    signUpLoading =true;
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
        signUpUnsuccessfulmassege(context, error);});

      try {
        final user = FirebaseAuth.instance.currentUser;
        await user!.sendEmailVerification();
      } catch (error) {
        signUpLoading =false;
        notifyListeners();
        print(error);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        signUpLoading =false;
        notifyListeners();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        signUpLoading =false;
        notifyListeners();
        print('The account already exists for that email.');
      }
    } catch (e) {
      signUpLoading =false;
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

    return users.doc(getId).set({'id': getId,
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
      buttons: [
      ],
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

    signInLoading = true;
    notifyListeners();

    try {
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: user_email, password: user_pass);

      final user = credential.user;

      if (user!.uid.isNotEmpty) {
        if(user.emailVerified){
          print('Sign in successful');
          signInLoading = false;
          notifyListeners();
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => CustomBottomNavBar()),
                  (route) => false);
        }
        else{
          print('Email is not verified');
          signInLoading = false;
          notifyListeners();
          signInFailedMassege(context, 'Email is not verified');
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('Their have no user with this email');
        signInLoading = false;
        notifyListeners();
        signInFailedMassege(context, e);
      } else if (e.code == 'wrong-password') {
        print('Your Given password is wrong');
        signInLoading = false;
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
      buttons: [
      ],
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

  //FOR USER SIGN OUT++++++++++++++++++++++++++++++
  Future<void> signOut(context) async {
    await FirebaseAuth.instance.signOut().then((value) => signOutDialog(context));
  }
  //FOR USER SIGN OUT--------------------------------

  //FOR SIGN OUT CONFIRM DIALOG ++++++++++++++++++++++++++++
  signOutDialog(context) {
    Alert(
      context: context,
      buttons: [
        DialogButton(
          color:  Color(0xFF006847),
          child: Text('No',style: TextStyle(color: Colors.white),), onPressed: () {
          Navigator.of(context).pop();
        },),
        DialogButton(
          color: Color(0xFF006847),
          child: Text('Yes',style: TextStyle(color: Colors.white),), onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignInPage()), (route) => false);
        },),
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
  Future<void> updateUserProfile({img, user_name, user_phone, user_address, imageFile, context}) async{

    profileUpdateLoading = true;
    notifyListeners();

    if(imageFile!=null){
      print(imageFile);
      FirebaseStorage firebaseStorage =FirebaseStorage.instance;

      UploadTask uploadTask = firebaseStorage.ref('profile').child('imageFile').putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      CollectionReference users = FirebaseFirestore.instance.collection('users');
      final getId = FirebaseAuth.instance.currentUser!.uid;
      return users.doc(getId).update({
        'name': user_name,
        'phone': user_phone,
        'address': user_address,
        'img' : imageUrl
      }).then((value) {
        profileUpdateLoading = true;
        notifyListeners();
        profileUpdateSuccessfulMassege(context);
      } );
    }
    else{
       CollectionReference users = FirebaseFirestore.instance.collection('users');
      final getId = FirebaseAuth.instance.currentUser!.uid;
      return users.doc(getId).update({
        'img' : img
      }).then((value) {
        profileUpdateLoading = true;
        notifyListeners();
        profileUpdateSuccessfulMassege(context);
      } );
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
}
