import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/cart.dart';

class CustomCartIcon extends StatelessWidget {
  const CustomCartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, provider, _) {
        var badgeText = provider.getCartItems.length;
        return badgeText <= 0
            ? const Icon(Icons.shopping_cart_sharp,
                size: 30, color: kTabIconColor)
            : Badge(
                badgeContent: Text(badgeText.toString()),
                padding: const EdgeInsets.all(4),
                child: const Icon(Icons.shopping_cart_sharp,
                    size: 30, color: kTabIconColor));
      },
    );
  }
}
