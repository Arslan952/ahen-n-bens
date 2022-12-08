import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hensbuns/register.dart';


import 'forgetpassword.dart';
import 'homescreen.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final List<String> error = [];
  bool _obsecuretext = true;

  @override
  Widget build(BuildContext context) {
    userlogin(String email, String password) async {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.indigoAccent,
              content: Text(
                'User not Found',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.indigoAccent,
              content: Text(
                'Password is incorrect Please try again',
                style: TextStyle(color: Colors.white, fontSize: 20),
              )));
        }
      }
      /* Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false);*/
    }
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
            'Sign In',
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
                        'Welcome Back',
                        style: TextStyle(fontSize: 28),
                      ),
                      Text(
                        'We are glad to see you again \n Login with email and password',
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
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(color: Colors.black45),
                    ),
                    onTap: () {
                     Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) =>ForgetPassword()),
                              (route) => false);
                    },
                  ),
                  const SizedBox(height: 15,),
                  GestureDetector(
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      decoration: BoxDecoration(
                          color: const Color(0xffffc416),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          " Login",
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
                        userlogin(
                            emailcontroller.text, passwordcontroller.text);

                      }
                    }
                  ),
                  const SizedBox(height: 15,),
                  GestureDetector(
                    child: const Text(
                      'Have no account? Register',
                      style: TextStyle(color: Colors.black45),
                    ),
                    onTap: () {
                     Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
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

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    Key? key,
    required this.error,
  }) : super(key: key);

  final List<String> error;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(error.length, (index) =>formErrorText(error[index]) ),
    );
  }

  Padding formErrorText(String error) {
    return Padding(
        padding: const EdgeInsets.only(left: 30,top: 15),
        child: Row(children: [
         const Icon(Icons.error,color: Colors.red,),
          Text(error)
                ],),
      );
  }
}
