import 'dart:ffi';
import 'dart:ui';
import 'package:black_n_brown/screens/credentials_screen.dart';
import 'package:black_n_brown/widgets/custom_button.dart';
import 'package:black_n_brown/widgets/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:black_n_brown/constants/constants.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:provider/provider.dart';
import 'credentials_screen.dart';
import 'package:black_n_brown/providers/user.dart' as userProvider;

class UserProfileScreen extends StatelessWidget {
  static const routeName = 'user-profile-screen';
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final currentUser = Provider.of<userProvider.User>(context).getCurrentUser;
    return Scaffold(
      backgroundColor: kWhite,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: ExactAssetImage('assets/images/home_background.png'),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.50,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.height * 0.46,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                        child: Image.asset(
                          'assets/images/user_sample_image.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: kContainerBorderColor.withAlpha(255),
                              width: 2),
                        ),
                        child: BlurryContainer(
                          width: size.width * 0.6,
                          height: size.height * 0.06,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 6),
                          borderRadius: BorderRadius.circular(10),
                          bgColor: kSecondaryColor,
                          child: Text(
                            currentUser.userName,
                            textAlign: TextAlign.center,
                            style: kTitleLarge,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              UserDetails(
                title: 'Email Address',
                subTitle: currentUser.email,
                iconData: Icons.email,
              ),
              UserDetails(
                title: 'Phone Number',
                subTitle: currentUser.phone,
                iconData: Icons.phone,
              ),
              SizedBox(height: size.height * 0.08),
              CustomButton(
                  label: 'Log Out',
                  add: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                        context, CredentialsScreen.routeName, (r) => false);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
