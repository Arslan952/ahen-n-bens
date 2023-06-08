import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class CartScreen extends StatelessWidget {
  final String uid; // UID to match
  final CollectionReference _ordersCollection =
  FirebaseFirestore.instance.collection('orders');

  CartScreen({required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1,vertical: MediaQuery.of(context).size.height*0.1),
          child: Column(
            children: [
              Icon(Icons.shopping_cart,size: 80,color:  Color(0xffffc416),),
              SizedBox(height: 20,),
              Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _ordersCollection.where('uid', isEqualTo: uid).snapshots(),
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

                        return ListTile(
                          title: Text(
                            data['name'],
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Quantity: ${data['quantity']}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Price: \$${data['price']}'),
                              IconButton(
                                icon: const Icon(Icons.delete,color: Colors.red,),
                                onPressed: () {
                                  // Delete the document from Firestore
                                  document.reference.delete();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              SizedBox(height: 16.0),
              FutureBuilder<double>(
                future: _calculateTotalOrderPrice(),
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  double totalOrderPrice = snapshot.data ?? 0.0;

                  return Column(
                    children: [
                      Text(
                        'Total Order Price: \$${totalOrderPrice.toStringAsFixed(
                            2)}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      GestureDetector(
                        child: Container(
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                              color: const Color(0xffffc416),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "Place Order",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        onTap: () async{
                          QuerySnapshot snapshot = await _ordersCollection.where('uid', isEqualTo: uid).get();

                          List<Map<String, dynamic>> orderDetails = snapshot.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                            return {
                              'name': data['name'],
                              'quantity': data['quantity'],
                              'price': data['price'],
                            };
                          }).toList();
                          // Logic to place the order and store in the database
                          _placeOrder(totalOrderPrice, orderDetails);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Order Placed'),
                                content: Text('Your order has been placed.'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     // Logic to place the order and store in the database
                      //     _placeOrder(totalOrderPrice);
                      //     showDialog(
                      //       context: context,
                      //       builder: (BuildContext context) {
                      //         return AlertDialog(
                      //           title: Text('Order Placed'),
                      //           content: Text('Your order has been placed.'),
                      //           actions: <Widget>[
                      //             TextButton(
                      //               child: Text('OK'),
                      //               onPressed: () {
                      //                 Navigator.of(context).pop();
                      //               },
                      //             ),
                      //           ],
                      //         );
                      //       },
                      //     );
                      //   },
                      //   child: Text('Place Order'),
                      // ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<double> _calculateTotalOrderPrice() async {
    QuerySnapshot snapshot =
    await _ordersCollection.where('uid', isEqualTo: uid).get();

    double totalOrderPrice = 0.0;

    snapshot.docs.forEach((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      dynamic price = data['price'];

      if (price is int) {
        totalOrderPrice += (price as int).toDouble();
      } else if (price is double) {
        totalOrderPrice += price;
      }

      int quantity = data['quantity'] as int;
      totalOrderPrice += price;
    });

    return totalOrderPrice;
  }

  void _placeOrder(double totalOrderPrice, List<Map<String, dynamic>> orderDetails)async {
    QuerySnapshot snapshot = await _ordersCollection.where('uid', isEqualTo: uid).get();
    // Delete the individual food item documents
    for (DocumentSnapshot document in snapshot.docs) {
      await document.reference.delete();
    }

    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    // Create a new document in the 'orders' collection

    FirebaseFirestore.instance.collection('placesorder').add({
      'orderId': orderId,
      'uid': uid,
      'totalOrderPrice': totalOrderPrice,
      'orderDetails': orderDetails,
      'timestamp': DateTime.now(),
    })
        .then((value) => print('Order placed successfully.'))
        .catchError((error) => print('Failed to place order: $error'));
  }

}