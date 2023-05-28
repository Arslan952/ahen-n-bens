import 'package:flutter/material.dart';

class OrderFoodDetail extends StatefulWidget {
  final List<dynamic> data;
  final String id;
  const OrderFoodDetail({Key? key,required this.data,required this.id}) : super(key: key);

  @override
  State<OrderFoodDetail> createState() => _OrderFoodDetailState();
}

class _OrderFoodDetailState extends State<OrderFoodDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.id),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: widget.data.length,
          itemBuilder: (context,index){
        return ListTile(
          title:Text(widget.data[index]['name']) ,
          subtitle:Text(widget.data[index]['quantity'].toString()),
          trailing:Text(widget.data[index]['price'].toString()),
        );
      }),
    );
  }
}
