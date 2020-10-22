import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_flutter/data/cart_product.dart';
import 'package:ecommerce_flutter/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  UserModel userModel;
  bool isLoading = false;

  String couponCode;
  int discountPercentage = 0;

  List<CartProduct> products = [];

  CartModel(this.userModel) {
    if (userModel.isLoggedIn()) {
      _loadCartItems();
    }
  }

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    Firestore.instance
        .collection('users')
        .document(userModel.firebaseUser.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cId = doc.documentID;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection('users')
        .document(userModel.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cId)
        .delete();

    products.remove(cartProduct);

    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;

    Firestore.instance
        .collection('users')
        .document(userModel.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    Firestore.instance
        .collection('users')
        .document(userModel.firebaseUser.uid)
        .collection('cart')
        .document(cartProduct.cId)
        .updateData(cartProduct.toMap());

    notifyListeners();
  }

  void setCoupon(String code, int percentage) {
    this.couponCode = code;
    this.discountPercentage = percentage;
  }

  _loadCartItems() async {
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(userModel.firebaseUser.uid)
        .collection('cart')
        .getDocuments();

    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();

    notifyListeners();
  }
}
