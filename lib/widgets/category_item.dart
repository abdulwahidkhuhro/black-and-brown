import 'package:black_n_brown/constants/constants.dart';
import 'package:black_n_brown/models/category.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatefulWidget {
  final Category category;
  final String selectedCategoryId;

  CategoryItem({required this.category, required this.selectedCategoryId});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.22,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      margin: const EdgeInsets.only(right: 40, bottom: 2),
      decoration: BoxDecoration(
        color: widget.selectedCategoryId == widget.category.id
            ? kSelectedContainerColor
            : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: widget.selectedCategoryId == widget.category.id
              ? kPrimaryColor
              : Colors.transparent,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: widget.selectedCategoryId == widget.category.id
                ? kPrimaryColor.withOpacity(0.5)
                : Colors.transparent,
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            widget.selectedCategoryId == widget.category.id
                ? widget.category.selectedImagePath
                : widget.category.imagePath,
          ),
          const SizedBox(height: 6),
          Text(
            widget.category.name,
            style: kTitleSmall,
          ),
        ],
      ),
    );
  }
}
