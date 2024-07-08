import 'package:flutter/material.dart';
import 'package:simple_shopping_app/notifier/cart_notifier.dart';
import 'package:simple_shopping_app/screens/dashboard_screen.dart';

class OrderSuccessfulScreen extends StatelessWidget {
  const OrderSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartNotifier.instance;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: CircleAvatar(radius: 24, child: Icon(Icons.check)),
            ),
            const SizedBox(height: 16),
            const Text(
              "Purchase Summary",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.52,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(cartNotifier.productsInCart.length,
                      (index) {
                    final product = cartNotifier.productsInCart[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "${product.marketName} (${product.isAvailable})"),
                              Text("\$${product.amount}")
                            ],
                          ),
                          const SizedBox(height: 4),
                          const Divider()
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "T O T A L",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  "\$${cartNotifier.getTotalAmountInCart()}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: OutlinedButton(
                  onPressed: () {
                    cartNotifier.invalidateCart();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DashboardScreen(),
                      ),
                    );
                  },
                  child: const Text("Get More Smoke")),
            )
          ],
        ),
      )),
    );
  }
}
