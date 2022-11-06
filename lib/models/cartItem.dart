import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  final String parsedSize;
  final String imagePath;
  final DateTime dateTime;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
    required this.parsedSize,
    required this.imagePath,
    required this.dateTime,
  });

  // void setPrice(double price) {
  //   this.price = price;
  // }
}
