import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:user/user/screens/place_order.dart';
import 'package:user/user/widgets/public.dart';

class Payment_Screen extends StatefulWidget {
  final txn_id, order_id, amount;
  const Payment_Screen({this.txn_id, this.order_id, this.amount});

  @override
  State<Payment_Screen> createState() => _Payment_ScreenState();
}

class _Payment_ScreenState extends State<Payment_Screen> {
  String tdata = DateFormat("hh:mm:ss a").format(DateTime.now());
  String datetime = DateTime.now().toString();
  List userSearchItems = [];

  bool selected = true;
  var document_id;
  var length;
  var id;
  @override
  void initState() {
    b_name();
    get_id();
    submitAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late final _razorpay = Razorpay();
    var options = {
      "key": "rzp_test_xqG5Y9vDyfuT3t",
      "amount": num.parse(totalAmonut.toString()) * 100,
      "name": "$business_name",
      "description": "payment for our work",
      "prefill": {
        "contact": "8148082690",
        "email": "vasudevan794@mountzion.ac.in",
      },
      "external": {
        "wallets": ["Gpay"]
      }
    };
    final wid = MediaQuery.of(context).size.width;
    final hei = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text("Payment Details"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      submitAll();
                    },
                    child: Container(
                        height: hei * 0.34,
                        width: wid * 0.85,
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 109, 109, 109),
                                blurRadius: 2)
                          ],
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("TO PAY",
                                    style: GoogleFonts.poppins(
                                        fontSize: wid * 0.05,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("₹ ${widget.amount.toString()}",
                                    style: GoogleFonts.roboto(
                                        fontSize: wid * 0.06,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("PAY TO ",
                                    style: GoogleFonts.poppins(
                                        fontSize: wid * 0.04,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$business_name",
                                    style: GoogleFonts.poppins(
                                        fontSize: wid * 0.055,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("ORDER ID",
                                    style: GoogleFonts.poppins(
                                        fontSize: wid * 0.04,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("$business_name" "-" + widget.order_id,
                                    style: GoogleFonts.poppins(
                                        fontSize: wid * 0.055,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("TXN ID",
                                    style: GoogleFonts.poppins(
                                        fontSize: wid * 0.04,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(widget.txn_id,
                                    style: GoogleFonts.poppins(
                                        fontSize: wid * 0.055,
                                        textStyle: TextStyle(letterSpacing: 1),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500))
                              ],
                            )
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                  height: hei * 0.1,
                  width: wid * 0.85,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 241, 241, 241),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("How will you Pay",
                                style: GoogleFonts.poppins(
                                    fontSize: wid * 0.04,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              width: wid * 0.8,
                              child: Text(
                                  "Pick a payment method to pay for this order",
                                  style: GoogleFonts.poppins(
                                      fontSize: wid * 0.036,
                                      color: Color.fromARGB(255, 109, 109, 109),
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
              Container(
                  height: hei * 0.132,
                  width: wid * 0.84,
                  decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only()),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                selected ? Colors.black : Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              selected = true;
                            });
                          },
                          child: Text("Pay on Delivery",
                              style: GoogleFonts.poppins(
                                  fontSize: wid * 0.032,
                                  color: selected ? Colors.white : Colors.grey,
                                  fontWeight: FontWeight.w500))),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            backgroundColor:
                                selected ? Colors.white : Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              selected = false;
                            });
                          },
                          child: Text("Online Payment",
                              style: GoogleFonts.poppins(
                                  fontSize: wid * 0.032,
                                  color: selected
                                      ? Colors.grey
                                      : Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.w500)))
                    ],
                  )),
              SizedBox(height: 10),
              OutlinedButton(
                  onPressed: () {
                    // deleteall_cart();
                    if (selected == true) {
                      store("+918148082690");
                      store(GetStorage().read('mobile'));
                    } else {
                      try {
                        _razorpay.open(options);
                      } catch (e) {
                        print(e.toString());
                      }
                    }
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => place_order(
                                order_id:
                                    business_name + "-" + widget.order_id))),
                        (route) => false);
                  },
                  child: Text("Confirm And Continue",
                      style: GoogleFonts.poppins(
                          fontSize: wid * 0.032,
                          color: Colors.blue,
                          fontWeight: FontWeight.w500))),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel",
                    style: GoogleFonts.poppins(
                        fontSize: wid * 0.036,
                        color: Color.fromARGB(255, 109, 109, 109),
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(height: 10),
              SizedBox(
                  width: wid * 0.8,
                  height: hei * 0.15,
                  child: Image.network('https://www.imbms.com/img/RAZORPAY.png',
                      fit: BoxFit.fill))
            ],
          ),
        ));
  }

  void get_id() async {
    setState(() {
      id = FirebaseFirestore.instance
          .collection('Orders')
          .doc('p')
          .collection('Orders')
          .doc()
          .id;
    });
  }

  void deleteall_cart() {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(GetStorage().read('mobile'))
        .collection('cart')
        .doc()
        .delete();
  }

  void store(var docs) async {
    print(id);
    print(docs);
    var date = datetime.split(" ");
    var _date = date[0];
    await FirebaseFirestore.instance
        .collection('Orders')
        .doc(docs)
        .collection('Orders')
        .doc(id.toString())
        .set({
      "customer_name": user_name,
      "customer_phone": phone.toString(),
      "customer_email": email,
      "customer_address": address,
      "customer_instruction": instruction,
      "customer_order_type": typeoforder.toString(),
      "customer_payment_method": "POD",
      "product_name": {
        for (var i = 0; i < length; i++)
          [i].toString(): userSearchItems[i]['product_name']
      },
      "product_image": {
        for (var i = 0; i < length; i++)
          [i].toString(): userSearchItems[i]['image']
      },
      "total_price": {
        for (var i = 0; i < length; i++)
          [i].toString(): userSearchItems[i]['total_amount']
      },
      "quantity": {
        for (var i = 0; i < length; i++)
          [i].toString(): userSearchItems[i]['quantity']
      },
      "order_id": business_name + "-" + widget.order_id,
      "txn_id": widget.txn_id.toString(),
      "order_time": tdata.toString(),
      "order_date": _date.toString(),
      "price": {
        for (var i = 0; i < length; i++)
          [i].toString(): userSearchItems[i]['price']
      },
      "status": "Pending Confirmation",
      "doc": id.toString(),
      'length': length.toString(),
      'grand_total': widget.amount.toString()
    });
  }

  void b_name() async {
    final DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('user')
        .doc('+918148082690')
        .get();
    if (doc.exists) {
      var name = doc['business name'];
      var docid = doc.id;
      setState(() {
        business_name = name.toString();
        document_id = docid;
      });
      print(business_name);
    }
  }

  void submitAll() async {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(GetStorage().read('mobile'))
        .collection('cart')
        .snapshots()
        .listen((data) => data.docs.forEach((doc) {
              setState(() {
                userSearchItems.add(doc.data());
              });
              setState(() {
                length = data.docs.length;
              });
            }));
  }
}
