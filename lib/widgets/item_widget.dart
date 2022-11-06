import 'package:black_n_brown/constants/constants.dart';
import 'package:black_n_brown/models/Item.dart';
import 'package:black_n_brown/screens/item_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentItem = Provider.of<Item>(context, listen: false);
    return InkWell(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: kContainerBorderColor, width: 2),
            ),
            child: ClipRRect(
              child: Image.asset(
                currentItem.imagePath,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          Positioned(
            bottom: 6,
            right: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.90),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Text(
                '${currentItem.title}\nPrice :  ${currentItem.prices.values.first.values.first.toStringAsFixed(0)}',
                softWrap: true,
                textAlign: TextAlign.start,
                style: kTitleSmall.copyWith(color: Colors.black, fontSize: 11),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          ItemDetailsScreen.routeName,
          arguments: currentItem.id,
        );
      },
    );
  }
}
