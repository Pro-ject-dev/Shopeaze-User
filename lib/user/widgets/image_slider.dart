import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_fonts/google_fonts.dart';

class Image_slider extends StatelessWidget {
  const Image_slider({
    required BuildContext context,
    required this.hei,
    required this.wid,
    this.img1,
    this.img2,
    this.img3,
    this.img4,
    this.img5,
    this.text_status,
  });

  final double hei;
  final double wid;
  final img1, img2, img3, img4, img5, text_status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: hei,
        width: wid,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromARGB(255, 166, 166, 166),
                      blurRadius: 3,
                      offset: Offset(1, 1))
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: ImageSlideshow(
                  indicatorColor: const Color.fromARGB(255, 90, 90, 90),
                  autoPlayInterval: 7000,
                  isLoop: true,
                  children: [
                    images(img: img1),
                    images(img: img2),
                    images(img: img3),
                    images(img: img4),
                    images(img: img5),
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(children: [
              Row(
                children: [
                  if (text_status == true) text1("Flash Sale") else text1("")
                ],
              ),
              Row(
                children: [
                  if (text_status == true) text2("view more >") else text2(""),
                ],
              )
            ]),
          ),
        ]));
  }

  text2(text2) {
    return Text(text2,
        style: GoogleFonts.poppins(
            shadows: [
              const Shadow(
                  color: Color.fromARGB(255, 0, 0, 0),
                  blurRadius: 3,
                  offset: Offset(1, 1.5))
            ],
            color: Color.fromARGB(255, 255, 166, 0),
            fontSize: wid * 0.04,
            fontWeight: FontWeight.w400));
  }

  text1(text) {
    return Text(text,
        style: GoogleFonts.poppins(
            shadows: [
              const Shadow(
                color: Color.fromARGB(255, 1, 1, 1),
                blurRadius: 2,
                offset: Offset(1, 1.5),
              )
            ],
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: wid * 0.05,
            fontWeight: FontWeight.w500));
  }
}

class images extends StatelessWidget {
  const images({
    Key? key,
    required this.img,
  }) : super(key: key);

  final img;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.95,
      child: Container(
        child: Image.network(
          img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
