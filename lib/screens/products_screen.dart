import 'package:flutter/material.dart';
import 'package:simple_shopping_app/models/product.dart';
import 'package:simple_shopping_app/notifier/cart_notifier.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool isLoading = false;
  void fetch() async {
    setState(() {
      isLoading = true;
    });

    await CartNotifier.instance.getProductsFromTimbu();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      fetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartNotifier.instance;
    final errorOccured = cartNotifier.timbuResponse.errorMessage != null;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Availables")),
      body: SafeArea(
        child: cartNotifier.timbuResponse.isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Visibility(
                visible: errorOccured,
                replacement: SingleChildScrollView(
                  child: Column(children: [
                    ...List.generate(
                      cartNotifier.timbuResponse.products?.length ?? 1,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: ProductTile(
                          product:
                              cartNotifier.timbuResponse.products?[index] ??
                                  Product.empty(),
                        ),
                      ),
                    ),
                  ]),
                ),
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Error Occurred:\n${cartNotifier.timbuResponse.errorMessage}",
                      style: TextStyle(color: Colors.red.shade500),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: fetch,
                      child: const Text(
                        "R E T R Y",
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ))),
      ),
    );
  }
}

class ProductTile extends StatefulWidget {
  const ProductTile({
    required this.product,
    super.key,
  });
  final Product product;

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                    product.imagePath,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) =>
                            child,
                    loadingBuilder: (context, child, loadingProgress) {
                      return loadingProgress == null
                          ? child
                          : const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(),
                            );
                    },
                    height: screenHeight * .2,
                  ),
                ),
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
                    Text(product.isAvailable ? "In Stock" : "Out of Stock")
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  product.description,
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
                          cartNotifier.productsInCart
                                  .where((element) => element.id == product.id)
                                  .isNotEmpty
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
