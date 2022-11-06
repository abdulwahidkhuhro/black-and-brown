import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/Item.dart';
import '../models/cartItem.dart';

class Cart with ChangeNotifier {
  Map<String, Map<Size, CartItem>> _cartItems = {};
  final _firestore = FirebaseFirestore.instance;
  final _uId = FirebaseAuth.instance.currentUser?.uid;

  List<CartItem> get getCartItems {
    // if (_cartItems.isEmpty) {
    //   fetchAndSetData();
    // }
    List<CartItem> cartItems = [];
    _cartItems.forEach((key, value) {
      cartItems.addAll(value.values);
    });
    cartItems.sort((a, b) {
      return a.dateTime.compareTo(b.dateTime);
    });
    return cartItems.reversed.toList();
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, value) {
      value.forEach((cakeSize, cartItem) {
        total += cartItem.price * cartItem.quantity;
      });
    });
    return total;
  }

  Future<void> addItem(CartItem cartItem, String itemId, Size itemSize) async {
    if (_cartItems.containsKey(itemId)) {
      if (_cartItems[itemId]!.containsKey(itemSize)) {
        // updating item
        // getting old cort item id and quantity
        String? existingItemId = _cartItems[itemId]![itemSize]?.id;
        int? existingItemQuantity = _cartItems[itemId]![itemSize]?.quantity;
        await _firestore
            .collection('cart')
            .doc(_uId)
            .collection(_uId!)
            .doc(existingItemId)
            .update({
          'dateTime': cartItem.dateTime,
          'quantity': existingItemQuantity! + cartItem.quantity,
        }).timeout(const Duration(seconds: 8), onTimeout: () {
          throw Exception('Slow internet connection, try again later');
        });
        _cartItems[itemId]!.update(
          itemSize,
          (existingCartItem) => CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity + cartItem.quantity,
            price: cartItem.price,
            parsedSize: existingCartItem.parsedSize,
            imagePath: existingCartItem.imagePath,
            dateTime: cartItem.dateTime,
          ),
        );
      } else {
        final response = await _firestore
            .collection('cart')
            .doc(_uId)
            .collection(_uId!)
            .add({
          'itemId': itemId,
          'title': cartItem.title,
          'price': cartItem.price,
          'quantity': cartItem.quantity,
          'parsedSize': cartItem.parsedSize,
          'imagePath': cartItem.imagePath,
          'dateTime': cartItem.dateTime,
          'size': itemSize.name,
        }).timeout(const Duration(seconds: 8), onTimeout: () {
          throw Exception('Slow internet connection, try again later');
        });

        _cartItems[itemId]!.putIfAbsent(
          itemSize,
          () => CartItem(
            id: response.id,
            title: cartItem.title,
            quantity: cartItem.quantity,
            price: cartItem.price,
            parsedSize: cartItem.parsedSize,
            imagePath: cartItem.imagePath,
            dateTime: cartItem.dateTime,
          ),
        );
      }

      final updatedItem = _cartItems.remove(itemId);
      _cartItems.putIfAbsent(itemId, () => updatedItem!);
    } else {
      final response =
          await _firestore.collection('cart').doc(_uId).collection(_uId!).add({
        'itemId': itemId,
        'title': cartItem.title,
        'price': cartItem.price,
        'quantity': cartItem.quantity,
        'parsedSize': cartItem.parsedSize,
        'imagePath': cartItem.imagePath,
        'dateTime': cartItem.dateTime,
        'size': itemSize.name,
      }).timeout(const Duration(seconds: 8), onTimeout: () {
        throw Exception('Slow internet connection, try again later');
      });
      _cartItems.putIfAbsent(
        itemId,
        () => {
          itemSize: CartItem(
              id: response.id,
              title: cartItem.title,
              quantity: cartItem.quantity,
              price: cartItem.price,
              parsedSize: cartItem.parsedSize,
              imagePath: cartItem.imagePath,
              dateTime: cartItem.dateTime)
        },
      );
    }

    notifyListeners();
  }

  Future<void> fetchAndSetData() async {
    if (_cartItems.isNotEmpty) {
      return;
    }
    final response = await _firestore
        .collection('cart')
        .doc(_uId)
        .collection(_uId!)
        .get()
        .timeout(const Duration(seconds: 8), onTimeout: () {
      throw Exception('Slow internet connection, try again later');
    });

    Map<String, Map<Size, CartItem>> loadedItems = {};
    for (var snapshot in response.docs) {
      final snapshotData = snapshot.data();
      // print('${snapshotData['title']} : ${snapshotData['parsedSize']}');
      Size size = Size.values.byName(snapshotData['size']);
      if (loadedItems.containsKey(snapshotData['itemId'])) {
        if (!loadedItems[snapshotData['itemId']]!
            .containsKey(snapshotData['size'])) {
          loadedItems[snapshotData['itemId']]!.putIfAbsent(
            size,
            () => CartItem(
              id: snapshot.id,
              title: snapshotData['title'],
              quantity: snapshotData['quantity'],
              price: snapshotData['price'],
              parsedSize: snapshotData['parsedSize'],
              imagePath: snapshotData['imagePath'],
              dateTime: snapshotData['dateTime'].toDate(),
            ),
          );
          // final updatedItem = loadedItems.remove(snapshotData['itemId']);
        }
      } else {
        loadedItems.putIfAbsent(
          snapshotData['itemId'],
          () => {
            size: CartItem(
              id: snapshot.id,
              title: snapshotData['title'],
              quantity: snapshotData['quantity'],
              price: snapshotData['price'],
              parsedSize: snapshotData['parsedSize'],
              imagePath: snapshotData['imagePath'],
              dateTime: snapshotData['dateTime'].toDate(),
            ),
          },
        );
      }
    }
    // print(loadedItems.toString());
    _cartItems = loadedItems;
    notifyListeners();
  }

  // void removeSingleItem(String itemId) {
  //   if (!_cartItems.containsKey(itemId)) return;
  //   if (_cartItems[itemId]!.quantity > 1) {
  //     _cartItems.update(
  //       itemId,
  //       (existingCartItem) => CartItem(
  //           id: existingCartItem.id,
  //           title: existingCartItem.title,
  //           quantity: existingCartItem.quantity - 1,
  //           price: existingCartItem.price),
  //     );
  //   } else {
  //     _cartItems.remove(itemId);
  //   }
  //   notifyListeners();
  // }

  void removeItem(String itemId) {
    _cartItems.remove(itemId);
    notifyListeners();
  }

  Future<void> clearCart() async {
    try {
      if (_uId != null) {
        final snapshots = await _firestore
            .collection('cart')
            .doc(_uId)
            .collection(_uId!)
            .get()
            .timeout(const Duration(seconds: 10), onTimeout: () {
          throw Exception('Slow internet connection, try again later');
        });
        if (snapshots.docs.isNotEmpty) {
          for (var doc in snapshots.docs) {
            await doc.reference.delete().timeout(const Duration(seconds: 10));
          }
          _cartItems = {};
          notifyListeners();
        }
      }
    } on FirebaseException catch (e) {
      print(e.toString());
    } catch (e) {
      print(e.toString());
    }
  }
}
