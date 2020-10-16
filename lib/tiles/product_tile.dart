import 'package:ecommerce_flutter/data/product_data.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData data;

  ProductTile(this.type, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(data.title),
    );
  }
}
