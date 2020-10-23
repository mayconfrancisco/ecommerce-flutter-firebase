import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  final DocumentSnapshot place;

  PlaceTile(this.place);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          SizedBox(
              height: 100,
              child: Image.network(
                place.data['image'],
                fit: BoxFit.cover,
              )),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.data['Title'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(place.data['address']),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FlatButton(
                        onPressed: () {
                          launch(
                              'https://www.google.com/maps/search/?api=1&query=${place.data['lat']},${place.data['long']}');
                        },
                        child: Text(
                          'Ver no Mapa',
                          style: TextStyle(color: Colors.blue),
                        )),
                    FlatButton(
                        onPressed: () {
                          launch('tel:${place.data['phone']}');
                        },
                        child: Text(
                          'Ligar',
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
