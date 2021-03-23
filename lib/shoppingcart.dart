import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:khmsta/orderscreen.dart';

class ShoppingCart extends StatelessWidget {
  final resName;
  final resMeal;
  final resMealPrice;

  ShoppingCart({this.resName, this.resMeal, this.resMealPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resMeal),
      ),
      backgroundColor: Colors.yellow,
      body: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(resName),
            Text(resMeal),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(resMealPrice),
                RaisedButton(
                  onPressed: () async {
                    await FirebaseFirestore.instance
                        .collection('shoppingcart')
                        .add({
                      'ResName': resName,
                      'ResMeal': resMeal,
                      'ResPrice': resMealPrice,
                      'userId': 'sdasd'
                    });
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => OrderScreen()));
                  },
                  child: Text('CheckOut'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
