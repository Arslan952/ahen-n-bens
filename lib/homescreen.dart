import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hensbuns/aresses.dart';
import 'package:hensbuns/cartscreen.dart';
import 'package:hensbuns/sidebarscreen.dart';
import 'aboutus.dart';
import 'home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _stream =
  FirebaseFirestore.instance.collection('Food').snapshots();

  //To do List
  CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('User');

  final item= const[
    Icon(FontAwesomeIcons.addressCard),
    Icon(Icons.home),
    Icon(FontAwesomeIcons.exclamation),

  ];
  int index=1;
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldkey,
      drawer:SideBarScreen(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: ()=>scaffoldkey.currentState?.openDrawer(),
          child: Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadowColor: Colors.black,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                FontAwesomeIcons.barsStaggered,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
        /*title: Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Text(
            'hen n buns',
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Color(0xffffc416))),
          ),
        ),*/
        actions: [
          InkWell(
            onTap: (){

              Get.to(CartScreen(uid:user!.uid ));
            },
            child: Card(
              color: Colors.white,
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: const [
                    Icon(
                      Icons.shopping_cart,
                      color: Colors.black,
                      size: 30,
                    ),
                    Positioned(
                      top: 3,
                      right: 1,
                      child: Icon(
                        Icons.brightness_1,
                        color: Colors.red,
                        size: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        items: item,
        index: index,
        onTap: (selectedIndex){
          setState(() {
            index=selectedIndex;
          });
        },
        height: 60,
        backgroundColor: Color(0xffffc416),
        animationDuration: const Duration(milliseconds: 300),
      ),
      body:
       Container(
        height: double.infinity,
        width: double.infinity,
        child: getSelectedWidget(index:index),
      ),
    );
  }

 Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch(index)
    {
      case 0:
        widget=Adress();
        break;
      case 1:
        widget=Home();
        break;
      case 2:
        widget=AboutUs();
        break;
      default:
        widget=Home();
        break;

    }
    return widget;
 }
}


