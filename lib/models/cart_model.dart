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

  void updatePrices() {
    notifyListeners();
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct c in products) {
      price += c.quantity * c.productData.price;
    }
    return price;
  }

  double getDiscount() {
    if (discountPercentage > 0) {
      return (getProductsPrice() * discountPercentage) / 100;
    }
    return 0;
  }

  double getShipPrice() {
    return 9.99;
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

  Future<String> finishOrder() async {
    if (products.length == 0) return null;

    isLoading = true;

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference docRef =
        await Firestore.instance.collection('orders').add({
      'clientId': userModel.firebaseUser.uid,
      'products': products.map((cartProduct) => cartProduct.toMap()).toList(),
      'shipPrice': shipPrice,
      'productsPrice': productsPrice,
      'discount': discount,
      'totalPrice': productsPrice + shipPrice - discount,
      'status': 1,
    });

    await Firestore.instance
        .collection('users')
        .document(userModel.firebaseUser.uid)
        .collection('orders')
        .document(docRef.documentID)
        .setData({'orderId': docRef.documentID});

    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .document(userModel.firebaseUser.uid)
        .collection('cart')
        .getDocuments();

    for (DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }

    products.clear();

    couponCode = null;
    discountPercentage = 0;

    isLoading = false;
    notifyListeners();

    return docRef.documentID;
  }
}
