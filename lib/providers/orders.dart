import 'package:black_n_brown/models/cartItem.dart';
import 'package:black_n_brown/models/order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Orders with ChangeNotifier {
  List<Order> _orders = [];
  final _firestore = FirebaseFirestore.instance;
  final _uId = FirebaseAuth.instance.currentUser?.uid;

  List<Order> get getOrderItems {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    if (_orders.isNotEmpty) {
      return;
    }
    final response = await _firestore
        .collection('orders')
        .doc(_uId)
        .collection(_uId!)
        .orderBy('dateTime', descending: false)
        .get()
        .timeout(const Duration(seconds: 8), onTimeout: () {
      throw Exception('Slow internet connection, try again later');
    });
    List<Order> tempList = [];
    for (var snapshot in response.docs) {
      tempList.insert(
          0,
          Order(
            orderId: snapshot.id,
            totalAmount: snapshot.data()['totalAmount'].toDouble(),
            cartItems:
                List<CartItem>.from(snapshot.data()['cartItems'].map((item) {
              return CartItem(
                id: item['id'],
                title: item['title'],
                quantity: item['quantity'],
                price: item['price'].toDouble(),
                parsedSize: item['parsedSize'],
                imagePath: item['imagePath'],
                dateTime: item['dateTime'].toDate(),
              );
            })),
            dateTime: snapshot.data()['dateTime'].toDate(),
          ));
      _orders = tempList;
      notifyListeners();
    }
  }

  Future<void> addOrder(List<CartItem> cartItems, double totalAmount) async {
    final timeStamp = DateTime.now();
    final response =
        await _firestore.collection('orders').doc(_uId).collection(_uId!).add({
      'totalAmount': totalAmount,
      'dateTime': timeStamp,
      'cartItems': cartItems.map((cartItem) {
        return {
          'id': cartItem.id,
          'title': cartItem.title,
          'quantity': cartItem.quantity,
          'price': cartItem.price,
          'parsedSize': cartItem.parsedSize,
          'imagePath': cartItem.imagePath,
          'dateTime': cartItem.dateTime,
        };
      }).toList(),
    }).timeout(const Duration(seconds: 8), onTimeout: () {
      throw Exception('Slow internet connection, try again later');
    });
    _orders.insert(
      0,
      Order(
        orderId: response.id,
        cartItems: cartItems,
        totalAmount: totalAmount,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  Future<void> clearHistory() async {
    try {
      if (_uId != null) {
        final snapshots = await _firestore
            .collection('orders')
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
          _orders = [];
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
