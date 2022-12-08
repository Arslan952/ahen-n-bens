import 'package:flutter/material.dart';
import 'package:hensbuns/address.dart';

class Adress extends StatelessWidget {
  const Adress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Text(
            'Address',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: Address1.listOfAddress.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Card(
                        elevation: 5,
                        shadowColor: const Color(0xffffc416),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 15, top: 10, left: 10, right: 10),
                              child: Image.asset(
                                Address1.listOfAddress[index].image,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                    child: Text(
                                  Address1.listOfAddress[index].place,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                               Row(
                                 children: [
                                   SizedBox(
                                     height:50,
                                     width:120,
                                     child: Card(
                                       elevation: 5,
                                       shadowColor: const Color(0xffffc416),
                                       shape: RoundedRectangleBorder(
                                         borderRadius: BorderRadius.circular(30),
                                       ),
                                       child: Center(child: Text('Open Now',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)),
                                       color: Colors.amber,
                                     ),
                                   )
                                 ],
                               )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
