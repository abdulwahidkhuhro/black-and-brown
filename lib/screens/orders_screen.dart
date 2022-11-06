import 'package:black_n_brown/providers/orders.dart';
import 'package:black_n_brown/widgets/order_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/navbar_state_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/screen_header.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  // late Future _myFuture;

  @override
  void initState() {
    // _myFuture = Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final orders = Provider.of<Orders>(context);
    final isOrdersEmpty = orders.getOrderItems.isEmpty;
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.03),
            ScreenHeader(
              size: size,
              title: 'Your History',
            ),
            SizedBox(height: size.height * 0.001),
            // FutureBuilder(
            //   future: _myFuture,
            //   builder: (context, result) {
            //     if (result.connectionState == ConnectionState.done) {
            //       return
            Expanded(
              child: isOrdersEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 80),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          SizedBox(
                              width: 200,
                              height: 200,
                              child: Image.asset(
                                  'assets/images/no_orders_image.png')),
                          const SizedBox(height: 40),
                          // RichText(
                          //   text: const TextSpan(
                          //     style: kTitleMedium,
                          //     text: 'Your cart is empty',
                          //   ),
                          // ),
                          SizedBox(
                            width: 240,
                            child: GestureDetector(
                              child: RichText(
                                text: TextSpan(
                                  style: kTitleMedium,
                                  children: [
                                    const TextSpan(
                                        text:
                                            'You haven\'t made any orders yet,  '),
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
                        child: Consumer<Orders>(
                          builder: (context, orderData, child) => Column(
                            children: [
                              SizedBox(height: size.height * 0.07),
                              ...orderData.getOrderItems
                                  .map(
                                    (order) => OrderItem(order: order),
                                  )
                                  .toList()
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
            // }
            // if (result.hasError) {
            //   print(result.error.toString());
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            // _showSnackBar(result.error.toString());
            // });
            // return Container();
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
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: CustomButton(
            label: 'Clear History',
            add: isOrdersEmpty
                ? () async {}
                : () async {
                    try {
                      await orders.clearHistory();
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
}
