import 'package:black_n_brown/constants/constants.dart';
import 'package:black_n_brown/providers/Items.dart';
import 'package:black_n_brown/providers/cart.dart';
import 'package:black_n_brown/providers/categories.dart';
import 'package:black_n_brown/providers/navbar_state_provider.dart';
import 'package:black_n_brown/providers/orders.dart';
import 'package:black_n_brown/providers/user.dart';
import 'package:black_n_brown/screens/credentials_screen.dart';
import 'package:black_n_brown/screens/item_details_screen.dart';
import 'package:black_n_brown/screens/tabs_screen.dart';
import 'package:black_n_brown/screens/user_profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.grey),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Items(),
        ),
        ChangeNotifierProvider(
          create: (_) => Categories(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavbarStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => User(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Black n Brown',
        theme: ThemeData(
          colorScheme:
              Theme.of(context).colorScheme.copyWith(primary: kPrimaryColor),
          canvasColor: Colors.white,
          fontFamily: 'Poppins-Medium',
        ),
        // home: AnimatedSplashScreen(
        //   splash: Image.asset('assets/images/black_n_brown_logo.png'),
        //   nextScreen: CredentialsScreen(),
        //   duration: 2000,
        // ),
        routes: {
          '/': (context) => CredentialsScreen(),
          TabsScreen.routeName: (context) => TabsScreen(),
          ItemDetailsScreen.routeName: (context) => ItemDetailsScreen(),
          UserProfileScreen.routeName: (context) => UserProfileScreen(),
          CredentialsScreen.routeName: (context) => CredentialsScreen(),
        },
      ),
    );
  }
}
