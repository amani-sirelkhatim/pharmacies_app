import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacies_app/core/functions/route.dart';

import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/user/PatientNav.dart';
import 'package:pharmacies_app/features/user/home/drugPage/Cupit/OrderCupit.dart';
import 'package:pharmacies_app/features/user/home/drugPage/Cupit/OrderStates.dart';
import 'package:pharmacies_app/features/user/home/drugPage/view/perscriptionpage.dart';
import 'package:pharmacies_app/features/user/home/drugPage/view/widgets/imageSlider.dart';
import 'package:pharmacies_app/features/user/home/drugPage/view/widgets/tabBar.dart';
import 'package:pharmacies_app/features/user/orders/cart.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class DrugPage extends StatefulWidget {
  const DrugPage(
      {super.key, required this.productid, required this.pharmacyname});
  final String productid;
  final String pharmacyname;

  @override
  State<DrugPage> createState() => _DrugPageState();
}

class _DrugPageState extends State<DrugPage> {
  int price = 100;

  int amount = 1;

  bool issaved = false;
  void toggleSaved() {
    setState(() {
      issaved = !issaved;
    });
  }

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

  bool isloading = false;
  late String image;
  late String image1;

  File? file;
  String? profileUrl;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://pharmacy-1a87c.appspot.com');
  Future<String> uploadImageToFireStore(File image) async {
    setState(() {
      isloading = true;
    });

    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      String imagePath = 'products/Perscriptions/$timestamp';

      Reference ref = _storage.ref().child(imagePath);
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      await ref.putFile(image, metadata);
      String url = await ref.getDownloadURL();

      setState(() {
        image1 = url;
        print('done$image1');
      });

      return url;
    } catch (e) {
      print('Error during image upload to Firestore: $e');
      return '';
    } finally {
      setState(() {
        isloading = false;
      });
    }
  }

  // Future<void> addImageToFirestore({required String imageUrl}) async {
  //   try {
  //     final CollectionReference imageCollection =
  //         FirebaseFirestore.instance.collection('Pharmacy');

  //     await imageCollection.doc(user!.uid).set({
  //       'image': imageUrl,
  //     }, SetOptions(merge: true));

  //     print('Image added to Firestore: $imageUrl');
  //   } catch (e) {
  //     print('Error adding image to Firestore: $e');
  //   }
  // }

  Future<void> _showUploadoptions() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Photo Source"),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedFile != null) {
                  setState(() {
                    file = File(pickedFile.path);
                  });
                }
                final imageUrl = await uploadImageToFireStore(file!);
                print('Image uploaded successfully: $imageUrl');
              },
              child: const Text("Gallery"),
            ),
            TextButton(
              onPressed: () async {
                final pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.camera);
                if (pickedFile != null) {
                  setState(() {
                    file = File(pickedFile.path);
                  });
                }

                final imageUrl = await uploadImageToFireStore(file!);
                print('Image uploaded successfully: $imageUrl');
                //   pickVideo(ImageSource.camera);
              },
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Products')
            .doc(widget.productid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
                child: Center(
              child: CircularProgressIndicator(),
            ));
          }

          var DrugData = snapshot.data;
          int price = DrugData!['price'];
          int total = price * amount;
          return BlocListener<OrderCubit, OrderStates>(
            listener: (context, state) {
              if (state is OrderSuccessState) {
                showSentAlertDialog(context,
                    title: 'done',
                    ok: S.of(context).ok,
                    alert: S.of(context).addproduct,
                    Subtiltle: '', onTap: () {
                  Navigator.pop(context);
                  pushWithReplacment(context, Details());
                });
              } else if (state is OrderErrorState) {
                showErrorDialog(context, state.error);
              } else {
                showLoadingDialog(context);
              }
            },
            child: Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  widget.pharmacyname,
                  style: getTitleStyle(color: AppColors.primary),
                ),
                leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: AppColors.primary)),
                actions: [
                  IconButton(
                      onPressed: () {
                        toggleSaved();
                      },
                      icon: Icon(
                        issaved
                            ? Icons.favorite
                            : Icons.favorite_outline_outlined,
                        color: Colors.red,
                      ))
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ImageSlider(
                      productid: widget.productid,
                    ),
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                amount = amount + 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.grey,
                              ),
                              width: 40,
                              height: 40,
                              child: Icon(
                                size: 30,
                                Icons.add,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          Text(amount.toString()),
                          GestureDetector(
                            onTap: () {
                              if (amount > 1) {
                                setState(() {
                                  amount = amount - 1;
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.grey,
                              ),
                              width: 40,
                              height: 40,
                              child: Icon(
                                size: 30,
                                Icons.remove,
                                color: AppColors.primary,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    TabButtunBar(
                      productid: widget.productid,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
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
                      var CartData = snapshot.data;
                      bool isInCart = false;
                      if (CartData!.exists) {
                        List items = CartData['items'] ?? [];
                        isInCart = items.any(
                            (item) => item['productId'] == widget.productid);
                      }
                      return GestureDetector(
                        onTap: () async {
                          if (!isInCart) {
                            if (CartData == null || !CartData.exists) {
                              if (DrugData['perscription'] == true) {
                                push(
                                    context,
                                    PerscriptioPage(
                                      pharmacyname: widget.pharmacyname,
                                      productquantity: amount,
                                      productprice: price,
                                      productimage: DrugData['frontimage'],
                                      productid: DrugData['drugid'],
                                      pharmacyid: DrugData['pharmacyid'],
                                      drugname: DrugData['name'],
                                    ));
                              } else {
                                await context.read<OrderCubit>().createCart(
                                      pharmacyname: widget.pharmacyname,
                                      customerId: user!.uid,
                                      pharmacyId: DrugData['pharmacyid'],
                                      productId: widget.productid,
                                      name: DrugData['name'],
                                      quantity: amount,
                                      price: price,
                                      image: DrugData['frontimage'],
                                    );
                              }
                            } else if (DrugData['pharmacyid'] ==
                                CartData['pharmacyid']) {
                              if (DrugData['perscription'] == true) {
                                push(
                                    context,
                                    PerscriptioPage(
                                      pharmacyname: widget.pharmacyname,
                                      productquantity: amount,
                                      productprice: price,
                                      productimage: DrugData['frontimage'],
                                      productid: DrugData['drugid'],
                                      pharmacyid: DrugData['pharmacyid'],
                                      drugname: DrugData['name'],
                                    ));
                              } else {
                                await context.read<OrderCubit>().addToCart(
                                      customerId: user!.uid,
                                      productId: widget.productid,
                                      name: DrugData['name'],
                                      quantity: amount,
                                      price: price,
                                      image: DrugData['frontimage'],
                                    );
                              }
                            } else {
                              showErrorDialog(
                                  context, S.of(context).pendingcart);
                            }
                          } else {
                            push(context, const Details());
                          }
                        },
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: AppColors.primary),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                    child: Text(
                                      isInCart
                                          ? S.of(context).viewcart
                                          : S.of(context).cart,
                                      style:
                                          getTitleStyle(color: AppColors.white),
                                    ),
                                  ),
                                  if (isInCart == false)
                                    Text(
                                      '$total',
                                      style:
                                          getTitleStyle(color: AppColors.white),
                                    )
                                ])),
                      );
                    }),
              ),
            ),
          );
        });
  }
}
