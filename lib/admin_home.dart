import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hensbuns/addfood.dart';
import 'package:hensbuns/placedorder.dart';
import 'package:hensbuns/userlist.dart';

import 'login.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.orangeAccent[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 70),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Welcome to the\n Admin Panel",
                  style: GoogleFonts.lobster(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),
                IconButton(onPressed: ()async{
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                }, icon: Icon(Icons.exit_to_app))
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: InkWell(
                  onTap: (){
                    Get.to(DataListScreen());
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>UserList()));
                  },
                  child: GlassContainer.clearGlass(
                      borderRadius: BorderRadius.circular(20),
                      borderColor: Colors.white,
                      elevation: 5,
                      blur: 2,
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width*0.9,
                      child: Center(
                        child: Text(
                          "Ordered Food",
                          style: GoogleFonts.lobster(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25),
                child:  InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddFood()));
                  },
                  child: GlassContainer.clearGlass(
                      child:  Center(
                        child: Text(
                          "Add Food ",
                          style: GoogleFonts.lobster(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ),
                      borderRadius: BorderRadius.circular(20),
                      borderColor: Colors.white,
                      elevation: 5,
                      blur: 2,
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width*0.9),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }
}
