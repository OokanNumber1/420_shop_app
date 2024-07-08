import 'package:simple_shopping_app/models/product.dart';

class TimbuResponse {
  TimbuResponse({this.errorMessage, this.isLoading, this.products});
   String? errorMessage;
   List<Product>? products;
   bool? isLoading;

  static TimbuResponse empty() => TimbuResponse();
}
