import 'package:ecommerce_flutter/tiles/category_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('products').getDocuments(),
        builder: (context, snapshotProducts) {
          if (!snapshotProducts.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var divideTiles = ListTile.divideTiles(
                    tiles: snapshotProducts.data.documents
                        .map((doc) => CategoryTile(doc))
                        .toList(),
                    color: Colors.grey[500])
                .toList();

            return ListView(
              children: divideTiles,
            );
          }
        });
  }
}
