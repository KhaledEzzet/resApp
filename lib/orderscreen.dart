import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderScreen extends StatelessWidget {
  @override
  var orderRess;
  var orderMeal;
  var orderPrice;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Screen'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.blue,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('shoppingcart')
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
          return ListView.builder(
            itemCount: orderData.length,
            itemBuilder: (context, index) {
              var orderDelet = orderData[index];
              orderRess = orderData[index]['ResName'];
              orderMeal = orderData[index]['ResMeal'];
              orderPrice = orderData[index]['ResPrice'];

              return Card(
                child: Column(
                  children: [
                    Text(orderRess),
                    Text(orderMeal),
                    Text(orderPrice),
                    RaisedButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('shoppingcart')
                            .doc(orderDelet.id)
                            .delete();
                      },
                      child: Text('data'),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseFirestore.instance.collection('shoppingcart').add({
            'ResName': orderRess,
            'ResMeal': orderMeal,
            'ResPrice': orderPrice,
            'userId': 'sdasd'
          });
        },
      ),
    );
  }
}
