import 'package:flutter/material.dart';
import 'package:simple_shopping_app/models/product.dart';
import 'package:simple_shopping_app/notifier/cart_notifier.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Availables",
            style:  TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w400,
                fontSize: 24)),
      ),
      body: SafeArea(
        child: GridView(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 4, crossAxisCount: 2, childAspectRatio: .56),
          children: List.generate(
            products.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ProductCard(
                product: products[index],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  const ProductCard({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final screenHeight = MediaQuery.sizeOf(context).height;

    final cartNotifier = CartNotifier.instance;
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            product.imagePath,
            height: screenHeight * 0.24,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      product.marketName,
                      style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const Spacer(),
                    Text(product.weight)
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  product.source,
                  style:
                      const TextStyle(fontSize: 12, color: Colors.lightGreen),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      "\$${product.amount}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        cartNotifier.addToCart(product);
                        setState(() {});
                      },
                      child: Transform.flip(
                        flipX: true,
                        child: Icon(
                          cartNotifier.productsInCart.contains(product)
                              ? Icons.shopping_cart
                              : Icons.shopping_cart_outlined,
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
