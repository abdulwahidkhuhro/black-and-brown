import 'dart:async';
import 'dart:ui';
import 'package:black_n_brown/screens/tabs_screen.dart';
import 'package:black_n_brown/widgets/custom_button.dart';
import 'package:black_n_brown/widgets/forgot_password_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../utils/utils.dart';

class CredentialsScreen extends StatefulWidget {
  static const String routeName = 'credentials-screen';
  @override
  State<CredentialsScreen> createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _userNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _contactNoFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _createAccount = false;
  var _submitted = false;
  var _showPassword = false;
  String _username = '';
  String _email = '';
  String _contactNo = '';
  String _password = '';
  var _forgotPasswordEmailController = TextEditingController();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _userNameFocusNode.addListener(_updateLabelTextColor);
    _emailFocusNode.addListener(_updateLabelTextColor);
    _contactNoFocusNode.addListener(_updateLabelTextColor);
    _passwordFocusNode.addListener(_updateLabelTextColor);
    super.initState();
  }

  @override
  void dispose() {
    _userNameFocusNode.removeListener(_updateLabelTextColor);
    _emailFocusNode.removeListener(_updateLabelTextColor);
    _contactNoFocusNode.removeListener(_updateLabelTextColor);
    _passwordFocusNode.removeListener(_updateLabelTextColor);
    _userNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _contactNoFocusNode.dispose();
    _passwordFocusNode.dispose();
    _forgotPasswordEmailController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          // color: Colors.grey,
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 85),
          child: Column(
            children: [
              const SizedBox(height: 30),
              Image.asset('assets/images/black_n_brown_logo.png'),
              // const SizedBox(height: 60),
              Expanded(
                child: Form(
                  autovalidateMode: _submitted
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  key: _form,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 60),
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          const SizedBox(height: 30),
                          if (_createAccount)
                            TextFormField(
                              style: kTitleSmall.copyWith(color: kPrimaryColor),
                              decoration: InputDecoration(
                                hintText: 'Username',
                                hintStyle: kTitleSmall.copyWith(
                                  color: _userNameFocusNode.hasFocus
                                      ? kPrimaryColor
                                      : kWhite,
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: kPrimaryColor),
                                ),
                              ),
                              focusNode: _userNameFocusNode,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.name,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context).requestFocus(
                                    _createAccount
                                        ? _emailFocusNode
                                        : _passwordFocusNode);
                              },
                              onSaved: (userName) {
                                if (userName == null) return;
                                _username = userName;
                              },
                              validator: (userName) {
                                if (userName == null || userName.isEmpty) {
                                  return 'Please provide username';
                                } else if (userName.length <= 2) {
                                  return 'Too short, can be b/w 2 to 7 characters';
                                } else if (userName.length >= 7) {
                                  return 'Too long, can be b/w 2 to 7 characters';
                                }
                                return null;
                              },
                            ),
                          const SizedBox(height: 18),
                          TextFormField(
                            style: kTitleSmall.copyWith(
                              color: kPrimaryColor,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: kTitleSmall.copyWith(
                                color: _emailFocusNode.hasFocus
                                    ? kPrimaryColor
                                    : kWhite,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                            focusNode: _emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(
                                _createAccount
                                    ? _contactNoFocusNode
                                    : _passwordFocusNode,
                              );
                            },
                            onSaved: (email) {
                              if (email == null) return;
                              _email = email;
                            },
                            validator: (email) {
                              if (email == null || email.isEmpty) {
                                return 'Please provide email address';
                              } else if (!email.endsWith('@gmail.com')) {
                                return 'Badly formatted';
                              }
                              return null;
                            },
                          ),
                          if (_createAccount)
                            Column(
                              children: [
                                const SizedBox(height: 18),
                                TextFormField(
                                  style: kTitleSmall.copyWith(
                                      color: kPrimaryColor),
                                  decoration: InputDecoration(
                                    hintText: 'Contact No.',
                                    hintStyle: kTitleSmall.copyWith(
                                      color: _contactNoFocusNode.hasFocus
                                          ? kPrimaryColor
                                          : kWhite,
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.phone,
                                  textInputAction: TextInputAction.next,
                                  focusNode: _contactNoFocusNode,
                                  onFieldSubmitted: (_) {
                                    _scrollController.animateTo(40,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeIn);
                                    FocusScope.of(context)
                                        .requestFocus(_passwordFocusNode);
                                  },
                                  onSaved: (number) {
                                    if (number == null) return;
                                    _contactNo = number;
                                  },
                                  validator: (number) {
                                    if (number == null || number.isEmpty) {
                                      return 'Please provide contact no';
                                    } else if (!number.startsWith('+92')) {
                                      return 'Number format should be +92...';
                                    } else if (number.length < 13 ||
                                        number.length > 13) {
                                      return 'Invalid Number';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          const SizedBox(height: 18),
                          TextFormField(
                            style: kTitleSmall.copyWith(color: kPrimaryColor),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: kTitleSmall.copyWith(
                                color: _passwordFocusNode.hasFocus
                                    ? kPrimaryColor
                                    : kWhite,
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: kPrimaryColor,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: _showPassword
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                                color: kPrimaryColor,
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: !_showPassword,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            focusNode: _passwordFocusNode,
                            onTap: () {
                              _scrollController.animateTo(120,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            },
                            onSaved: (password) {
                              if (password == null) return;
                              _password = password;
                            },
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return 'Please provide password';
                              } else if (password.length <= 5) {
                                return 'Too short, type at least 6 character';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          if (!_createAccount)
                            Container(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                child: Text(
                                  'Forgot password',
                                  textAlign: TextAlign.right,
                                  style:
                                      kTitleSmall.copyWith(color: Colors.red),
                                ),
                                onTap: () {
                                  ForgotPasswordDialog().show(
                                    context,
                                    'Please enter your email to reset password',
                                    _forgotPasswordEmailController,
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 60),

                          // const SizedBox(height: 16),
                          // const Text(
                          //   'OR',
                          //   style: kTitleSmall,
                          // ),
                          // const SizedBox(height: 26),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 20),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     children: [
                          //       Container(
                          //         decoration: const BoxDecoration(
                          //           color: kWhite,
                          //           image: DecorationImage(
                          //             image: AssetImage('images/facebook.png'),
                          //             fit: BoxFit.fill,
                          //           ),
                          //           shape: BoxShape.circle,
                          //         ),
                          //         width: 30,
                          //         height: 30,
                          //       ),
                          //       Container(
                          //         decoration: const BoxDecoration(
                          //           color: kWhite,
                          //           image: DecorationImage(
                          //             image: AssetImage('images/google.png'),
                          //             fit: BoxFit.fill,
                          //           ),
                          //           shape: BoxShape.circle,
                          //         ),
                          //         width: 30,
                          //         height: 30,
                          //       ),
                          //       Container(
                          //         decoration: const BoxDecoration(
                          //           color: kWhite,
                          //           image: DecorationImage(
                          //             image: AssetImage('images/guest.png'),
                          //             fit: BoxFit.contain,
                          //           ),
                          //           shape: BoxShape.circle,
                          //         ),
                          //         width: 30,
                          //         height: 30,
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: GestureDetector(
                  child: Text(
                    !_createAccount
                        ? 'Create Account'
                        : 'Already have an account ?',
                    style: kTitleSmall.copyWith(color: kOrange),
                  ),
                  onTap: () {
                    setState(() {
                      _submitted = false;
                      _emailFocusNode.unfocus();
                      _passwordFocusNode.unfocus();
                      if (!_createAccount) {
                        _createAccount = true;
                      } else {
                        _createAccount = false;
                      }
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: CustomButton(
                  label: _createAccount ? 'Register' : 'Login',
                  add: _createAccount ? _createNewUser : _loginUser,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loginUser() async {
    if (_saveForm()) {
      try {
        final user = await _auth
            .signInWithEmailAndPassword(email: _email, password: _password)
            .timeout(const Duration(seconds: 5), onTimeout: () {
          throw Exception('Slow internet connection, try again later');
        });
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName,
            arguments: user.user?.uid.toString());
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(context, e.message.toString(), 2000);
      } catch (e) {
        String errorMessage = e.toString().split(':').last.trim();
        Utils.showSnackBar(context, errorMessage, 2000);
      }
    }
  }

  Future<void> _createNewUser() async {
    if (_saveForm()) {
      try {
        final response = await _auth
            .createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        )
            .timeout(const Duration(seconds: 5), onTimeout: () {
          throw Exception('Slow internet connection, try again later');
        });
        // add user data to firestore
        await _firestore.collection('users').doc(response.user!.uid).set({
          'userName': _username,
          'email': _email,
          'phone': _contactNo,
        });
        Navigator.of(context).pushReplacementNamed(TabsScreen.routeName,
            arguments: response.user!.uid.toString());
      } on FirebaseAuthException catch (e) {
        Utils.showSnackBar(context, e.message.toString(), 2000);
      } catch (e) {
        String errorMessage = e.toString().split(':').last.trim();
        Utils.showSnackBar(context, errorMessage, 2000);
      }
    }
  }

  bool _saveForm() {
    setState(() {
      _submitted = true;
    });
    final isValid = _form.currentState
        ?.validate(); // calls onValidate method of each textFormField
    if (!isValid!) return false;
    _form.currentState?.save(); // calls onSaved method of each textFormField
    return true;
  }

  void _updateLabelTextColor() {
    setState(() {});
  }
}
