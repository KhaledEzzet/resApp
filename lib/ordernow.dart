import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderNow extends StatefulWidget {
  @override
  _OrderNowState createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  @override
  var price;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shopping Cart'),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('orders')
              .where('userId', isEqualTo: 'sdasd')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            var orderData = snapshot.data.docs.toList();
            int sum = 0;

            return SingleChildScrollView(
              child: Column(children: [
                ListView.builder(
                  itemCount: orderData.length,
                  itemBuilder: (context, index) {
                    var ordermeal = orderData[index]['ResMeal'];
                    var orderdes = orderData[index]['ResName'];
                    var orderprice = orderData[index]['ResPrice'];
                    // orderdes.forEach((e) {
                    //   print(e.toString());
                    // });
                    return Center(
                        child: Column(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              Text(ordermeal),
                              Text(orderprice.toString()),
                            ],
                          ),
                        ),
                      ],
                    ));
                  },
                  shrinkWrap: true,
                ),
                Divider(),
                Text(sum.toString()),
              ]),
            );
          },
        ));
  }
}
