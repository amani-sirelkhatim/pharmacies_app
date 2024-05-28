import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacies_app/core/functions/route.dart';
import 'package:pharmacies_app/core/utils/colors.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/core/widgets/custom_button.dart';
import 'package:pharmacies_app/core/widgets/dialog.dart';
import 'package:pharmacies_app/features/user/PatientNav.dart';

import 'package:pharmacies_app/features/user/home/drugPage/Cupit/OrderCupit.dart';
import 'package:pharmacies_app/features/user/home/drugPage/Cupit/OrderStates.dart';

import 'package:pharmacies_app/features/user/orders/cart.dart';
import 'package:pharmacies_app/generated/l10n.dart';

class PerscriptioPage extends StatefulWidget {
  const PerscriptioPage(
      {super.key,
      required this.drugname,
      required this.pharmacyid,
      required this.productquantity,
      required this.productprice,
      required this.productimage,
      required this.productid,
      required this.pharmacyname});
  final String drugname;
  final String pharmacyid;

  final int productquantity;
  final int productprice;
  final String productid;
  final String pharmacyname;

  final String productimage;

  @override
  State<PerscriptioPage> createState() => _PerscriptioPageState();
}

class _PerscriptioPageState extends State<PerscriptioPage> {
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
  String? image1;

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

      String imagePath = 'products/PerscriptioPages/$timestamp';

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
          title: Text(S.of(context).photosource, style: getTitleStyle()),
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
                // print('Image uploaded successfully: $imageUrl');
              },
              child: Text(S.of(context).gallery, style: getBodyStyle()),
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
                //  print('Image uploaded successfully: $imageUrl');
                //   pickVideo(ImageSource.camera);
              },
              child: Text(
                S.of(context).camera,
                style: getBodyStyle(),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            widget.drugname,
            style: getTitleStyle(color: AppColors.primary),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.primary)),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(S.of(context).uploadperscription + " :",
                    style: getBodyStyle()),
                const Gap(20),
                GestureDetector(
                  onTap: () async {
                    await _showUploadoptions();
                  },
                  child: Container(
                      width: 60,
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: AppColors.primary)),
                      child: image1 == null
                          ? Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppColors.primary,
                                ),
                                Icon(
                                  Icons.image_rounded,
                                  color: AppColors.primary,
                                ),
                              ],
                            )
                          : Center(
                              child: Text(S.of(context).update,
                                  style: getSmallStyle(
                                      color: AppColors.primary)))),
                ),
                const Gap(20),
                isloading
                    ? const Center(child: CircularProgressIndicator())
                    : image1 != null
                        ? Column(
                            children: [
                              Container(
                                height: 300,
                                child: FullScreenWidget(
                                  disposeLevel: DisposeLevel.Low,
                                  child: SafeArea(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        image1!,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(30),
                              StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Carts')
                                      .doc(user!.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData ||
                                        snapshot.data == null) {
                                      return const Center(
                                          child: Center(
                                        child: CircularProgressIndicator(),
                                      ));
                                    }
                                    var CartData = snapshot.data;
                                    bool isInCart = false;

                                    if (CartData!.exists) {
                                      List items = CartData['items'] ?? [];
                                      isInCart = items.any((item) =>
                                          item['productId'] ==
                                          widget.productid);
                                    }
                                    // print(isInCart);
                                    return CustomButton(
                                        text: isInCart
                                            ? S.of(context).viewcart
                                            : S.of(context).cart,
                                        bgcolor: AppColors.primary,
                                        width: 200,
                                        onTap: () async {
                                          if (CartData == null ||
                                              !CartData.exists) {
                                            await context
                                                .read<OrderCubit>()
                                                .createCart(
                                                  pharmacyname:
                                                      widget.pharmacyname,
                                                  customerId: user!.uid,
                                                  pharmacyId: widget.pharmacyid,
                                                  productId: widget.productid,
                                                  name: widget.drugname,
                                                  quantity:
                                                      widget.productquantity,
                                                  price: widget.productprice,
                                                  image: widget.productimage,
                                                  perscription: image1!,
                                                );
                                          } else if (CartData.exists &&
                                              !isInCart) {
                                            await context
                                                .read<OrderCubit>()
                                                .addToCart(
                                                  customerId: user!.uid,
                                                  productId: widget.productid,
                                                  name: widget.drugname,
                                                  quantity:
                                                      widget.productquantity,
                                                  price: widget.productprice,
                                                  image: widget.productimage,
                                                  perscription: image1!,
                                                );
                                          } else {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Details()));
                                          }
                                        });
                                  })
                            ],
                          )
                        : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
