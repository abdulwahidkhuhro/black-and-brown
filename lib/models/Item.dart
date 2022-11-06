import 'package:flutter/cupertino.dart';

// enum
enum Size {
  OnePound,
  TwoPound,
  Quarter,
  HalfKg,
  ThreeQuarter,
  OneKg,
  None,
  Small,
  Medium,
  Large,
}

class Item with ChangeNotifier {
  String id;
  String title;
  String itemCategory;
  String description;
  Map<Size, Map<String, double>> prices;
  String imagePath;

  Item({
    required this.id,
    required this.title,
    required this.itemCategory,
    required this.description,
    required this.prices,
    required this.imagePath,
  });
}
