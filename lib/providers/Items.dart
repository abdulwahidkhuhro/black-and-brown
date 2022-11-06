import 'package:black_n_brown/constants/dummy_data.dart';
import 'package:black_n_brown/models/Item.dart';
import 'package:flutter/material.dart';

class Items with ChangeNotifier {
  final List<Item> _items = ITEMS;

  List<Item> get getAllItems {
    return [..._items];
  }

  String getItemImagePath(String itemTitle) {
    return _items.firstWhere((item) => item.title == itemTitle).imagePath;
  }

  List<Item> getItemsByCategoryId(String categoryId) {
    print(categoryId);
    return _items.where((item) => item.itemCategory == categoryId).toList();
  }

  Item getItemById(String itemId) {
    return _items.firstWhere((item) => item.id == itemId);
  }
}
