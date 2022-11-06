import 'package:black_n_brown/constants/constants.dart';
import 'package:black_n_brown/providers/cart.dart';
import 'package:black_n_brown/providers/navbar_state_provider.dart';
import 'package:black_n_brown/providers/orders.dart';
import 'package:black_n_brown/widgets/cart_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../models/cartItem.dart';
import '../widgets/custom_button.dart';
import '../widgets/screen_header.dart';
import '../widgets/custom_success_dialog.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // late Future _myFuture;

  @override
  void initState() {
    // _myFuture = Provider.of<Cart>(context, listen: false).fetchAndSetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final cart = Provider.of<Cart>(context);
    List<CartItem> cartItems = cart.getCartItems;
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.03),
            ScreenHeader(
              size: size,
              title: 'Your Cart',
            ),
            SizedBox(height: size.height * 0.001),
            // FutureBuilder(
            //   future: _myFuture,
            //   builder: (context, result) {
            //     if (result.connectionState == ConnectionState.done) {
            //       return
            Expanded(
              child: cartItems.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.asset(
                                  'assets/images/no_cart_items_image.png')),
                          const SizedBox(height: 30),
                          RichText(
                            text: const TextSpan(
                              style: kTitleMedium,
                              text: 'Your cart is empty',
                            ),
                          ),
                          SizedBox(
                            width: 230,
                            child: GestureDetector(
                              child: RichText(
                                text: TextSpan(
                                  style: kTitleMedium,
                                  children: [
                                    const TextSpan(text: 'currently,  '),
                                    TextSpan(
                                      text: 'Add something ?',
                                      style: kTitleMedium.copyWith(
                                          color: kPrimaryColor),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Provider.of<NavbarStateProvider>(context,
                                        listen: false)
                                    .changeState(1);
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: Column(
                          children: [
                            SizedBox(height: size.height * 0.07),
                            ...cartItems.map((cartItem) {
                              return CartItemWidget(cartItem: cartItem);
                            }).toList(),
                            const SizedBox(height: 45),
                          ],
                        ),
                      ),
                    ),
            ),
            // }
            //     if (result.hasError) {
            //       print('error : ${result.error.toString()}');
            //       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //         _showSnackBar(result.error.toString());
            //       });
            //       return Container();
            //     }
            //     if (result.connectionState == ConnectionState.waiting) {
            //       return const Expanded(
            //         child: Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       );
            //     }
            //     return Container(color: Colors.transparent);
            //   },
            // )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: CustomButton(
            label: 'Order Now',
            add: cartItems.isEmpty
                ? () async {}
                : () async {
                    try {
                      await Provider.of<Orders>(context, listen: false)
                          .addOrder(
                        cartItems,
                        cart.totalAmount,
                      );
                      await cart.clearCart();
                      CustomSuccessDialog().show(context);
                    } on FirebaseException catch (exception) {
                      print(exception.message.toString());
                      // _showSnackBar(exception.message.toString());
                    } catch (exception) {
                      print(exception.toString().split(':').last.trim());
                      // _showSnackBar(
                      //     exception.toString().split(':').last.trim());
                    }
                  },
          ),
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      padding: const EdgeInsets.only(bottom: 20),
      content: Text(message),
      duration: const Duration(seconds: 2),
      backgroundColor: kPrimaryColor.withOpacity(0.5),
    ));
  }
}
