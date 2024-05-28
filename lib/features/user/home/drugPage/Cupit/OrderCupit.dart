import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmacies_app/features/user/home/drugPage/Cupit/OrderStates.dart';
import 'package:intl/intl.dart';

class OrderCubit extends Cubit<OrderStates> {
  OrderCubit() : super(OrderInitState());

  Future<void> createCart(
      {required String customerId,
      required String pharmacyId,
      required String productId,
      required String name,
      required String pharmacyname,
      required int quantity,
      required int price,
      required String image,
      String? perscription}) async {
    emit(OrderLoadingState());
    try {
      await FirebaseFirestore.instance.collection('Carts').doc(customerId).set({
        'pharmacyid': pharmacyId,
        'items': [],
        'pharmacyname': pharmacyname,
      });
      final cartRef =
          FirebaseFirestore.instance.collection('Carts').doc(customerId);
      final cartSnapshot = await cartRef.get();
      if (cartSnapshot.exists) {
        List items = cartSnapshot['items'];
        items.add({
          'productId': productId,
          'name': name,
          'quantity': quantity,
          'price': price,
          'image': image,
          'perscription': perscription
        });

        await cartRef.update({'items': items});
      }
      emit(OrderSuccessState());
    } catch (e) {
      emit(
          OrderErrorState(error: 'Encountered a problem, try again later! $e'));
    }
  }

  Future<void> addToCart({
    required String customerId,
    required String productId,
    required String name,
    required int quantity,
    required int price,
    required String image,
    String? perscription,
  }) async {
    emit(OrderLoadingState());
    try {
      final cartRef =
          FirebaseFirestore.instance.collection('Carts').doc(customerId);
      final cartSnapshot = await cartRef.get();

      if (cartSnapshot.exists) {
        List items = cartSnapshot['items'];
        items.add({
          'productId': productId,
          'name': name,
          'quantity': quantity,
          'price': price,
          'image': image,
          'perscription': perscription
        });

        await cartRef.update({'items': items});
        emit(OrderSuccessState());
      } else {
        emit(OrderErrorState(error: 'Cart not found.'));
      }
    } catch (e) {
      emit(
          OrderErrorState(error: 'Encountered a problem, try again later! $e'));
    }
  }

//  Future<bool> isProductInCart({required String customerId, required String productId}) async {
//     final cartRef = FirebaseFirestore.instance.collection('Carts').doc(customerId);
//     final cartSnapshot = await cartRef.get();
//     if (cartSnapshot.exists) {
//       List items = cartSnapshot.data()!['items'] ?? [];
//       return items.any((item) => item['productId'] == productId);
//     }
//     return false;
//   }
  Future<void> confirmOrder({
    required String customerId,
    required String pharmacyId,
    required String customername,
    required String address,
    required String phonenumber,
    required String pharmacyname,
    required int subtotal,
    required int servicefee,
    required int totalprice,
    required List items,
  }) async {
    emit(OrderLoadingState());
    try {
      final cartRef =
          FirebaseFirestore.instance.collection('Carts').doc(customerId);
      final cartSnapshot = await cartRef.get();
// Get the current date and time
      // Get the current date and time, then set minutes, seconds, and milliseconds to zero
      DateTime now = DateTime.now();
      DateTime trimmedNow = DateTime(now.year, now.month, now.day, now.hour);

      // Format the trimmed date to include only the date and hour
      String formattedDate =
          DateFormat('yyyy-MM-dd h a', 'en').format(trimmedNow);
      if (cartSnapshot.exists) {
        // Here you can handle order confirmation logic, like saving the order details to an Orders collection
        var documentReference =
            await FirebaseFirestore.instance.collection('Orders').add({
          'pharmacyname': pharmacyname,
          'pharmacyId': pharmacyId,
          'items': items,
          'customerid': customerId,
          'subtotal': subtotal,
          'servicefee': servicefee,
          'totalprice': totalprice,
          'customername': customername,
          'phonenumber': phonenumber,
          'address': address,
          'status': 'pending',
          'date': formattedDate
        });
        var orderid = documentReference.id;
        await cartRef.delete();

// Update the document with the document ID
        await documentReference.update({'orderid': orderid});
        emit(OrderSuccessState());
      } else {
        emit(OrderErrorState(error: 'Cart not found.'));
      }
    } catch (e) {
      emit(
          OrderErrorState(error: 'Encountered a problem, try again later! $e'));
    }
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:pharmacies_app/features/user/home/drugPage/Cupit/OrderStates.dart';

// class OrderCupit extends Cubit<OrderStates> {
//   OrderCupit() : super(OrderInitState());
  
// CreateCart(
//   {required String customerid,
//   required String Pharmacyid,

//   }
// ){

// }
// //   AddtoCart(
// //       {required String pharmacyid,
// //       required String cat,
// //       required String name,
// //       required List descriptionArabic,
// //       required List descriptionEnglish,
// //       required List howtouseArabic,
// //       required List howtouseEnglish,
// //       required String frontimage,
// //       required String backimage,
// //       required int? price,
// //       required bool perscription,
// //       required final String pharmacyname}) async {
// //     emit(OrderLoadingState());
// //     try {
// //       // firestore

// //       var documentReference =
// //           await FirebaseFirestore.instance.collection('Products').add({
// //         'pharmacyid': pharmacyid,
// //         'pharmacyname'
// //             'name': name,
// //         'cattegory': cat,
// //         'price': price,
// //         'perscription': perscription,
// //         'descriptionArabic': descriptionArabic,
// //         'descriptionEnglish': descriptionEnglish,
// //         'howtouseArabic': howtouseArabic,
// //         'howtouseEnglish': howtouseEnglish,
// //         'frontimage': frontimage,
// //         'backimage': backimage
// //       });

// // // Access the auto-generated document ID
// //       var drugid = documentReference.id;

// // // Update the document with the document ID
// //       await documentReference.update({'drugid': drugid});

// //       emit(OrderSuccessState());
// //     } catch (e) {
// //       emit(OrderErrorState(
// //           error: '$e' + 'Encountered a problem, try again later!'));
// //     }
// //   }

// ConfirmOrder(){

// }
// //'incaontered a proplem try again later!!'
// }
