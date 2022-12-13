import 'package:flutter/material.dart';
import 'package:provider_with_shoppingcart/Cartmodel.dart';
import 'package:provider_with_shoppingcart/DbHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class Cartprovider with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalprice => _totalPrice;

  DBHelper db = DBHelper();

  late Future<List<Cart>> _cart;
  Future<List<Cart>> get cart => _cart;

  Future<List<Cart>> getData() async {
    _cart = db.getCartData();
    return _cart;
  }



  void _setPrefItem() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("cart_item", _counter);
    pref.setDouble("total_price", _totalPrice);
    notifyListeners();
  }

  void _getPrefItem() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _counter = pref.getInt("cart_item") ?? 0;
    _totalPrice = pref.getDouble("total_price") ?? 0.0;
    notifyListeners();
  }

  

  void addTotalprice(double productprice) {
    _totalPrice = _totalPrice + productprice;
    _setPrefItem();
    notifyListeners();
  }

  double getTotalprice() {
    _getPrefItem();
    return _totalPrice;
  }

  void removeTotalprice(double productprice) {
    _totalPrice = _totalPrice + productprice;
    _setPrefItem();
    notifyListeners();
  }

  int getcounter() {
    _getPrefItem();
    return _counter;
  }

  void addCounter() {
    _counter++;
    _setPrefItem();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefItem();
    notifyListeners();
  }

 
}
