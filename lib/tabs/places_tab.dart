import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/tiles/place_tile.dart';
import 'package:flutter/material.dart';

class PlacesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection('places').getDocuments(),
        builder: (context, placesSnapshot) {
          if (!placesSnapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: placesSnapshot.data.documents
                  .map((place) => PlaceTile(place))
                  .toList(),
            );
          }
        });
  }
}
