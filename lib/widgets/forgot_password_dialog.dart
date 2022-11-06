import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'custom_button.dart';

class ForgotPasswordDialog {
  void show(
      BuildContext context, String title, TextEditingController controller) {
    final size = MediaQuery.of(context).size;
    String? errorText;
    bool isClicked = false;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              backgroundColor: kOrderHistoryContainerColor,
              child: SizedBox(
                width: size.width * 0.8,
                height: size.height * 0.3,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: kPrimaryColor),
                  ),
                  child: ValueListenableBuilder(
                    valueListenable: controller,
                    builder: (context, value, _) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: kTitleSmall.copyWith(color: kOrange),
                          ),
                          TextField(
                            style: kTitleSmall.copyWith(color: kPrimaryColor),
                            decoration: InputDecoration(
                              hintText: 'Enter email address',
                              errorText: errorText,
                              hintStyle: kTitleSmall.copyWith(),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                            ),
                            autofocus: true,
                            keyboardType: TextInputType.emailAddress,
                            controller: controller,
                            onChanged: (text) {
                              if (isClicked) {
                                setState(() {
                                  errorText =
                                      getErrorText(controller.value.text);
                                });
                              }
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 30,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    controller.text = '';
                                  },
                                  child: const Text('Cancel'),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.grey),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 30,
                                child: CustomButton(
                                  label: 'Reset',
                                  add: () async {
                                    isClicked = true;
                                    errorText =
                                        getErrorText(controller.value.text);
                                    if (errorText != null) {
                                      setState(() {});
                                      return;
                                    }
                                    try {
                                      await FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                              email: controller.text.trim());
                                      Navigator.of(context).pop();
                                      controller.text = '';
                                    } on FirebaseAuthException catch (exception) {
                                      print(exception.toString());
                                      Navigator.of(context).pop();
                                      controller.text = '';
                                    } catch (exception) {
                                      print(exception.toString());
                                      Navigator.of(context).pop();
                                      controller.text = '';
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            );
          });
        });
  }

  String? getErrorText(String email) {
    if (email.isEmpty) {
      return 'Please provider email';
    } else if (!email.endsWith('@gmail.com')) {
      return 'Invalid email';
    }
    return null;
  }
}
