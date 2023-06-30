// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class products extends StatefulWidget {
  products({
    Key? key,
    required this.hei,
    required this.wid,
    required this.offer,
    this.image,
    required this.product_name,
    required this.sellingamount,
    required this.Netamount,
  }) : super(key: key);

  final double hei;
  final double wid;
  final offer, image, product_name, sellingamount, Netamount;

  @override
  State<products> createState() => _productsState();
}

class _productsState extends State<products> {
  var checked;
  var like_status;
  bool checking = true;

  @override
  Widget build(BuildContext context) {
    like() {
      FirebaseFirestore.instance
          .collection('Orders')
          .doc('+918148082690')
          .collection('views')
          .doc(widget.product_name)
          .collection('likes')
          .doc(GetStorage().read('mobile'))
          .set({'liked': 'yes'}).whenComplete(() => user_end_like());
    }

    unlike() {
      FirebaseFirestore.instance
          .collection('Orders')
          .doc('+918148082690')
          .collection('views')
          .doc(widget.product_name)
          .collection('likes')
          .doc(GetStorage().read('mobile'))
          .delete()
          .whenComplete(() => user_end_unlike());
    }

    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('likes')
            .doc("+918148082690" + GetStorage().read('mobile'))
            .collection('likes')
            .doc(widget.product_name)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.data!.exists == false) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          }
          if (snapshot.data!['liked'] == 'no') {
            checking = true;
          }
          if (snapshot.data!['liked'] == 'yes') {
            checking = false;
          }
          if (snapshot.hasData) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(children: [
                    Row(children: [
                      Container(
                        // ignore: sort_child_properties_last
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        height: widget.hei * 0.18,
                        width: widget.wid * 0.37,
                        decoration: const BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 207, 207, 207),
                                blurRadius: 3)
                          ],
                          color: Colors.white,
                        ),
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Stack(children: [
                        Container(
                          height: widget.hei * 0.024,
                          width: widget.wid * 0.095,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.grey]),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                        ),
                        Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            widget.offer,
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: widget.wid * 0.025,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ]),
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18, right: 40),
                        child: Container(
                          height: widget.hei * 0.18,
                          width: widget.wid * 0.37,
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: BoxDecoration(boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 203, 203, 203),
                                  blurRadius: 2)
                            ], borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              splashColor: null,
                              onTap: () {
                                setState(() {
                                  if (checking == true) {
                                    checking = false;
                                    like();
                                  } else {
                                    checking = true;
                                    unlike();
                                  }
                                });
                              },
                              child: CircleAvatar(
                                // ignore: sort_child_properties_last
                                child: Icon(
                                  checking
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                radius: 18,
                                backgroundColor:
                                    Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: widget.wid * 0.3,
                          child: Text(
                            widget.product_name,
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "₹ " + widget.sellingamount,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.roboto(
                                  color: Color.fromARGB(255, 255, 0, 0),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(width: 6),
                          Container(
                            child: Text(
                              "₹ " + widget.Netamount,
                              style: GoogleFonts.roboto(
                                  color: Color.fromARGB(255, 147, 147, 147),
                                  fontSize: widget.wid * 0.025,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            );
          }
          return Card();
        });
  }

  user_end_like() {
    FirebaseFirestore.instance
        .collection('likes')
        .doc("+918148082690" + GetStorage().read('mobile'))
        .collection('likes')
        .doc(widget.product_name)
        .set({'liked': 'yes'});
  }

  user_end_unlike() {
    FirebaseFirestore.instance
        .collection('likes')
        .doc("+918148082690" + GetStorage().read('mobile'))
        .collection('likes')
        .doc(widget.product_name)
        .set({'liked': 'no'});
  }
}
