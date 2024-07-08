// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  const Product({
    required this.amount,
    required this.imagePath,
    required this.marketName,
    required this.description,
    required this.isAvailable,
    required this.id,
  });
  final String imagePath, marketName;
  final String description;
  final bool isAvailable;
  final num amount;
  final String id;

  factory Product.fromJson(Map<String, dynamic> json) {
    const imageBasePath = "https://api.timbu.cloud/images";
    final imageJson = (json["photos"] as List<dynamic>).first;
    final priceJson =
        (json["current_price"] as List<dynamic>).first;
    return Product(
      id: json["id"],
      amount: priceJson["NGN"].first,
      isAvailable: json['is_available'],
      imagePath: "$imageBasePath/${imageJson["url"]}",
      marketName: json["name"],
      description: json["description"],
    );
  }

  static Product empty()=>const Product(amount: 0, imagePath: "", marketName: "", description: "", isAvailable: false, id: "");
}

