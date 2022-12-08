import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';
class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}
final _formkey=GlobalKey<FormState>();
final List<String> error = [];
var email = "";
final emailcontroller = TextEditingController();
class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    resetpassword() async {
      try{
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.deepOrange,
            content: Text('Password Reset mail sent to your Account',style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),)

        ));
      }
      on FirebaseAuthException catch(e)
      {
        if(e.code=='user-not-found')
        {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.deepOrange,
              content: Text('User not Found',style: TextStyle(
                  color: Colors.white,
                  fontSize: 20
              ),)

          ));
        }

      }
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.angleLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Login()),
                    (route) => false);
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 100),
          child: Text(
            'Forget Password',
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
                  width: double.infinity,
                  child: Column(
                    children: const [
                      Text(
                        'Forget Password',
                        style: TextStyle(fontSize: 28),
                      ),
                      Text(
                        'Please Enter your email we will \n send you a link to your email',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xff343434)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
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
                            hintText: 'Enter Email',
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
                        height: 30,
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
                                "Send Email",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          onTap: (){
                            if(_formkey.currentState!.validate())
                            {
                              _formkey.currentState!.save();
                              setState(() {
                                email = emailcontroller.text;
                              });
                            }
                            resetpassword();
                          }
                      ),
                      const SizedBox(height: 15,),
                      GestureDetector(
                        child: const Text(
                          'Have account? Login',
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
