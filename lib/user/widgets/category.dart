import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class category extends StatelessWidget {
  const category({
    Key? key,
    required this.hei,
    required this.wid,
    this.img,
    this.text,
  }) : super(key: key);

  final double hei;
  final double wid;
  final img, text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0, left: 8.0, right: 8.0),
      child: Row(
        children: [
          Stack(children: [
            Column(
              children: [
                Container(
                  height: hei * 0.125,
                  width: wid * 0.256,
                  decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            color: Color.fromARGB(255, 199, 197, 197),
                            offset: Offset(0.5, 1))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: hei * 0.045),
              // ignore: sized_box_for_whitespace
              child: Container(
                  width: wid * 0.26,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        textStyle: const TextStyle(letterSpacing: 0.8),
                        shadows: [
                          const Shadow(
                              color: Color.fromARGB(255, 129, 127, 127),
                              blurRadius: 3,
                              offset: Offset(1, 1))
                        ],
                        fontSize: wid * 0.035,
                        fontWeight: FontWeight.w600),
                  )),
            )
          ]),
        ],
      ),
    );
  }
}
