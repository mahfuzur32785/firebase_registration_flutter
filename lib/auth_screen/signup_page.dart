import 'package:firebase_project/auth_screen/signin_page.dart';
import 'package:flutter/material.dart';
import '../custom_things/custom_text_feild/custom_text_feild.dart';
import '../helper/firebase_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
        title: Text(
          'Create Account',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Account',
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
                  'Enter your name, email and password',
                  style: TextStyle(
                    color: Color(0xFFCCCDCD),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.007,
                ),
                Row(
                  children: [
                    Text(
                      'for sign up. ',
                      style: TextStyle(
                        color: Color(0xFFCCCDCD),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>SignInPage()), (route) => false);
                      },
                      child: Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Color(0xFF22A45D),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomTextFeild(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter name';
                    }
                  },
                  obscureText: false,
                  hintText: 'Full Name',
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
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
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      FireBaseHelper().createUser(user_name: nameController.text, user_email: emailController.text,user_pass: passController.text,context: context);
                      nameController.text='';
                      emailController.text='';
                      passController.text='';
                    }
                  },
                  child: Text('SIGN Up'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006847),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize: Size(MediaQuery.of(context).size.width * 1,
                        MediaQuery.of(context).size.height * 0.06),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'By Signinh up you agree to our Terms',
                        style: TextStyle(
                          color: Color(0xFFCCCDCD),
                        ),
                      ),
                      Text(
                        'Condition & Privacy Policy',
                        style: TextStyle(
                          color: Color(0xFFCCCDCD),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
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
                    primary: Color(0xFF4285F4),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*ElevatedButton(
              onPressed: (){
                createUser();
                addUser();
              },
              child: Text('Add'),
            ),*/
