import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:pharmacies_app/generated/l10n.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pharmacies_app/core/utils/colors.dart';

class AdminSlider extends StatefulWidget {
  const AdminSlider({super.key, required this.drugid});
  final String drugid;
  @override
  State<AdminSlider> createState() => _AdminSliderState();
}

class _AdminSliderState extends State<AdminSlider> {
  // List<String> imageUrls = [
  //   'assets/images/panadol1.png',
  //   'assets/images/panadol2.jpg'
  // ];

  late String image;
  late String image1;
  late String image2;
  bool isloading = false;
  File? file;
  String? profileUrl;
  final FirebaseStorage _storage =
      FirebaseStorage.instanceFor(bucket: 'gs://pharmacy-1a87c.appspot.com');
  Future<String> uploadImageToFireStore(File image, int type) async {
    setState(() {
      isloading = true;
    });
    String? foldername;
    if (type == 1) {
      setState(() {
        foldername = 'frontImages';
      });
    } else {
      setState(() {
        foldername = 'backImages';
      });
    }
    try {
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();

      String imagePath = 'products/$foldername/$timestamp';

      Reference ref = _storage.ref().child(imagePath);
      SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
      await ref.putFile(image, metadata);
      String url = await ref.getDownloadURL();

      if (type == 1) {
        setState(() {
          image1 = url;
        //  print('done$image1');
          FirebaseFirestore.instance
              .collection('Products')
              .doc(widget.drugid)
              .set({
            'frontimage': image1,
          }, SetOptions(merge: true));
        });
      } else {
        setState(() {
          image2 = url;
          // print('done$image2');
          // print('done$image1');
          FirebaseFirestore.instance
              .collection('Products')
              .doc(widget.drugid)
              .set({
            'backimage': image2,
          }, SetOptions(merge: true));
        });
      }

      return url;
    } catch (e) {
    //  print('Error during image upload to Firestore: $e');
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

  Future<void> _showUploadoptions(int type) async {
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
                final imageUrl = await uploadImageToFireStore(file!, type);
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

                final imageUrl = await uploadImageToFireStore(file!, type);
               // print('Image uploaded successfully: $imageUrl');
                //   pickVideo(ImageSource.camera);
              },
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );
  }

  updateimagesDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: AppColors.white,
            children: [
              Container(
                padding:const EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(S.of(context).frontImage, style: getBodyStyle()),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);

                            _showUploadoptions(1);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: AppColors.primary)),
                            child: Row(
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
                            ),
                          ),
                        ),
                      ],
                    ),
                  const  Gap(20),
                    Row(
                      children: [
                        Text(S.of(context).backImage, style: getBodyStyle()),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);

                            _showUploadoptions(2);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: AppColors.primary)),
                            child: Row(
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
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        });
  }

  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    return isloading
        ?const Center(
            child: CircularProgressIndicator(),
          )
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Products')
                .where('drugid', isEqualTo: widget.drugid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              }

              var DrugsData = snapshot.data!.docs;
              var drug = DrugsData[0];
              List images = [drug['frontimage'], drug['backimage']];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          CarouselSlider.builder(
                              itemCount: images.length,
                              itemBuilder: (BuildContext context, int index,
                                  int realIndex) {
                                return ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      images[index],
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ));
                              },
                              options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentpage = index;
                                  });
                                },
                                height: 150,
                                aspectRatio: 16 / 9,
                                viewportFraction: 0.7,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                reverse: false,
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 3),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                              )),
                        const  Gap(10),
                          SmoothPageIndicator(
                            controller:
                                PageController(initialPage: currentpage),
                            count: images.length,
                            axisDirection: Axis.horizontal,
                            effect: ScrollingDotsEffect(
                                dotHeight: 10,
                                dotWidth: 10,
                                activeDotScale: 2,
                                activeDotColor: AppColors.primary),
                          ),
                        const  Gap(10),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                            onPressed: () {
                              updateimagesDialog();
                            },
                            icon: Icon(
                              Icons.edit,
                              color: AppColors.primary,
                            )))
                  ],
                ),
              );
            });
  }
}
