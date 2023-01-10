import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final namecontroller = TextEditingController();
  final sdescontroller = TextEditingController();
  final calariescontroller = TextEditingController();
  final timecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final ratingcontroller = TextEditingController();
  final descriptioncontroller = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  @override
  void clearText() {
    namecontroller.clear();
    sdescontroller.clear();
    calariescontroller.clear();
    timecontroller.clear();
    pricecontroller .clear();
    ratingcontroller.clear();
    descriptioncontroller .clear();
  }
  File? pickedimage;
  String imageUrl = '';
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child:Column(
          children: [
            Form(
              key: key,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                        child: CircleAvatar(
                          radius: 51,
                          backgroundColor: Colors.orange,
                          child: CircleAvatar(
                            radius: 49,
                            backgroundColor: Colors.white,
                            backgroundImage: pickedimage == null
                                ? null
                                : FileImage(pickedimage!),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 70,
                        left: 65,
                        child: RawMaterialButton(
                          elevation: 10,
                          fillColor: Colors.white60,
                          padding: const EdgeInsets.all(5),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Chose Option",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.amber),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          InkWell(
                                            onTap: ()async {
                                              ImagePicker imagePicker = ImagePicker();
                                              XFile? file = await imagePicker.pickImage(
                                                  source: ImageSource.camera);
                                              final tempimage=File(file!.path);
                                              setState(() {
                                                pickedimage=tempimage;
                                              });
                                              String UniqueFileName =
                                              DateTime.now().millisecondsSinceEpoch.toString();
                                              //Reference
                                              Reference referenceroot = FirebaseStorage.instance.ref();
                                              Reference referenceDirimage = referenceroot.child('images');
                                              Reference referencImageToUpload =
                                              referenceDirimage.child(UniqueFileName);
                                              try {
                                                //store the file
                                                await referencImageToUpload.putFile(File(file.path));
                                                //get download url
                                                imageUrl = await referencImageToUpload.getDownloadURL();
                                              } catch (e) {}
                                              //store the file
                                              referencImageToUpload.putFile(File(file.path));
                                            },
                                            splashColor: Colors.amber,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(Icons.camera,
                                                    color: Colors.amber,),
                                                ),
                                                Text("Camera",style: TextStyle(
                                                    color: Colors.black,fontSize: 18,
                                                    fontWeight: FontWeight.w500
                                                ),)
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              ImagePicker imagePicker = ImagePicker();
                                              XFile? file = await imagePicker.pickImage(
                                                  source: ImageSource.gallery);
                                              final tempimage=File(file!.path);
                                              setState(() {
                                                pickedimage=tempimage;
                                              });
                                              String UniqueFileName =
                                              DateTime.now().millisecondsSinceEpoch.toString();
                                              //Reference
                                              Reference referenceroot = FirebaseStorage.instance.ref();
                                              Reference referenceDirimage = referenceroot.child('images');
                                              Reference referencImageToUpload =
                                              referenceDirimage.child(UniqueFileName);
                                              try {
                                                //store the file
                                                await referencImageToUpload.putFile(File(file.path));
                                                //get download url
                                                imageUrl = await referencImageToUpload.getDownloadURL();
                                              } catch (e) {}
                                              //store the file
                                              referencImageToUpload.putFile(File(file.path));
                                            },
                                            splashColor: Colors.indigoAccent,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(Icons.image,
                                                    color: Colors.amber,),
                                                ),
                                                Text("Gallery",style: TextStyle(
                                                    color: Colors.black,fontSize: 18,
                                                    fontWeight: FontWeight.w500
                                                ),)
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              Navigator.of(context).pop();
                                            },
                                            splashColor: Colors.indigoAccent,
                                            child: Row(
                                              children: const [
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(Icons.cancel,
                                                    color: Colors.red,),
                                                ),
                                                Text("Remove",style: TextStyle(
                                                    color: Colors.black,fontSize: 18,
                                                    fontWeight: FontWeight.w500
                                                ),)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.amber,
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      controller: namecontroller,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Product Name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text("Product Name"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          floatingLabelStyle:
                          TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.amber))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      controller: sdescontroller,
                      maxLength: 64,
                      maxLines: 2,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Short description';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text("Short Description"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          floatingLabelStyle:
                          TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.amber))),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      controller: calariescontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Calaries"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          floatingLabelStyle:
                          TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.amber))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      controller: timecontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Time to deliver"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          floatingLabelStyle:
                          TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.amber))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      controller: pricecontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Price"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          floatingLabelStyle:
                          TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.amber))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      controller: ratingcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          label: Text("Rating"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          floatingLabelStyle:
                          TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.amber))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: TextFormField(
                      controller: descriptioncontroller,
                      maxLength: 100,
                      maxLines: 3,
                      decoration: InputDecoration(
                          label: Text("Detail"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20)),
                          floatingLabelStyle:
                          TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(
                                  width: 2, color: Colors.amber))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.40,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: ()async {
                              if (imageUrl.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Please Upload an Image")));
                                return;
                              }
                              if (key.currentState!.validate()) {
                                try {
                                  FirebaseFirestore.instance
                                      .collection('Food')
                                      .add({
                                    'name':namecontroller.text,
                                    'sdescription':sdescontroller.text,
                                    'calories':calariescontroller.text,
                                    'time':timecontroller.text,
                                    'price':pricecontroller.text,
                                    'rating':ratingcontroller.text,
                                    'detail':descriptioncontroller.text,
                                    'image':imageUrl
                                  });

                                } catch (e) {
                                  print(e);
                                }
                                //Map
                                /*  Map<String,String> itemToAdd={
                                  'firstname':fnamecontroller.text,
                                  'lastname':lnamecontroller.text,
                                  'userid':idcontroller.text,
                                  'email':emailcontroller.text,
                                  'password':passwordcontroller.text,
                                  'image':imageUrl,
                                };
                                //Collection Reference
                                CollectionReference ref=FirebaseFirestore.instance.collection('user');
                                //Add a document with custom id
                                ref.doc(fnamecontroller.text).set(itemToAdd);*/

                              }
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 20,
                                backgroundColor: Colors.amber,
                                shadowColor: Colors.amber,
                                side: BorderSide.none,
                                shape: StadiumBorder()
                            ),
                            child:Text("Save",style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500
                            ),)),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.40,
                        height: 50,
                        child: ElevatedButton(onPressed: (){
                          clearText();
                        },
                            style: ElevatedButton.styleFrom(
                                elevation: 20,
                                backgroundColor: Colors.white54,
                                side: BorderSide.none,
                                shape: StadiumBorder()
                            ),
                            child:Text("Clear",style: TextStyle(
                                color: Colors.amber,
                                fontWeight: FontWeight.w500
                            ),)),
                      )
                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
