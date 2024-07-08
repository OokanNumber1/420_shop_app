import 'package:flutter/material.dart';
import 'package:simple_shopping_app/notifier/cart_notifier.dart';
import 'package:simple_shopping_app/screens/checkout_screen.dart';
import 'package:simple_shopping_app/screens/products_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final screens = const [ProductsScreen(), CheckoutScreen()];
  int pageIndex = 0;

  final notifier = CartNotifier.instance;

  @override
  void initState() {
    notifier.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: screens[pageIndex]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (newIndex) => setState(() => pageIndex = newIndex),
          items: List.generate(
            2,
            (index) => BottomNavigationBarItem(
                activeIcon: Icon(
                  index == 0
                      ? Icons.grid_view_rounded
                      : Icons.shopping_cart_rounded,
                ),
                icon: Icon(index == 0
                    ? Icons.grid_view_outlined
                    : Icons.shopping_cart_outlined),
                label: index == 0 ? "Products" : "Checkout"),
          )),
    );
  }
}
