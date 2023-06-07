import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hensbuns/detailscreen.dart';
import 'package:hensbuns/fooddata.dart';
class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('Food');
  @override
  Widget build(BuildContext context) {
    return  StreamBuilder<QuerySnapshot>(
      stream: _collectionRef.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22,top: 22),
              child: Text("Let\'s eat \n Quality Food 😋",style: GoogleFonts.lobster(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22,top: 22),
              child: Row(children: [
                Expanded(child: TextField(
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      hintText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide()
                      )
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 22,left: 15),
                  child: Card(
                    color: const Color(0xffffc416),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: const Color(0xffffc416),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        FontAwesomeIcons.search,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],),
            ),
            Padding(padding: const EdgeInsets.only(top: 22,right: 22,left: 22),
              child: Container(height: 60,
                child:  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:snapshot.data!.docs.length,
                    itemBuilder:(context,index){
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (c){
                            return DetailScreen(image: data['image'], name: data['name'], price: data['price'], description:data['detail'], time: data['time'], calaries: data['calories'], rating: data['rating'],);
                          }));
                        },
                        child: SizedBox(
                          width: 130,
                          child: Card(
                            elevation: 10,
                            color: const Color(0xffffc416),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 3,right: 3),
                              child: Row(children: [
                                Image.network(data['image'],height: 35,width: 35,),
                                Flexible(child: Text(data['name'],overflow: TextOverflow.ellipsis,))
                              ],),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 22,right: 35,left: 35),
              child: Container(height: 300,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder:(context,index){
                      DocumentSnapshot document = snapshot.data!.docs[index];
                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (c){
                            return DetailScreen(image: data['image'], name: data['name'], price: data['price'], description:data['detail'], time: data['time'], calaries: data['calories'], rating: data['rating'],);
                          }));
                        },
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width*0.6,
                          child: Card(
                            elevation: 5,
                            shadowColor: const Color(0xffffc416),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(data['image'],height: 150,width: 150,),
                                Text(data['name'],style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23
                                ),),
                                Text(data['sdescription'],style: const TextStyle(color: Colors.black26),),
                                Text("🔥" +data['calories'],style: const TextStyle(
                                    color: Colors.red
                                ),),
                                Text("\$" +data['price'],style: const TextStyle(
                                    fontSize: 22,fontWeight: FontWeight.bold
                                ),)
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          ],
        );
      },
    );
  }
}

