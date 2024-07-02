// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  const Product({
    required this.amount,
    required this.weight,
    required this.imagePath,
    required this.marketName,
    required this.source,
  });
  final String imagePath, marketName;
  final String source, weight;
  final num amount;

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.marketName == marketName &&
      other.weight == weight &&
      other.amount == amount;
  }

  @override
  int get hashCode => marketName.hashCode ^ weight.hashCode ^ amount.hashCode;
}
