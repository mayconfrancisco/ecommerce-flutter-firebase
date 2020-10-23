import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/models/user_model.dart';
import 'package:ecommerce_flutter/screens/login_screen.dart';
import 'package:ecommerce_flutter/tiles/order_tile.dart';
import 'package:flutter/material.dart';

class OrderTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String userId = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection('users')
              .document(userId)
              .collection('orders')
              .getDocuments(),
          builder: (context, userOrdersSnapshot) {
            if (!userOrdersSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: userOrdersSnapshot.data.documents
                  .map((order) => OrderTile(order.documentID))
                  .toList()
                  .reversed
                  .toList(),
            );
          });
    } else {
      return Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.list,
              size: 80,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 16),
            Text(
              'Faça login para acompanhar seus pedidos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              height: 44,
              child: RaisedButton(
                child: Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18),
                ),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            )
          ],
        ),
      );
    }
  }
}
