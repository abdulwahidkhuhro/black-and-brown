import 'package:black_n_brown/constants/constants.dart';
import 'package:black_n_brown/models/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  OrderItem({required this.order});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 10),
      curve: Curves.easeIn,
      padding: const EdgeInsets.only(top: 12, bottom: 8, left: 20, right: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: kOrderHistoryContainerColor.withOpacity(0.58),
        border: Border(
          top: BorderSide(color: kContainerBorderColor, width: 2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('EEEE  d-MM-yy  [H:mm a]')
                .format(order.dateTime)
                .toString(),
            style: kTitleMedium.copyWith(fontSize: 17, color: kOrange),
          ),
          const SizedBox(height: 10),
          Text(
            'Total Amount :  ${order.totalAmount.toStringAsFixed(0)} rps.',
            style: kTitleSmall,
          ),
          Text(
            'Total Items :  ${order.cartItems.length}x',
            style: kTitleSmall,
          ),
          ShowMoreDetails(order: order),
        ],
      ),
    );
  }
}

class ShowMoreDetails extends StatefulWidget {
  final Order order;
  ShowMoreDetails({required this.order});

  @override
  State<ShowMoreDetails> createState() => _ShowMoreDetailsState();
}

class _ShowMoreDetailsState extends State<ShowMoreDetails> {
  var _isShowMore = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!_isShowMore)
          showMoreButton('Show More', Icons.keyboard_arrow_down_sharp),
        if (_isShowMore)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              ...widget.order.cartItems.map((cartItem) => Text(
                    '${cartItem.title} : ${cartItem.price.toStringAsFixed(0)} rps.  ${cartItem.quantity}x',
                    style: kTitleSmall,
                  )),
              if (_isShowMore)
                showMoreButton('Show Less', Icons.keyboard_arrow_up_sharp),
            ],
          ),
      ],
    );
  }

  Widget showMoreButton(String label, IconData iconData) {
    return InkWell(
      onTap: () {
        setState(() {
          _isShowMore = !_isShowMore;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: kPrimaryColor),
          ),
          Icon(iconData, color: kPrimaryColor),
        ],
      ),
    );
  }
}
