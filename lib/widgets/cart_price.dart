import 'package:ecommerce_flutter/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;

  CartPrice(this.buy);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ScopedModelDescendant<CartModel>(
            builder: (context, child, cartModel) {
          double subTotal = cartModel.getProductsPrice();
          double discount = cartModel.getDiscount();
          double ship = cartModel.getShipPrice();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Resumo do pedido',
                style: TextStyle(fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Subtotal'),
                  Text('R\$ ${subTotal.toStringAsFixed(2)}')
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Desconto'),
                  Text('R\$ ${discount.toStringAsFixed(2)}')
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Entrega'),
                  Text('R\$ ${ship.toStringAsFixed(2)}')
                ],
              ),
              const Divider(),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'R\$ ${(subTotal + ship - discount).toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                height: 44,
                child: RaisedButton(
                    child: Text('Finalizar pedido'),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: buy),
              )
            ],
          );
        }),
      ),
    );
  }
}
