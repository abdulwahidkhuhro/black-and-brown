import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import '../constants/constants.dart';

class ScreenHeader extends StatelessWidget {
  final Size size;
  final String title;

  ScreenHeader({required this.size, required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.122,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: kPrimaryColor, width: 2),
                  bottom: BorderSide(color: kPrimaryColor, width: 2),
                ),
              ),
              child: BlurryContainer(
                width: double.infinity,
                height: size.height * 0.08,
                borderRadius: BorderRadius.zero,
                bgColor: const Color(0xff4F4F4F),
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    title,
                    style: kTitleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'assets/images/black_n_brown_logo.png',
              alignment: Alignment.center,
              width: 50,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
