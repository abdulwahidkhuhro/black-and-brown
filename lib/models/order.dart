import 'package:black_n_brown/models/cartItem.dart';

class Order {
  final String orderId;
  final double totalAmount;
  final List<CartItem> cartItems;
  final DateTime dateTime;

  Order({
    required this.orderId,
    required this.totalAmount,
    required this.cartItems,
    required this.dateTime,
  });
}
