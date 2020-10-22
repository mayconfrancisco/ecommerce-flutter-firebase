import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  final String orderId;

  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance
              .collection('orders')
              .document(orderId)
              .snapshots(),
          builder: (context, ordersSnapshot) {
            if (!ordersSnapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            int status = ordersSnapshot.data['status'];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Código do pedido: ${ordersSnapshot.data.documentID}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(_buildProductsText(ordersSnapshot.data)),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircle("1", 'Preparação', status, 1),
                    Container(
                      height: 2,
                      width: 40,
                      color: Colors.grey[500],
                    ),
                    _buildCircle("2", 'Transporte', status, 2),
                    Container(
                      height: 2,
                      width: 40,
                      color: Colors.grey[500],
                    ),
                    _buildCircle("3", 'Entrega', status, 3),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  String _buildProductsText(DocumentSnapshot orderSnapshot) {
    String text = "Descrição:\n";
    for (LinkedHashMap p in orderSnapshot.data['products']) {
      text +=
          "${p['quantity']} x ${p['product']['title']} R\$ ${p['product']['price'].toStringAsFixed(2)}\n";
    }
    text += "Total R\$ ${orderSnapshot.data['totalPrice'].toStringAsFixed(2)}";
    return text;
  }

  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(
        title,
        style: TextStyle(color: Colors.white),
      );
    } else if (status == thisStatus) {
      backColor = Colors.blue;
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(
        Icons.check,
        color: Colors.white,
      );
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        )
      ],
    );
  }
}
