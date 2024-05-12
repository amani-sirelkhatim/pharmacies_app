import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:pharmacies_app/core/utils/colors.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

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
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: imageUrls.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    imageUrls[index],
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
          count: imageUrls.length,
          axisDirection: Axis.horizontal,
          effect: ScrollingDotsEffect(
              dotHeight: 10,
              dotWidth: 10,
              activeDotScale: 2,
              activeDotColor: AppColors.primary),
        ),
        Gap(10),
        Text('name')
      ],
    );
  }
}
