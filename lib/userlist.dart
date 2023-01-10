import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final Stream<QuerySnapshot> _stream =
  FirebaseFirestore.instance.collection('User').snapshots();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder:
              (context,snapshot) {
            if(snapshot.hasError){
              print("Some thing went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xffff928e),
                    color: Color(0xff7d91f4),
                  )
              );
            }


            return  SingleChildScrollView(
              child: SafeArea(
         child: Column(
           children: [
             Center(
               child:  Padding(
                 padding: const EdgeInsets.only(top: 25,bottom: 20),
                 child: Text(
                   "Registered User Data",
                   style: GoogleFonts.lobster(
                       fontSize: 25, fontWeight: FontWeight.bold),
                 ),
               ),
             ),
             Container(
                 height: 500,
                 child: Padding(
                   padding: EdgeInsets.all(5),
                   child: ListView.builder(
                       itemCount: snapshot.data!.docs.length,
                       shrinkWrap: true,
                       physics: ScrollPhysics(),
                       itemBuilder: (context, index) {
                         DocumentSnapshot doc = snapshot.data!.docs[index];
                         return  Slidable(
                           startActionPane: ActionPane(
                             //extentRatio: 1,(0.1 to 1)
                             openThreshold: 0.5,
                             motion: BehindMotion(),
                             children: [
                               SlidableAction(
                                 onPressed: (context)
                                   async {
                                     try {
                                       FirebaseFirestore.instance.collection('User').doc(doc.id).delete();
                                     } catch (e) {
                                       print(e);
                                     }
                                   },

                                 icon: Icons.delete,
                                 label: "Delete",
                                 borderRadius:BorderRadius.circular(20),
                                 backgroundColor: Colors.red,
                               )
                             ],
                           ),
                           child: Card(
                             shape: RoundedRectangleBorder(
                              /* side:  BorderSide(
                                 color: Colors.indigoAccent,
                               ),*/
                               borderRadius: BorderRadius.circular(20.0), //<--// SEE HERE
                             ),
                             elevation: 10,
                             child: ListTile(
                               title: Text(doc['name']),
                               subtitle: Text(doc['email']),
                             ),
                           ),
                         );
                       }),

                 ),
               ),
           ],
         ),
       ),
            );
          }),
    ));
  }
}
