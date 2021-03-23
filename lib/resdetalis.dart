import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khmsta/ordernow.dart';
import 'package:khmsta/orderscreen.dart';
import 'package:khmsta/shoppingcart.dart';

class RestData extends StatelessWidget {
  final String name;
  RestData({
    this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderNow()));
              })
        ],
      ),
      backgroundColor: Colors.grey,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('restruant')
              .where('name', isEqualTo: name)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            var ressData = snapshot.data.docs.toList();
            return ListView.builder(
              itemCount: ressData.length,
              itemBuilder: (context, index) {
                var resmeal = ressData[index]['meal'];
                var resdes = ressData[index]['descripton'];
                var resImage = ressData[index]['image'];
                var ressprice = ressData[index]['price'];

                return Column(
                  children: [
                    Card(
                        child: Column(
                      children: [
                        Image.network(resImage != null ? resImage : 'null'),
                        Text(resmeal),
                        Text(resdes),
                        Text(ressprice.toString()),
                        RaisedButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance
                                .collection('orders')
                                .add({
                              'ResName': name,
                              'ResMeal': resmeal,
                              'ResPrice': ressprice,
                              'userId': 'sdasd'
                            });
                          },
                          child: Text('Order Now'),
                        )
                      ],
                    ))
                  ],
                );
              },
            );
          }),
    );
  }
}
