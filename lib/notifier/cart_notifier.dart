import 'package:flutter/material.dart';
import 'package:simple_shopping_app/constants/app_images.dart';
import 'package:simple_shopping_app/models/product.dart';

class CartNotifier extends ChangeNotifier {
  CartNotifier._();

  static final instance = CartNotifier._();

  Set<Product> _productsInCart = {};
  List<Product> get productsInCart => _productsInCart.toList();

  void addToCart(Product product) {
    _productsInCart.contains(product)
        ? removeFromCart(product)
        : _productsInCart.add(product);

    notifyListeners();
  }

  void removeFromCart(Product product) {
    _productsInCart.remove(product);
    notifyListeners();
  }

  void invalidateCart() {
    _productsInCart = {};
    notifyListeners();
  }

  num getTotalAmountInCart() {
    num total = 0;

    for (Product product in _productsInCart) {
      total += product.amount;
    }
    return total;
  }
}

const products = [
  Product(
      amount: 32,
      weight: '10g',
      imagePath: AppImages.iPhantom,
      marketName: "Phantom Kush",
      source: "Indica Leaf"),
  Product(
      amount: 12,
      weight: '8g',
      imagePath: AppImages.sativa,
      marketName: "Yinbu",
      source: "Sativa Leaf"),
  Product(
      amount: 88,
      weight: '25g',
      imagePath: AppImages.sBerry,
      marketName: "Berry Kush",
      source: "Sativa Leaf"),
  Product(
      amount: 52,
      weight: '16g',
      imagePath: AppImages.iSpartan,
      marketName: "Ewe Spartan",
      source: "Indica Leaf"),
  Product(
      amount: 35,
      weight: '6g',
      imagePath: AppImages.iLettuse,
      marketName: "Lettuse Cocco",
      source: "Indica Leaf"),
  Product(
      amount: 45,
      weight: '20g',
      imagePath: AppImages.sGolden,
      marketName: "Golden Pineapple",
      source: "Sativa Leaf"),
  Product(
      amount: 32,
      weight: '10g',
      imagePath: AppImages.sChapo,
      marketName: "Igbo Chapo",
      source: "Sativa Leaf"),
  Product(
      amount: 29,
      weight: '14g',
      imagePath: AppImages.iCanna,
      marketName: "Canadian Loud",
      source: "Indica Leaf"),
];
