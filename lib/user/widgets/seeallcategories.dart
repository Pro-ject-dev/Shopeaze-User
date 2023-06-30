import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class seeall extends StatefulWidget {
  const seeall({
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
  State<seeall> createState() => _seeallState();
}

class _seeallState extends State<seeall> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.5, right: 8.0),
      child: Column(
        children: [
          Stack(children: [
            Column(
              children: [
                Container(
                  height: widget.hei * 0.200,
                  width: widget.wid * 0.420,
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
                      widget.img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: widget.hei * 0.070),
                  // ignore: sized_box_for_whitespace
                  child: Center(
                    child: Container(
                        child: Text(
                      widget.text,
                      style: GoogleFonts.poppins(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          textStyle: const TextStyle(letterSpacing: 0.8),
                          shadows: [
                            const Shadow(
                                color: Color.fromARGB(255, 129, 127, 127),
                                blurRadius: 3,
                                offset: Offset(1, 1))
                          ],
                          fontSize: widget.wid * 0.040,
                          fontWeight: FontWeight.w600),
                    )),
                  ),
                ),
              ],
            )
          ]),
        ],
      ),
    );
  }
}
