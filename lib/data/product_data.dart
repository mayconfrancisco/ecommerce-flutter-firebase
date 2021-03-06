import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String category;
  String id;
  String title;
  String description;
  double price;
  List sizes;
  List images;

  ProductData();

  ProductData.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    title = document.data['title'];
    description = document.data['description'];
    price = document.data['price'];
    sizes = document.data['sizes'];
    images = document.data['images'];
  }

  Map<String, dynamic> toResumedMap() => {
        'title': title,
        'description': description,
        'price': price,
      };
}
