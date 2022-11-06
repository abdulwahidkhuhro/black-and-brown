import 'package:black_n_brown/constants/dummy_data.dart';
import 'package:flutter/material.dart';
import '../models/category.dart';

class Categories with ChangeNotifier {
  final List<Category> _categories = CATEGORIES;

  List<Category> get getAllCategories {
    return [..._categories];
  }
}
