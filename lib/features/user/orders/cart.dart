import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/user/PatientNav.dart';
import 'package:pharmacies_app/features/user/home/drugPage/Cupit/OrderCupit.dart';
import 'package:pharmacies_app/features/user/home/drugPage/Cupit/OrderStates.dart';
import 'package:pharmacies_app/features/user/home/pharmacyPage/pharmacyPage.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool empty = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  String? UserID;

  Future<void> _getUser() async {
    user = _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> deleteDocument() async {
    try {
      // Reference to the document based on the user's UID
      final cartRef =
          FirebaseFirestore.instance.collection('Carts').doc(user!.uid);
      final cartSnapshot = await cartRef.get();

      // Check if the document exists before attempting to delete it
      if (cartSnapshot.exists) {
        // Delete the document
        await cartRef.delete();
        print('Document successfully deleted');
      } else {
        print('No document found for the given UID');
      }
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Future<void> _updateItemQuantity(
      String userId, String productId, int newQuantity) async {
    try {
      final cartRef =
          FirebaseFirestore.instance.collection('Carts').doc(userId);
      final cartSnapshot = await cartRef.get();

      if (cartSnapshot.exists) {
        List items = cartSnapshot.data()?['items'] ?? [];

        // Find the item to update
        for (var item in items) {
          if (item['productId'] == productId) {
            item['quantity'] = newQuantity;
            break;
          }
        }

        await cartRef.update({'items': items});
        // print('Item quantity updated successfully');
      } else {
        // print('Cart not found');
      }
    } catch (e) {
      //print('Error updating item quantity: $e');
    }
  }

  Future<void> _removeItemFromCart(String userId, String productId) async {
    try {
      final cartRef =
          FirebaseFirestore.instance.collection('Carts').doc(userId);
      final cartSnapshot = await cartRef.get();

      if (cartSnapshot.exists) {
        List items = cartSnapshot.data()?['items'] ?? [];

        // Remove the item
        items.removeWhere((item) => item['productId'] == productId);

        await cartRef.update({'items': items});
        //  print('Item removed successfully');
      } else {
        // print('Cart not found');
      }
    } catch (e) {
      //print('Error removing item: $e');
    }
  }

  // int amount = 1;
  @override
  Widget build(BuildContext context) {
    int service = 20;
    late String pharmacyid;
    late String pharmacyname;

    return BlocListener<OrderCubit, OrderStates>(
      listener: (context, state) {
        if (state is OrderSuccessState) {
          showSentAlertDialog(context,
              title: 'done',
              ok: S.of(context).ok,
              alert: S.of(context).placeorder,
              Subtiltle: '', onTap: () {
            Navigator.pop(context);
            pushWithReplacment(context, PatientNav());
          });
        } else if (state is OrderErrorState) {
          showErrorDialog(context, state.error);
        } else {
          showLoadingDialog(context);
        }
      },
      child: user == null
          ? const CircularProgressIndicator()
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Carts')
                  .doc(user!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return const Center(
                      child: Center(
                    child: CircularProgressIndicator(),
                  ));
                }
                var CartData = snapshot.data!.data();
                List items = CartData?['items'];
                if (CartData != null) {
                  pharmacyid = CartData['pharmacyid'];
                  pharmacyname = CartData['pharmacyname'];
                }
                if (items.isEmpty) {
                  empty = true;
                }
                // Calculate the total price
                int totalPrice = 0;
                for (var item in items) {
                  totalPrice += (item['price'] as num).toInt() *
                      (item['quantity'] as num).toInt();
                }
                int totalamount = totalPrice + service;
                return CartData != null
                    ? Scaffold(
                        appBar: AppBar(
                          leading: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.arrow_back_ios_new_rounded,
                                  color: AppColors.primary)),
                          centerTitle: true,
                          title: Text(
                            CartData['pharmacyname'],
                            style: getTitleStyle(color: AppColors.primary),
                          ),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SimpleDialog(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                children: [
                                                  Text(S.of(context).deletecart,
                                                      style: getBodyStyle(
                                                          color: AppColors
                                                              .primary)),
                                                  const Gap(20),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Expanded(
                                                          child: CustomButton(
                                                              text: S
                                                                  .of(context)
                                                                  .yes,
                                                              bgcolor:
                                                                  Colors.red,
                                                              onTap: () {
                                                                deleteDocument();
                                                                pushWithReplacment(
                                                                    context,
                                                                    const PatientNav());
                                                              })),
                                                      const Gap(20),
                                                      Expanded(
                                                          child: CustomButton(
                                                              text: S
                                                                  .of(context)
                                                                  .no,
                                                              bgcolor: AppColors
                                                                  .primary,
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              }))
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        );
                                      });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                        body: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                child: empty
                                    ? Center(child: Text(S.of(context).noitems,style:getTitleStyle(color:AppColors.primary)))
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          int price =
                                              items[index]['price'] ?? 0;
                                          int amount =
                                              items[index]['quantity'] ?? 0;
                                          int total = price * amount;

                                          //  print(totalPrice);
                                          //  print(total);
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 20, right: 20),
                                              height: 100,
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    flex: 4,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            items[index]
                                                                ['name'],
                                                            style:
                                                                getTitleStyle(),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            total.toString(),
                                                            style:
                                                                getBodyStyle(),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Stack(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          child: Image.network(
                                                            items[index]
                                                                ['image'],
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          decoration: BoxDecoration(
                                                              color: AppColors
                                                                  .white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await _updateItemQuantity(
                                                                      user!.uid,
                                                                      items[index]
                                                                          [
                                                                          'productId'],
                                                                      amount +
                                                                          1);
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                  width: 40,
                                                                  height: 30,
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    color: AppColors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(amount
                                                                  .toString()),
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  if (amount >
                                                                      1) {
                                                                    await _updateItemQuantity(
                                                                        user!
                                                                            .uid,
                                                                        items[index]
                                                                            [
                                                                            'productId'],
                                                                        amount -
                                                                            1);
                                                                  } else {
                                                                    await _removeItemFromCart(
                                                                        user!
                                                                            .uid,
                                                                        items[index]
                                                                            [
                                                                            'productId']);
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: AppColors
                                                                        .primary,
                                                                  ),
                                                                  width: 40,
                                                                  height: 30,
                                                                  child: Icon(
                                                                    amount > 1
                                                                        ? Icons
                                                                            .remove
                                                                        : Icons
                                                                            .delete,
                                                                    color: AppColors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            const Divider(),
                                        itemCount: items.length),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              AppColors.grey.withOpacity(.3)),
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.white),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(S.of(context).PaymentSumary,
                                          style: getTitleStyle(
                                              color: AppColors.primary)),
                                      const Gap(20),
                                      Row(
                                        children: [
                                          Text(S.of(context).subtotal,
                                              style: getBodyStyle(
                                                  color: AppColors.black
                                                      .withOpacity(.7))),
                                          const Spacer(),
                                          Text(totalPrice.toString(),
                                              style: getBodyStyle(
                                                  color: AppColors.black
                                                      .withOpacity(.7)))
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          Text(S.of(context).Servicefee,
                                              style: getBodyStyle(
                                                  color: AppColors.black
                                                      .withOpacity(.7))),
                                          const Spacer(),
                                          Text(service.toString(),
                                              style: getBodyStyle(
                                                  color: AppColors.black
                                                      .withOpacity(.7)))
                                        ],
                                      ),
                                      const Gap(10),
                                      Row(
                                        children: [
                                          Text(S.of(context).totalamount,
                                              style: getTitleStyle(
                                                  color: AppColors.primary)),
                                          const Spacer(),
                                          Text(
                                            totalamount.toString(),
                                            style: getTitleStyle(
                                                color: AppColors.primary),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottomNavigationBar: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('Customer')
                                .doc(user?.uid)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData || snapshot.data == null) {
                                return const Center(
                                    child: Center(
                                  child: CircularProgressIndicator(),
                                ));
                              }

                              var userData = snapshot.data;
                              return userData != null && userData.exists
                                  ? Container(
                                      padding: const EdgeInsets.all(10),
                                      color: AppColors.white,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CustomButton(
                                                onTap: () {
                                                  push(
                                                      context,
                                                      PharmecyPage(
                                                          Pharmacyid:
                                                              pharmacyid,
                                                          name: pharmacyname));
                                                },
                                                style: getTitleStyle(
                                                    color: AppColors.primary),
                                                text: S.of(context).addmore,
                                                bgcolor: AppColors.grey),
                                          ),
                                          Expanded(
                                            child: CustomButton(
                                                onTap: () {
                                                  print(user!.displayName);
                                                  if (userData['address'] !=
                                                      null) {
                                                    try {
                                                      context
                                                          .read<OrderCubit>()
                                                          .confirmOrder(
                                                              pharmacyname:
                                                                  CartData[
                                                                      'pharmacyname'],
                                                              customerId:
                                                                  user!.uid,
                                                              pharmacyId: CartData[
                                                                  'pharmacyid'],
                                                              customername: user!
                                                                  .displayName
                                                                  .toString(),
                                                              address: userData[
                                                                  'address'],
                                                              phonenumber:
                                                                  userData[
                                                                      'phone'],
                                                              subtotal:
                                                                  totalamount,
                                                              servicefee:
                                                                  service,
                                                              totalprice:
                                                                  totalPrice,
                                                              items: items);
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  } else {
                                                    showErrorDialog(
                                                        context,
                                                        S
                                                            .of(context)
                                                            .addresserror);
                                                  }
                                                },
                                                style: getTitleStyle(
                                                    color: AppColors.white),
                                                text: S.of(context).Checkout,
                                                bgcolor: AppColors.primary),
                                          )
                                        ],
                                      ),
                                    )
                                  : SizedBox();
                            }),
                      )
                    : SizedBox();
              }),

// After the StreamBuilder
    );
  }
}
