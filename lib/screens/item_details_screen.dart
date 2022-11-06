import 'package:black_n_brown/models/Item.dart';
import 'package:black_n_brown/providers/Items.dart';
import 'package:black_n_brown/providers/cart.dart';
import 'package:black_n_brown/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/provider.dart';
import 'package:black_n_brown/providers/user.dart' as currentUser;
import '../constants/constants.dart';
import '../models/cartItem.dart';
import '../utils/utils.dart';

class ItemDetailsScreen extends StatelessWidget {
  static const routeName = 'item-details-screen';

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedItem =
        Provider.of<Items>(context, listen: false).getItemById(itemId);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          // height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: ExactAssetImage('assets/images/home_background.png'),
            ),
          ),
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kPrimaryColor),
                        shape: BoxShape.rectangle,
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        child: Carousel(
                          dotSize: 8,
                          dotSpacing: 20,
                          dotBgColor: Colors.transparent,
                          dotIncreasedColor: kPrimaryColor,
                          dotPosition: DotPosition.topCenter,
                          dotVerticalPadding: 50,
                          animationCurve: Curves.ease,
                          images: [
                            Image.asset(
                              loadedItem.imagePath,
                              fit: BoxFit.fill,
                            ),
                            Image.asset(
                              loadedItem.imagePath,
                              fit: BoxFit.fill,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30),
                    child: Text(
                      loadedItem.title,
                      style: kTitleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20, right: 5),
                    child: SizedBox(
                      height:
                          loadedItem.prices.keys.first == Size.None ? 100 : 80,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          loadedItem.description,
                          overflow: TextOverflow.fade,
                          style: kTitleSmall.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ),
                  ItemDetails(itemId: itemId),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ItemDetails extends StatefulWidget {
  late final itemId;

  ItemDetails({required this.itemId});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  Size? _itemSize;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final loadedItem =
        Provider.of<Items>(context, listen: false).getItemById(widget.itemId);
    List<Size> itemSizes = [];
    List<String> itemSizeLabels = [];
    List<double> itemPrices = [];
    loadedItem.prices.forEach((key, value) {
      itemSizes.add(key);
      value.forEach((key, value) {
        itemSizeLabels.add(key);
        itemPrices.add(value);
      });
    });
    _itemSize ??= itemSizes[0];
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (loadedItem.prices.keys.first != Size.None)
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 33),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * 0.16,
                    child: const Text('Size :', style: kTitleMedium),
                  ),
                  Container(
                    width: size.width * 0.84 - 20,
                    height: 38,
                    // alignment: Alignment.centerRight,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: itemSizes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _itemSize = itemSizes[index];
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 14),
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 14),
                            decoration: BoxDecoration(
                              color: _itemSize == itemSizes[index]
                                  ? kPrimaryColor
                                  : kSecondaryColor,
                              borderRadius: BorderRadius.circular(6),
                              border:
                                  Border.all(color: kPrimaryColor, width: 2),
                            ),
                            child: Text(
                              itemSizeLabels[index],
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       _itemSize = Size.OnePound;
                  //     });
                  //   },
                  //   child: Container(
                  //     padding:
                  //         const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                  //     decoration: BoxDecoration(
                  //       color: _itemSize == Size.OnePound
                  //           ? kPrimaryColor
                  //           : kSecondaryColor,
                  //       borderRadius: BorderRadius.circular(6),
                  //       border: Border.all(color: kPrimaryColor, width: 2),
                  //     ),
                  //     child: const Text(
                  //       '1 LBS',
                  //       style: TextStyle(color: Colors.white, fontSize: 16),
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(width: 20),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       _itemSize = Size.TwoPound;
                  //     });
                  //   },
                  //   child: Container(
                  //     padding:
                  //         const EdgeInsets.symmetric(vertical: 3, horizontal: 15),
                  //     decoration: BoxDecoration(
                  //       color: _itemSize == Size.TwoPound
                  //           ? kPrimaryColor
                  //           : kSecondaryColor,
                  //       borderRadius: BorderRadius.circular(6),
                  //       border: Border.all(color: kPrimaryColor, width: 2),
                  //     ),
                  //     child: const Text(
                  //       '2 LBS',
                  //       style: TextStyle(color: Colors.white, fontSize: 16),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Row(
              children: [
                SizedBox(
                  width: size.width * 0.28,
                  child: const Text(
                    'Quantity :',
                    style: kTitleMedium,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 18),
                  decoration: BoxDecoration(
                    color: kSecondaryColor,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: kPrimaryColor, width: 2),
                  ),
                  child: const Text(
                    '1',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 8, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: size.width * 0.17,
                      child: const Text(
                        'Price : ',
                        style: kTitleMedium,
                      ),
                    ),
                    Text(
                      '${loadedItem.prices[_itemSize]?.values.first.toStringAsFixed(0)} rps.',
                      style: kTitleMedium.copyWith(color: kOrange),
                    ),
                  ],
                ),
                // SizedBox(width: size.width * 0.15 - 30),
                CustomButton(
                    label: 'Add to cart',
                    add: () async {
                      try {
                        await Provider.of<Cart>(context, listen: false).addItem(
                          CartItem(
                            id: DateTime.now().toString(),
                            title: loadedItem.title,
                            quantity: 1,
                            parsedSize:
                                itemSizeLabels[itemSizes.indexOf(_itemSize!)],
                            price: loadedItem.prices[_itemSize]!.values.first,
                            imagePath: loadedItem.imagePath,
                            dateTime: DateTime.now(),
                          ),
                          widget.itemId,
                          _itemSize!,
                        );
                        Utils.showSnackBar(context, 'Item added to cart.', 400);
                      } on FirebaseException catch (exception) {
                        Utils.showSnackBar(
                            context, exception.message.toString(), 1200);
                      } catch (exception) {
                        Utils.showSnackBar(context,
                            exception.toString().split(':').last.trim(), 1200);
                      }
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
