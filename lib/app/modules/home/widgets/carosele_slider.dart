import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({Key? key}) : super(key: key);

  static const List<String> banners = [
    "assets/images/Banner.png",
    "assets/images/caroselImage1.jpg",
    "assets/images/caroselImage2.jpg",
    "assets/images/caroselImage3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 182.h,
        autoPlay: false,
        viewportFraction: 1,
        enableInfiniteScroll: true,
        enlargeCenterPage: false,
      ),
      items: banners.map((imagePath) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 11.h, horizontal: 1.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        );
      }).toList(),
    );
  }
}
