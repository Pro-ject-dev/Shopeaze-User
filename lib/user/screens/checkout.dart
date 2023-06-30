// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, unnecessary_null_comparison

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/user/screens/add_address.dart';
import 'package:user/user/screens/payment.dart';
import 'package:user/user/widgets/public.dart';

class userend extends StatefulWidget {
  final total;
  userend({required this.total});

  @override
  State<userend> createState() => _userendState();
}

// ignore: camel_case_types
class _userendState extends State<userend> {
  var firestoreDB = FirebaseFirestore.instance.collection("user").snapshots();
  bool showstext = false;
  Color collor2 = Color.fromARGB(255, 255, 255, 255);
  Color pickupfont2 = Color.fromARGB(255, 0, 0, 0);
  Color collor1 = Color.fromARGB(255, 0, 0, 0);
  Color pickupfont1 = Color.fromARGB(255, 255, 255, 255);
  bool isButtonSelected = true;
  Color Deliverycollor = Color.fromARGB(255, 255, 255, 255);
  Color Delivery = Colors.white;
  Color Deliveryfont = Color.fromARGB(255, 0, 0, 0);

  String types = " Delivery";
  final ins = TextEditingController();

  String mobile = "";
  String City = "";
  String Country = "";
  String Deliveryaddress = "";
  String Houseaddress = "";
  String Name = "";
  String Phone = "";
  String Pincode = "";
  String State = "";
  String emailaddress = "";
  String funny = "+1";
  String saroja = "";

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('useraddress');
  @override
  void initState() {
    //documentId is passed from previous widget
    collectionReference.doc(GetStorage().read('mobile')).get().then((value) {
      setState(() {
        if (!value.exists) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => useraddress(
                mobile,
                City,
                Country,
                Deliveryaddress,
                Houseaddress,
                Name,
                Pincode,
                State,
                emailaddress,
                funny,
                saroja,
              ),
            ),
          );
        }
        mobile = value["Phoneno"];
        City = value["City"];
        Country = value["Country"];
        Deliveryaddress = value["Deliveryaddress"];
        Houseaddress = value["Houseaddress"];
        Name = value["Name"];
        Pincode = value["Pincode"];
        State = value["State"];
        emailaddress = value["emailaddress"];
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text("Checkout",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            color: Color.fromARGB(255, 19, 18, 18))),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .95,
              ),
              Container(
                // height: MediaQuery.of(context).size.height * .45,
                width: MediaQuery.of(context).size.width * .90,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 249, 249),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(61, 23, 24, 25).withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .09,
                        width: MediaQuery.of(context).size.width * .90,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(91, 207, 205, 205),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text("Customer Details",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 8, 8, 8))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width * .90,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, left: 8),
                            child: Text(mobile,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 8, 8, 8))),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .85,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 3,
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(Name,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 8, 8, 8))),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .85,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(emailaddress,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 8, 8, 8))),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .85,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text("$Deliveryaddress,$Houseaddress",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 8, 8, 8))),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .85,
                        child: Text("$City,$State,$Country,$Pincode",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: Color.fromARGB(255, 8, 8, 8))),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                        width: MediaQuery.of(context).size.width * .95,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 10, bottom: 08),
                            child: InkWell(
                              onTap: () {
                                final string = mobile;
                                final splitted = string.split(' ');
                                final funny = splitted[0];
                                print(funny);
                                final saroja = splitted[1];
                                print(saroja);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => useraddress(
                                      mobile,
                                      City,
                                      Country,
                                      Deliveryaddress,
                                      Houseaddress,
                                      Name,
                                      Pincode,
                                      State,
                                      emailaddress,
                                      funny,
                                      saroja,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                // ignore: sort_child_properties_last
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 08, left: 12),
                                  child: Text("Change",
                                      style: GoogleFonts.poppins(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                ),
                                // color: Colors.red,
                                height:
                                    MediaQuery.of(context).size.height * .06,
                                width: MediaQuery.of(context).size.width * .30,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 14, 13, 13),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(61, 23, 24, 25)
                                          .withOpacity(0.3),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      // offset: Offset(0, 2),
                                    ),
                                    //you can set more BoxShadow() here
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
                width: MediaQuery.of(context).size.width * .95,
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .23,
                      width: MediaQuery.of(context).size.width * .90,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 249, 249),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Color.fromARGB(61, 23, 24, 25).withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 10,
                            // offset: Offset(0, 2),
                          ),
                          //you can set more BoxShadow() here
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * .09,
                            width: MediaQuery.of(context).size.width * .90,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(91, 207, 205, 205),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text("Order instructions, if any",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 8, 8, 8))),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width * .80,
                              child: TextFormField(
                                controller: ins,
                                cursorColor: Color.fromARGB(255, 82, 82, 82),
                                decoration: const InputDecoration(
                                  hoverColor: Color.fromARGB(255, 51, 52, 52),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0xff959595), width: 1.4),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 51, 52, 52),
                                        width: 1.4),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 1.4),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 51, 52, 52),
                                        width: 1.4),
                                  ),
                                  hintText: 'Enter Instruction here',
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
                width: MediaQuery.of(context).size.width * .95,
              ),
              Container(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height * .23,
                width: MediaQuery.of(context).size.width * .90,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 249, 249),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(61, 23, 24, 25).withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 10,
                      // offset: Offset(0, 2),
                    ),
                    //you can set more BoxShadow() here
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .09,
                      width: MediaQuery.of(context).size.width * .90,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(91, 207, 205, 205),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ignore: avoid_unnecessary_containers
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 05, left: 05),
                              child: Text("Order fulfillment",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 8, 8, 8))),
                            ),
                          ),
                          // ignore: avoid_unnecessary_containers
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 03, left: 05),
                              child: Text(
                                "Select that is most appropriate to you",
                                style: GoogleFonts.poppins(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 8, 8, 8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        // ignore: avoid_unnecessary_containers

                        Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Text(
                                "How?",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 8, 8, 8),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 2),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isButtonSelected = true;
                                    types = "Delivery";
                                    print(types);
                                  });
                                },
                                child: Container(
                                  // ignore: sort_child_properties_last
                                  child: Center(
                                    child: Text(
                                      "Delivery",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: isButtonSelected
                                            ? pickupfont1
                                            : pickupfont2,
                                      ),
                                    ),
                                  ),
                                  // color: collor,
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                  width:
                                      MediaQuery.of(context).size.width * .25,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1, //
                                    ),
                                    color: isButtonSelected ? collor1 : collor2,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 2),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    isButtonSelected = false;
                                    types = "Pickup";
                                    print(types);
                                  });
                                },
                                child: Container(
                                  // ignore: sort_child_properties_last
                                  child: Center(
                                    child: Text(
                                      "Pickup",
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: isButtonSelected
                                            ? pickupfont2
                                            : pickupfont1,
                                      ),
                                    ),
                                  ),
                                  // color: collor,
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                  width:
                                      MediaQuery.of(context).size.width * .25,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1, //
                                    ),
                                    color: isButtonSelected ? collor2 : collor1,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                    // ignore: avoid_unnecessary_containers
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
                width: MediaQuery.of(context).size.width * .95,
              ),
              Container(
                height: MediaQuery.of(context).size.height * .28,
                width: MediaQuery.of(context).size.width * .90,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 249, 249),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(61, 23, 24, 25).withOpacity(0.3),
                      spreadRadius: 0,
                      blurRadius: 10,
                      // offset: Offset(0, 2),
                    ),
                    //you can set more BoxShadow() here
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .14,
                      width: MediaQuery.of(context).size.width * .90,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(91, 207, 205, 205),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ignore: avoid_unnecessary_containers
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 05, left: 05),
                              child: Text("Order Total",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 8, 8, 8))),
                            ),
                          ),
                          // ignore: avoid_unnecessary_containers
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 03, left: 05),
                              child: Text(
                                "This is an estimated total for the order. Final amount will be confirmed by the merchant",
                                style: GoogleFonts.poppins(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 8, 8, 8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Container(
                            child: Text(
                              "Cart Total",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color.fromARGB(255, 8, 8, 8),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 50),
                          child: Container(
                            // color: Colors.red,
                            width: MediaQuery.of(context).size.width * .50,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "₹ " + widget.total + ".00",
                                style: GoogleFonts.adamina(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 8, 8, 8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Container(
                              child: Text(
                                "Total",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 8, 8, 8),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Container(
                              child: Text(
                                "(Rounded off)",
                                style: GoogleFonts.poppins(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Color.fromARGB(255, 8, 8, 8),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                            ),
                            child: Container(
                              // color: Colors.red,
                              width: MediaQuery.of(context).size.width * .50,
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  "₹ " + widget.total + ".00",
                                  style: GoogleFonts.adamina(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 8, 8, 8),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .08,
                width: MediaQuery.of(context).size.width * .95,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 45, 44, 44)),
                onPressed: () {
                  setState(() {
                    phone = mobile;
                    user_name = Name;
                    email = emailaddress;
                    address = Houseaddress +
                        "," +
                        Deliveryaddress +
                        "," +
                        City +
                        "," +
                        State +
                        "," +
                        Country +
                        "," +
                        Pincode;

                    if (types == 'Pickup') {
                      typeoforder = 'Pickup';
                    } else {
                      typeoforder = 'Delivery';
                    }
                    instruction = ins.text;
                  });

                  var orderid = generatenum(8);
                  var txnid = TXNID(12);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Payment_Screen(
                                txn_id: txnid,
                                order_id: orderid,
                                amount: widget.total,
                              )));
                },
                child: Text(
                  "Continue",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Color.fromARGB(255, 253, 251, 251),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
                width: MediaQuery.of(context).size.width * .100,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String generatenum(int length) {
    final random = Random();
    const availableChars = '1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }

  String TXNID(int length) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnooPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }
  // }
}
