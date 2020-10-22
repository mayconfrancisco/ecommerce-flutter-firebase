import 'package:ecommerce_flutter/tabs/home_tab.dart';
import 'package:ecommerce_flutter/tabs/order_tab.dart';
import 'package:ecommerce_flutter/tabs/products_tab.dart';
import 'package:ecommerce_flutter/widgets/cart_button.dart';
import 'package:ecommerce_flutter/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Meus pedidos'),
            centerTitle: true,
          ),
          body: OrderTab(),
          drawer: CustomDrawer(_pageController),
        )
      ],
    );
  }
}
