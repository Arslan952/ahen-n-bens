import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hensbuns/orderfooddetail.dart';

class DataListScreen extends StatelessWidget {
  final CollectionReference _collectionRef =
  FirebaseFirestore.instance.collection('placesorder');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Detail'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _collectionRef.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot document = snapshot.data!.docs[index];
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;


              return GestureDetector(
                onTap: (){
                  Get.to(OrderFoodDetail(data: data['orderDetails'], id: data['orderId']));
                },
                child: ListTile(
                  title: Text(data['orderId']),
                  subtitle: Text(data['totalOrderPrice'].toString()),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
