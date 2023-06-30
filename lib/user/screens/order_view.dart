import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class Orderview extends StatefulWidget {
  final order_id,
      datetime,
      status_color,
      ordermode,
      customer_address,
      customer_Mobile,
      customer_name,
      status,
      doc;
  Orderview(
      {required this.order_id,
      required this.datetime,
      required this.customer_name,
      required this.customer_address,
      required this.customer_Mobile,
      required this.status,
      required this.doc,
      required this.ordermode,
      required this.status_color});

  @override
  State<Orderview> createState() => _OrderviewState();
}

class _OrderviewState extends State<Orderview> {
  var status;
  bool state = false;
  bool process = false;
  bool delivered = false;
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    final hei = MediaQuery.of(context).size.height;
    if (widget.status == 'Pending Confirmation') {
      setState(() {
        status = "Pending";
        state = true;
      });
    }
    if (widget.status == 'Processing') {
      setState(() {
        process = true;
      });
    }
    if (widget.status == 'Delivered') {
      setState(() {
        process = true;
        delivered = true;
      });
    }
    return Scaffold(
        appBar:
            AppBar(title: Text("Order Details"), backgroundColor: Colors.grey),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Orders')
                    .doc(GetStorage().read('mobile'))
                    .collection('Orders')
                    .doc(widget.doc.toString())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Container(
                          height: 19,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: int.parse(snapshot.data!['length']),
                              itemBuilder: (context, ind) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 2),
                                  child: Row(
                                    children: [
                                      Text(
                                          snapshot.data!['product_name']
                                                  ['[$ind]'] +
                                              ",",
                                          style: GoogleFonts.poppins(
                                              color: Color.fromARGB(
                                                  255, 26, 26, 26),
                                              fontSize: wid * 0.038,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  ),
                                );
                              }),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.order_id,
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 26, 26, 26),
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                            Row(
                              children: [
                                CircleAvatar(
                                    radius: 4.5,
                                    backgroundColor: widget.status_color),
                                SizedBox(width: 5),
                                Text(state ? status : widget.status,
                                    style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: wid * 0.035,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.datetime,
                                  style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 213, 213, 213),
                                      fontSize: wid * 0.032,
                                      fontWeight: FontWeight.w600)),
                            ]),
                        SizedBox(height: 10),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 13,
                                backgroundColor: Colors.orange,
                                child: Text("1",
                                    style: GoogleFonts.poppins(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: wid * 0.032,
                                        fontWeight: FontWeight.w600))),
                            SizedBox(width: 15),
                            Text("Pending Confirmation",
                                style: GoogleFonts.poppins(
                                    color: Colors.orange,
                                    fontSize: wid * 0.035,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 13,
                                backgroundColor:
                                    process ? Colors.orange : Colors.white,
                                child: Text("2",
                                    style: GoogleFonts.poppins(
                                        color: process
                                            ? Colors.white
                                            : Color.fromARGB(255, 0, 0, 0),
                                        fontSize: wid * 0.032,
                                        fontWeight: FontWeight.w600))),
                            SizedBox(width: 15),
                            Text("Processing",
                                style: GoogleFonts.poppins(
                                    color:
                                        process ? Colors.orange : Colors.grey,
                                    fontSize: wid * 0.035,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 13,
                                backgroundColor:
                                    delivered ? Colors.orange : Colors.white,
                                child: Text("3",
                                    style: GoogleFonts.poppins(
                                        color: delivered
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: wid * 0.032,
                                        fontWeight: FontWeight.w600))),
                            SizedBox(width: 15),
                            Text("Completed",
                                style: GoogleFonts.poppins(
                                    color:
                                        delivered ? Colors.orange : Colors.grey,
                                    fontSize: wid * 0.035,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("${snapshot.data!['length']} ITEM",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Container(
                          height: 60,
                          child: ListView.builder(
                              itemCount: int.parse(snapshot.data!['length']),
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Text(
                                          snapshot.data!['quantity']
                                                  ['[$index]'] +
                                              " X " +
                                              "₹ " +
                                              snapshot.data!['price']
                                                  ['[$index]'],
                                          style: GoogleFonts.readexPro(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: wid * 0.038,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Text(
                                        "₹ " +
                                            snapshot.data!['total_price']
                                                ['[$index]'] +
                                            ".00",
                                        style: GoogleFonts.readexPro(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: wid * 0.038,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(height: 10),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Item Total",
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                            Text("₹ " + snapshot.data!['grand_total'] + ".00",
                                style: GoogleFonts.readexPro(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Grand Total",
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                            Text("₹ " + snapshot.data!['grand_total'] + ".00",
                                style: GoogleFonts.readexPro(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("ORDER DETAILS",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Order mode",
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                            Text(widget.ordermode,
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Divider(
                          thickness: 2,
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("CUSTOMER DETAILS",
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Name",
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(widget.customer_name,
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Mobile",
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          children: [
                            Text(widget.customer_Mobile,
                                style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Address",
                                style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: wid * 0.038,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: wid * 0.7,
                              child: Text(widget.customer_address,
                                  style: GoogleFonts.poppins(
                                      color: Colors.grey,
                                      fontSize: wid * 0.038,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        ),
                      ],
                    );
                  }

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ),
        ));
  }
}
