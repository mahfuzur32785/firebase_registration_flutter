import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_project/auth_screen/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_things/custom_text_feild/custom_text_feild.dart';
import '../helper/firebase_helper.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wlecome',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  'Enter your email address to sign in\nEnjoy your day',
                  style: TextStyle(
                    color: Color(0xFFCCCDCD),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomTextFeild(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter email';
                    }
                  },
                  obscureText: false,
                  hintText: 'Email Address',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                CustomTextFeild(
                  controller: passController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter password';
                    }
                  },
                  obscureText: isObsecure,
                  hintText: 'Password',
                  textInputType: TextInputType.text,
                  suffixIcon: IconButton(
                    icon: isObsecure == false
                        ? Icon(
                            Icons.visibility,
                            color: Color(0xFF6F7471),
                          )
                        : Icon(
                            Icons.visibility_off,
                            color: Color(0xFF6F7471),
                          ),
                    onPressed: () {
                      setState(() {
                        isObsecure = !isObsecure;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      splashFactory: NoSplash.splashFactory,
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        color: Color(0xFFCCCDCD),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<FireBaseHelper>(context, listen: false)
                          .userSignin(
                              user_email: emailController.text,
                              user_pass: passController.text,
                              context: context);

                      //FireBaseHelper().userSignin(user_email: emailController.text, user_pass: passController.text, context: context, );
                    }
                    //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006847),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width * 1,
                        MediaQuery.of(context).size.height * 0.06),
                  ),
                  child: (Provider.of<FireBaseHelper>(context).userSignInLoading)
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('SIGN IN'),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory),
                      onPressed: null,
                      child: Text(
                        'Don\'t have account?',
                        style:
                            TextStyle(color: Color(0xFFCCCDCD), fontSize: 12),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SignUpPage()));
                      },
                      child: AutoSizeText(
                        'Create new account',
                        style:
                            TextStyle(color: Color(0xFF22A45D), fontSize: 14),
                        minFontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(
                    'Or',
                    style: TextStyle(
                      color: Color(0xFFCCCDCD),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF395998),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width * 1,
                        MediaQuery.of(context).size.height * 0.06),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Image(
                            image: AssetImage('assets/images/facebook.png'),
                            height: MediaQuery.of(context).size.height * 0.045,
                            width: 28,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text('CONNECT WITH FACEBOOK'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4285F4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width * 1,
                        MediaQuery.of(context).size.height * 0.06),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Image(
                            image: AssetImage('assets/images/google.png'),
                            height: MediaQuery.of(context).size.height * 0.045,
                            width: 28,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          alignment: AlignmentDirectional.center,
                          child: Text('CONNECT WITH GOOGLE'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006847),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width * 1,
                        MediaQuery.of(context).size.height * 0.06),
                  ),
                  child: (Provider.of<FireBaseHelper>(context).adminSignInLoading)
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text('Admin LogIn'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Provider.of<FireBaseHelper>(context, listen: false)
                          .adminSignin(
                              user_email: emailController.text,
                              user_pass: passController.text,
                              context: context,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
