import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../custom_things/custom_text_feild/custom_text_feild.dart';
import '../helper/firebase_helper.dart';

class AddBikeData extends StatefulWidget {
  const AddBikeData({Key? key}) : super(key: key);

  @override
  State<AddBikeData> createState() => _AddBikeDataState();
}

class _AddBikeDataState extends State<AddBikeData> {

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController wheelBaseController = TextEditingController();
  TextEditingController groundClearController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController fuelCapacityController = TextEditingController();
  TextEditingController engineTypeController = TextEditingController();
  TextEditingController displacementController = TextEditingController();
  TextEditingController maxPowerController = TextEditingController();
  TextEditingController maxTorqueController = TextEditingController();
  TextEditingController staringTypeController = TextEditingController();
  TextEditingController gearTypeController = TextEditingController();
  TextEditingController numberGearController = TextEditingController();
  TextEditingController tyreFSizeController = TextEditingController();
  TextEditingController tyreRSizeController = TextEditingController();
  TextEditingController wheelSizeController = TextEditingController();
  TextEditingController frontBreakController = TextEditingController();
  TextEditingController rearBreakController = TextEditingController();
  TextEditingController batteryTypeController = TextEditingController();
  TextEditingController headLempCntroller = TextEditingController();

  XFile? bikeImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Add Bike Data',style: TextStyle(
          color: Colors.black,
        ),),
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back),color: Colors.black,),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height*.8,
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Body'),
              SizedBox(height: 10,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:4,
                      child: CustomTextFeild(
                        controller: nameController,
                        obscureText: false,
                        hintText: 'Bike Name',
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Price',
                        controller: priceController,
                      ),)
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Length',
                        controller: lengthController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Height',
                        controller: heightController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Width',
                        controller: widthController,
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Wheel base',
                        controller: wheelBaseController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Ground clearance',
                        controller: groundClearController,
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Weight',
                        controller: weightController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Fuel Capacity',
                        controller: fuelCapacityController,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Text('Engine details'),
              SizedBox(height: 10,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Engine Type',
                        controller: engineTypeController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Displacement',
                        controller: displacementController,
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Max net power',
                        controller: maxPowerController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Max net tarque',
                        controller: maxTorqueController,
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Starting type',
                        controller: staringTypeController,
                      ),
                    ),
                    Expanded(
                        flex:2,
                        child: Container()
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Text('Transmission details'),
              SizedBox(height: 10,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Gear type',
                        controller: gearTypeController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Number Of Gears',
                        controller: numberGearController,
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Text('Tyres & brakes'),
              SizedBox(height: 10,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Tyre Size (Front)',
                        controller: tyreFSizeController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Tyre Size (Rear)',
                        controller: tyreRSizeController,
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Wheel Size',
                        controller: wheelSizeController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 3,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Brakes Front',
                        controller: frontBreakController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 3,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Brakes Front',
                        controller: rearBreakController,
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Text('Electricals'),
              SizedBox(height: 10,),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      flex:2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Battery Type',
                        controller: batteryTypeController,
                      ),),
                    SizedBox(width: 5,),
                    Expanded(
                      flex: 2,
                      child: CustomTextFeild(
                        obscureText: false,
                        hintText: 'Head Lamp',
                        controller: headLempCntroller,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),

              //Image add ++++++++++++++++++++++++++
              Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey.shade100,
                alignment: Alignment.center,
                child: bikeImage!=null? Stack(
                  children: [
                    Container(
                      child: Image(image: FileImage(File(bikeImage!.path)),),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Row(
                        children: [
                          IconButton(onPressed: () {
                            setState(() {
                              bikeImage = null;
                            });
                          }, icon: Icon(Icons.delete),),
                          IconButton(onPressed: () {
                            imagePickerOption();
                          }, icon: Icon(Icons.edit,color: Colors.white,size: 30,),)
                        ],
                      ),
                    )
                  ],
                ): Container(
                  child: IconButton(onPressed: () {
                    imagePickerOption();
                  }, icon: Icon(Icons.photo,size: 30,))
                ),
              ),
              SizedBox(height: 20,),

              //Upload Button ++++++++++++++++++++++
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(onPressed: () {
                  FireBaseHelper().addBikeData(
                    name: nameController.text, price: priceController.text, length: lengthController.text,
                    height: heightController.text, width: widthController.text, wheel_base: wheelBaseController.text,
                    ground_clear: groundClearController.text, weight: weightController.text, fuel_capacity: fuelCapacityController.text,
                    engine_type: engineTypeController.text, displacement: displacementController.text,
                    max_power: maxPowerController.text, max_tork: maxTorqueController.text, stering_type: staringTypeController.text,
                    gear_type: gearTypeController.text, number_gear: numberGearController.text, tyre_f_size: tyreFSizeController.text,
                    tyre_r_size: tyreRSizeController.text, wheel_size: wheelSizeController.text, front_break: frontBreakController.text,
                    rear_break: rearBreakController.text, battery_type: batteryTypeController.text, head_lemp: headLempCntroller.text,
                    img: bikeImage,
                  );
                }, child: Text('Upload'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF006847),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
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
    bikeImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {

    });
  }
  _getFromCamera() async {
    ImagePicker _picker = ImagePicker();
    bikeImage = await _picker.pickImage(source: ImageSource.camera);
    setState(() {

    });
  }
}
