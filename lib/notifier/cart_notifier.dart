import 'package:flutter/material.dart';
import 'package:simple_shopping_app/models/product.dart';
import 'package:simple_shopping_app/models/timbu_response.dart';
import 'package:simple_shopping_app/service/http_service.dart';

class CartNotifier extends ChangeNotifier {
  CartNotifier._();

  static final instance = CartNotifier._();

  bool isLoading = false;

  TimbuResponse timbuResponse = TimbuResponse();
  List<Product> productsFromTimbu = [];

  Set<Product> _productsInCart = {};
  List<Product> get productsInCart => _productsInCart.toList();

  Future<TimbuResponse> getProductsFromTimbu() async {
    final client = HttpService();

    try {
      timbuResponse.isLoading = true;
      notifyListeners();
      final response = await client.getProducts();
      timbuResponse.products = response;
      timbuResponse.isLoading = false;
      notifyListeners();
      timbuResponse.errorMessage = null;
      notifyListeners();

      return timbuResponse; 
    } catch (e) {
      timbuResponse.errorMessage = e.toString();
      timbuResponse.isLoading = false;
      timbuResponse.products = null;
      notifyListeners();
    return timbuResponse;  
    }
    
  }

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
