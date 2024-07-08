import 'package:flutter/material.dart';
import 'package:simple_shopping_app/models/product.dart';
import 'package:simple_shopping_app/notifier/cart_notifier.dart';
import 'package:simple_shopping_app/screens/order_successful_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartNotifier.instance;
    final cartIsEmpty = cartNotifier.productsInCart.isEmpty;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Carted Smokes",
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.w400,
                fontSize: 24)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: cartIsEmpty
            ? const Center(
                child: Text("Cart is currently empty"),
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.64,
                    child: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(
                        cartNotifier.productsInCart.length,
                        (index) => CheckoutTile(
                          onRemoved: () {
                            cartNotifier.removeFromCart(
                              cartNotifier.productsInCart[index],
                            );

                            setState(() {});
                          },
                          product: cartNotifier.productsInCart[index],
                        ),
                      ),
                    )),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Text(
                        "Total Price",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        "\$${cartNotifier.getTotalAmountInCart()}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderSuccessfulScreen(),
                          ));
                    },
                    child: const Text("Purchase"),
                  )
                ],
              ),
      )),
    );
  }
}

class CheckoutTile extends StatelessWidget {
  const CheckoutTile({
    required this.product,
    required this.onRemoved,
    super.key,
  });
  final Product product;
  final VoidCallback onRemoved;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Image.network(
            product.imagePath,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
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
          Row(mainAxisSize: MainAxisSize.min, children: [
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.marketName,
                    style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(product.description),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "\$${product.amount}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: onRemoved,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                )
              ],
            )
          ]),
          const Divider()
        ],
      ),
    );
  }
}
