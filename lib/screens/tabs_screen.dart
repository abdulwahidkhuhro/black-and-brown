import 'dart:convert';

import 'package:black_n_brown/providers/cart.dart';
import 'package:black_n_brown/screens/cart_screen.dart';
import 'package:black_n_brown/screens/home_screen.dart';
import 'package:black_n_brown/screens/orders_screen.dart';
import 'package:black_n_brown/widgets/custom_cart_icon.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../providers/navbar_state_provider.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../providers/orders.dart';
import '../providers/user.dart' as userProvider;

class TabsScreen extends StatefulWidget {
  static const routeName = 'tabs-screen';
  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final _firestore = FirebaseFirestore.instance;
  late String _userId;
  late Future _cartFuture;
  late Future _ordersFuture;
  late Future<DocumentSnapshot<Map<String, dynamic>>> _userFuture;
  var _didChangeDependenciesCalled = false;
  late var _stateProvider;

  final _screens = [
    CartScreen(),
    HomeScreen(),
    OrdersScreen(),
  ];

  final _screenIcons = [
    const CustomCartIcon(),
    const Icon(Icons.home, size: 30, color: kTabIconColor),
    const Icon(Icons.location_history_rounded, size: 30, color: kTabIconColor),
  ];

  @override
  void initState() {
    _cartFuture = Provider.of<Cart>(context, listen: false).fetchAndSetData();
    _ordersFuture =
        Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_didChangeDependenciesCalled) {
      return;
    }
    _userId = ModalRoute.of(context)?.settings.arguments as String;
    _userFuture = _firestore.collection('users').doc(_userId).get();
    _stateProvider = Provider.of<NavbarStateProvider>(context);
    _didChangeDependenciesCalled = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: kPrimaryColor,
        height: 60,
        color: kBottomNavColor,
        backgroundColor: Colors.transparent,
        index: _stateProvider.getIndex,
        items: _screenIcons,
        onTap: (index) => _stateProvider.changeState(index),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: ExactAssetImage('assets/images/home_background.png'),
            ),
          ),
          child: FutureBuilder(
            future: Future.wait([
              _userFuture,
              _ordersFuture,
              _cartFuture,
              Future(() async {
                await Future.delayed(Duration(milliseconds: 400));
              })
            ]),
            builder:
                (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: kPrimaryColor));
              }
              if (snapshot.hasError) {
                return const Center(
                    child: Text('Something went wrong, try again later.',
                        style: kTitleMedium));
              }
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                final user = snapshot.data![0].data() as Map<String, dynamic>;
                if (user == null) {
                  return const Center(
                      child: Text("User does not exist", style: kTitleMedium));
                }
              }
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> user =
                    snapshot.data![0].data() as Map<String, dynamic>;
                Provider.of<userProvider.User>(context, listen: false).setUser(
                    _userId, user['userName'], user['email'], user['phone']);
                // return Consumer<NavbarStateProvider>(
                //   builder: (context, provider, _) {
                return _screens[_stateProvider.getIndex];
                // },
                // );
              }
              return const Center(
                  child: CircularProgressIndicator(color: kPrimaryColor));
            },
          ),
        ),
      ),
    );
  }
}
