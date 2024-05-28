import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pharmacies_app/core/utils/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pharmacies_app/core/utils/colors.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.productid});
  final String productid;
  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  List<String> imageUrls = [
    'assets/images/panadol1.png',
    'assets/images/panadol2.jpg'
  ];
  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Products')
            .where('drugid', isEqualTo: widget.productid)
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
          return Column(
            children: [
              CarouselSlider.builder(
                  itemCount: images.length,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
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
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  )),
              Gap(10),
              SmoothPageIndicator(
                controller: PageController(initialPage: currentpage),
                count: images.length,
                axisDirection: Axis.horizontal,
                effect: ScrollingDotsEffect(
                    dotHeight: 10,
                    dotWidth: 10,
                    activeDotScale: 2,
                    activeDotColor: AppColors.primary),
              ),
              Gap(10),
              Text(
                drug['name'],
                style: getBodyStyle(),
              )
            ],
          );
        });
  }
}
