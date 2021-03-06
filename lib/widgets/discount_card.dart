import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/models/cart_model.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Cupom de desconto',
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Digite seu cupom'),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                Firestore.instance
                    .collection('coupons')
                    .document(text)
                    .get()
                    .then((couponSnap) {
                  if (couponSnap.data != null) {
                    CartModel.of(context)
                        .setCoupon(text, couponSnap.data['percent']);

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(
                          'Cupom de ${couponSnap.data['percent']}% aplicado com sucesso!'),
                      backgroundColor: Theme.of(context).primaryColor,
                    ));
                  } else {
                    CartModel.of(context).setCoupon(null, 0);

                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Cupom não existente!'),
                      backgroundColor: Colors.redAccent,
                    ));
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
