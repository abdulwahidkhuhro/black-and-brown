import 'package:black_n_brown/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'custom_button.dart';

class CustomSuccessDialog {
  void show(BuildContext context) {
    final size = MediaQuery.of(context).size;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: kOrderHistoryContainerColor,
            child: SizedBox(
              width: size.width * 0.8,
              height: size.height * 0.6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: kPrimaryColor),
                ),
                child: Column(
                  children: [
                    // const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: Image.asset(
                                'assets/images/order_success_icon.png')),
                        SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: Lottie.asset(
                            'assets/anims/order_success_anim.json',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Order Submitted Successfully.',
                      textAlign: TextAlign.center,
                      style: kTitleMedium,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'It will take 30-40 mins to deliver it to you.',
                      textAlign: TextAlign.center,
                      style: kTitleSmall.copyWith(color: Colors.white38),
                    ),
                    Expanded(
                      child: CustomButton(
                          label: 'Dismiss',
                          add: () async {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
