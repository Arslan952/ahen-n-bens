import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}
final _formkey = GlobalKey<FormState>();
final List<String> error = [];
bool _obsecuretext = true;
final namecontroller = TextEditingController();
final phonenumbercontroller = TextEditingController();
final emailcontroller = TextEditingController();
final passwordcontroller = TextEditingController();
final firebase = FirebaseFirestore.instance;
class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.black,
          ),
          onPressed: () {},
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 100),
          child: Text(
            'Register',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/image/image2.png'),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: namecontroller,
                          onChanged: (value){
                            if(value.isNotEmpty )
                            {
                              setState(() {
                                error.remove('Enter Your Name');
                              });
                            }
                          },
                          validator: (value){
                            if(value!.isEmpty )
                            {
                              setState(() {
                                error.add('Enter Your Name');
                              });
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.supervised_user_circle_outlined,
                                )),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 20),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Name',
                            hintText: 'Enter Name',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: const BorderSide(color: Colors.black26),
                                gapPadding: 10),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                gapPadding: 10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: phonenumbercontroller,
                          keyboardType: TextInputType.number,
                          onChanged: (value){
                            if(value.isNotEmpty)
                            {
                              setState(() {
                                error.remove('Enter Phone Number');
                              });
                            }
                          },
                          validator: (value){
                            if(value!.isEmpty )
                            {
                              setState(() {
                                error.add('Enter Phone Number');
                              });
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.phone,
                                )),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 20),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Phone Number',
                            hintText: '03xxxxxxxxx',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: const BorderSide(color: Colors.black26),
                                gapPadding: 10),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                gapPadding: 10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: emailcontroller,
                          onChanged: (value){
                            if(value.isNotEmpty && value.contains('@'))
                            {
                              setState(() {
                                error.remove('Enter valid email');
                              });
                            }
                          },
                          validator: (value){
                            if(value!.isEmpty && !value.contains('@'))
                            {
                              setState(() {
                                error.add('Enter valid email');
                              });
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: const Padding(
                                padding: EdgeInsets.only(right: 30),
                                child: Icon(
                                  Icons.email_outlined,
                                )),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 20),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Email',
                            hintText: 'abc@gmail.com',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: const BorderSide(color: Colors.black26),
                                gapPadding: 10),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                gapPadding: 10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(

                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: passwordcontroller,
                          onChanged: (value){
                            if(value.isNotEmpty )
                            {
                              setState(() {
                                error.remove('Enter Password');
                              });
                            }
                          },
                          validator: (value){
                            if(value!.isEmpty )
                            {
                              setState(() {
                                error.add('Enter Password');
                              });
                            }
                            return null;
                          },
                          obscureText: _obsecuretext,
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obsecuretext = !_obsecuretext;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: Icon(_obsecuretext
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 42, vertical: 20),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelText: 'Password',
                            hintText: '*****',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                borderSide: const BorderSide(color: Colors.black26),
                                gapPadding: 10),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(28),
                                gapPadding: 10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ErrorMessage(error: error),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.05,
                      ),

                      GestureDetector(
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.symmetric(horizontal: 50),
                            decoration: BoxDecoration(
                                color: const Color(0xffffc416),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: ()async{
                            if(_formkey.currentState!.validate())
                            {
                            /*  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Container(
                                    padding: const EdgeInsets.all(16),
                                    height:90 ,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffe1ad01),
                                        borderRadius: BorderRadius.all(Radius.circular(20))
                                    ),
                                    child:Row(
                                      children: [
                                        const SizedBox(width: 48,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: const [
                                              Text('Register Successful ',style: TextStyle(fontSize: 18,color: Colors.white),),
                                              Text('Please Login agin with your credential',style: TextStyle(fontSize: 12,color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                ),
                              );
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Login()),
                                      (route) => false);*/

                              _formkey.currentState!.save();
                              try {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                User? user = FirebaseAuth.instance.currentUser;
                                auth
                                    .createUserWithEmailAndPassword(
                                    email: emailcontroller.text,
                                    password: passwordcontroller.text)
                                    .then((signinUser) => {
                                  FirebaseFirestore.instance
                                      .collection('User')
                                      .doc(signinUser.user!.uid)
                                      .set({
                                    'name': namecontroller.text,
                                    'phonenumber':phonenumbercontroller.text,
                                    'email': emailcontroller.text,
                                    'password': passwordcontroller.text,
                                  })
                                });

                              } catch (e) {
                                print(e);
                              }
                            }
                          }
                      ),
                      const SizedBox(height: 15,),
                      GestureDetector(
                        child: const Text(
                          'Have no account? Login',
                          style: TextStyle(color: Colors.black45),
                        ),
                        onTap: () {
                         Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                                  (route) => false);
                        },
                      ),
                    ],
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
