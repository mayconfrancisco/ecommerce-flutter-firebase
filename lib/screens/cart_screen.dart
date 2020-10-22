import 'package:ecommerce_flutter/models/cart_model.dart';
import 'package:ecommerce_flutter/models/user_model.dart';
import 'package:ecommerce_flutter/screens/login_screen.dart';
import 'package:ecommerce_flutter/tiles/cart_tile.dart';
import 'package:ecommerce_flutter/widgets/discount_card.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu carrinho'),
        actions: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, cartModel) {
              int p = cartModel.products.length;
              return Text(
                '${p ?? 0} ${p == 1 ? "item" : "itens"}',
                style: TextStyle(fontSize: 18),
              );
            }),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
          builder: (context, child, cartModel) {
        if (cartModel.isLoading && UserModel.of(context).isLoggedIn()) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!UserModel.of(context).isLoggedIn()) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.remove_shopping_cart,
                  color: Theme.of(context).primaryColor,
                  size: 80,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Faça login para adicionar produtos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                RaisedButton(
                    child: Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    }),
              ],
            ),
          );
        } else if (cartModel.products == null ||
            cartModel.products.length == 0) {
          return Center(
            child: Text(
              'Nenhum produto no carrinho',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView(
            children: [
              Column(
                children: cartModel.products
                    .map((product) => CartTile(product))
                    .toList(),
              ),
              DiscountCard()
            ],
          );
        }
      }),
    );
  }
}
