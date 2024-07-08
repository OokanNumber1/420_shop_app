import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:simple_shopping_app/models/product.dart';

class HttpService {
  final client = Client();

  Future<List<Product>> getProducts() async {
    const apiKey = String.fromEnvironment("API_KEY");
    const appId = String.fromEnvironment("APP_ID");
    const orgId = String.fromEnvironment("ORG_ID");
    const baseUrl = String.fromEnvironment("BASE_URL");
    const uri =
        "$baseUrl/products?organization_id=$orgId&reverse_sort=false&page=1&size=10&Appid=$appId&Apikey=$apiKey";

    try {
      final response = await client.get(Uri.parse(uri));
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      final items = decodedResponse['items'] as List<dynamic>;

      List<Product> responseData = [];
      for (Map<String, dynamic> item in items) {
        responseData.add(Product.fromJson(item));
      }
      return responseData;
    } on SocketException {
      throw const SocketException("Kindly Check Your Internet Access");
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
