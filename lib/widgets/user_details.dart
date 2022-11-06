import 'package:flutter/material.dart';
import 'package:black_n_brown/constants/constants.dart';

class UserDetails extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData iconData;

  UserDetails({
    required this.title,
    required this.subTitle,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      padding: const EdgeInsets.only(left: 30, top: 10, right: 5),
      child: ListTile(
        leading: Icon(iconData, color: kPrimaryColor),
        title: Text(title, style: kTitleSmall.copyWith(color: Colors.white30)),
        subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(subTitle, style: kTitleSmall)),
      ),
    );
  }
}
