import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'login.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),(){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
    });
  }
  /*void initState() {
    super.initState();
    Timer( Duration(seconds: 4), () =>
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) =>Login()), (
            route) => false));
  }*/
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            height: double.infinity,

            child: Column(
              children: [
                Image.asset('assets/image/Logo.png',width: width*.7,),
                SizedBox(height: height*0.17,),
                Lottie.asset('assets/animation/loading.json', height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
