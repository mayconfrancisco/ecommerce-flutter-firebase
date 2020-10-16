import 'package:ecommerce_flutter/data/product_data.dart';
import 'package:ecommerce_flutter/screens/product_screen.dart';
import 'package:flutter/material.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductScreen(this.product)));
      },
      child: Card(
          child: "grid" == this.type
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            ' R\$ ${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    ))
                  ],
                )
              : Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Image.network(
                          product.images[0],
                          // height: 200,
                        )),
                    Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'R\$ ${product.price.toStringAsFixed(2)}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Theme.of(context).primaryColor),
                              )
                            ],
                          ),
                        )),
                  ],
                )),
    );
  }
}
