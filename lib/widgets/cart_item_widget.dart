import 'package:black_n_brown/models/Item.dart';
import 'package:black_n_brown/models/cartItem.dart';
import 'package:black_n_brown/providers/Items.dart';
import 'package:flutter/material.dart';
import 'package:black_n_brown/constants/constants.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  CartItem cartItem;

  CartItemWidget({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: kPrimaryColor, width: 1),
          ),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kContainerBorderColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Image.asset(
                    getItemImagePath(context, cartItem.title),
                    fit: BoxFit.fill,
                    width: 70,
                    height: 88,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(cartItem.title, style: kTitleSmall),
                  Text(
                      'Quantity: ${cartItem.quantity}x   ${cartItem.parsedSize}',
                      style: kTitleSmall),
                  Text(cartItem.price.toString(), style: kTitleSmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getItemImagePath(BuildContext context, String itemTitle) {
    return Provider.of<Items>(context, listen: false)
        .getItemImagePath(itemTitle);
  }
}
