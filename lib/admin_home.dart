import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hensbuns/addfood.dart';
import 'package:hensbuns/userlist.dart';

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
            child: Text(
              "Welcome to the\n Admin Panel",
              style: GoogleFonts.lobster(
                  fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserList()));
                  },
                  child: GlassContainer.clearGlass(
                      child: Center(
                        child: Text(
                          "User List",
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
