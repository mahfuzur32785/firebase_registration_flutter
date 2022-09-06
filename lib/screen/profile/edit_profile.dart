import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../custom_things/custom_text_feild/custom_text_feild.dart';
import '../../helper/firebase_helper.dart';

class EditProfile extends StatefulWidget {
  EditProfile(
      {Key? key, this.name, this.phone, this.address, this.img})
      : super(key: key);

  String? name, phone, address, img;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  XFile? profileImage;
  String? imageUrl;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  imagePickerOption() {
    showDialog(context: context, builder: (context) {
      return AlertDialog(actionsAlignment: MainAxisAlignment.center,
        title: Center(child: Text('Select an option')),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: Text('Cancel',style: TextStyle(color: Color(0xFF006847),),))
        ],
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  flex:5,
                  child: GestureDetector(
                    onTap: (){
                      _getFromCamera();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        color: Color(0xFFDAD9D9),
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.camera_alt),
                            Text('Camera')
                          ],)
                    ),
                  ),
                ),
                Expanded(child: Container(height: 2,),flex: 1,),
                Expanded(
                  flex:5,
                  child: GestureDetector(
                    onTap: (){
                      _getFromGallery();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        color: Color(0xFFDAD9D9),
                        height: MediaQuery.of(context).size.height*0.1,
                        width: MediaQuery.of(context).size.width*0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.photo),
                            Text('Gallery')
                          ],)
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },);
  }

  //GET IMAGE FROM GALLERY+++++++++++++++
  _getFromGallery() async {
    ImagePicker _picker = ImagePicker();
    profileImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {

    });
    //_cropImage(profileImage);
  }

  _getFromCamera() async {
    ImagePicker _picker = ImagePicker();
    profileImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {

    });
    //_cropImage(profileImage);
  }
 /* /// Crop Image
  _cropImage(filePath) async{
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: profileImage!.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );

    if (croppedFile != null) {
      profileImage = croppedFile as XFile?;
      setState(() {});
    }
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = '${widget.name}';
    phoneController.text = '${widget.phone}';
    addressController.text = '${widget.address}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Color(0xFF006847),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20,bottom: 20),
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            imagePickerOption();
                          },
                          child: profileImage!=null? Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Color(0xFF006847),
                                backgroundImage: FileImage(File(profileImage!.path)),
                              ),
                              Positioned(
                                bottom: 20,
                                right: 20,
                                child: Icon(Icons.edit,color: Colors.white,size: 30,),
                              )
                            ],
                          ): Stack(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Color(0xFF006847),
                                backgroundImage: NetworkImage('${widget.img}'),
                              ),
                              Positioned(
                                bottom: 20,
                                right: 20,
                                child: Icon(Icons.edit,color: Colors.white,size: 30,),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Center(child: Text('Note : Email address can not be modify',style: TextStyle(color: Color(
                          0xFFBEB34C)),)),
                      SizedBox(height: 20,),
                      Text('Name'),
                      SizedBox(height: 10,),
                      CustomTextFeild(
                        controller: nameController,
                        obscureText: false,
                      ),
                      SizedBox(height: 20,),
                      Text('Phone'),
                      SizedBox(height: 10,),
                      CustomTextFeild(
                        controller: phoneController,
                        obscureText: false,
                      ),
                      SizedBox(height: 20,),
                      Text('Address'),
                      SizedBox(height: 10,),
                      CustomTextFeild(
                        controller: addressController,
                        obscureText: false,
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ElevatedButton(onPressed: () {
                              Navigator.of(context).pop();
                            }, child: Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF006847),
                              fixedSize: Size(double.infinity, 45),
                            ),
                            ),
                          ),
                          Expanded(child: Container(),flex: 1,),
                          Expanded(
                            flex: 5,
                            child: ElevatedButton(onPressed: () {
                              File imageFile = File(profileImage!.path);
                              (Provider.of<FireBaseHelper>(context,listen: false).updateUserProfile(imageFile: imageFile, user_name: nameController.text, user_phone: phoneController.text,user_address: addressController.text, context: context));
                            }, child: (Provider.of<FireBaseHelper>(context).profileUpdateLoading)?CircularProgressIndicator(color: Colors.white,):Text('Save'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF006847),
                                fixedSize: Size(double.infinity, 45),
                              ),),
                          ),
                        ],
                      )
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
