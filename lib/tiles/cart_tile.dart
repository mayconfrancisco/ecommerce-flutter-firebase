import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/data/cart_product.dart';
import 'package:ecommerce_flutter/data/product_data.dart';
import 'package:ecommerce_flutter/models/cart_model.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  CartTile(this.cartProduct);

  Widget _buildContent(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          width: 120,
          child: Image.network(
            cartProduct.productData.images[0],
            fit: BoxFit.cover,
          ),
        ),
        Expanded(
            child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cartProduct.productData.title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
              ),
              Text(
                'Tamanho ${cartProduct.size}',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              Text(
                'R\$ ${cartProduct.productData.price.toStringAsFixed(2)}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: cartProduct.quantity == 1
                        ? null
                        : () {
                            CartModel.of(context).decProduct(cartProduct);
                          },
                    color: Theme.of(context).primaryColor,
                  ),
                  Text(cartProduct.quantity.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      CartModel.of(context).incProduct(cartProduct);
                    },
                    color: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                      onPressed: () {
                        CartModel.of(context).removeCartItem(cartProduct);
                      },
                      child: Text(
                        'Remover',
                        style: TextStyle(color: Colors.grey[500]),
                      )),
                ],
              )
            ],
          ),
        ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartProduct.productData == null
          ? FutureBuilder(
              future: Firestore.instance
                  .collection('products')
                  .document(cartProduct.category)
                  .collection('items')
                  .document(cartProduct.pId)
                  .get(),
              builder: (context, productSnapshot) {
                if (productSnapshot.hasData) {
                  cartProduct.productData =
                      ProductData.fromDocument(productSnapshot.data);
                  return _buildContent(context);
                } else {
                  return Container(
                    height: 70,
                    child: CircularProgressIndicator(),
                    alignment: Alignment.center,
                  );
                }
              })
          : _buildContent(context),
    );
  }
}
