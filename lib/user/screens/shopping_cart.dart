import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user/user/screens/checkout.dart';
import 'package:user/user/screens/user_screen.dart';
import 'package:user/user/screens/view_products.dart';
import 'package:user/user/widgets/public.dart';

class shopping_cart extends StatefulWidget {
  @override
  State<shopping_cart> createState() => _shopping_cartState();
}

class _shopping_cartState extends State<shopping_cart> {
  var price;
  bool check = false;
  var quantity;
  var image;
  var sum = 1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .doc(GetStorage().read('mobile'))
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          final cr = snapshot.data!.docs;
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Dialog(
                  backgroundColor: const Color.fromARGB(255, 238, 235, 235),
                  alignment: Alignment.topCenter,
                  insetPadding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Shopping Cart",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 19,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                              icon: const Icon(Icons.close),
                            )
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1.6,
                        color: Color.fromARGB(166, 158, 158, 158),
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 238, 235, 235),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(108, 158, 158, 158),
                                  blurRadius: 1.0, // soften the shadow
                                  spreadRadius: 1.0, //extend the shadow
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 0, left: 0, bottom: 10),
                              child: Column(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            primary: true,
                                            physics: ScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: cr.length,
                                            itemBuilder: (context, index) {
                                              var img = cr[index]['image'];

                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15,
                                                    right: 8,
                                                    left: 8,
                                                    bottom: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            delete_cart(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                [
                                                                'product_name']);
                                                          });
                                                        },
                                                        child: const Text(
                                                          "x",
                                                          style: TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      210,
                                                                      210,
                                                                      210),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 25),
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Image.network(
                                                            fit: BoxFit.cover,
                                                            height: 100,
                                                            width: 100,
                                                            '$img'),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          child: Text(
                                                            cr[index][
                                                                'product_name'],
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0xff727272),
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        const Padding(
                                                          padding:
                                                              EdgeInsets.all(1),
                                                          child: Text(
                                                            "Variant one ",
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        208,
                                                                        135,
                                                                        134,
                                                                        134),
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          child: Text(
                                                            "₹ " +
                                                                cr[index]
                                                                    ['price'],
                                                            style: const TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        208,
                                                                        135,
                                                                        134,
                                                                        134),
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            setState(() {
                                                              product_name = cr[
                                                                      index][
                                                                  'product_name'];
                                                              price = cr[index]
                                                                  ['price'];
                                                              quantity =
                                                                  int.parse(cr[
                                                                          index]
                                                                      [
                                                                      'quantity']);
                                                              image = img;
                                                              quantity++;
                                                            });
                                                            cart();
                                                          },
                                                          child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          10),
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Color
                                                                    .fromARGB(
                                                                        126,
                                                                        160,
                                                                        165,
                                                                        169),
                                                              ),
                                                              child: const Text(
                                                                "+",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            cr[index]
                                                                    ['quantity']
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            setState(() {
                                                              product_name = cr[
                                                                      index][
                                                                  'product_name'];
                                                              price = cr[index]
                                                                      ['price']
                                                                  .toString();
                                                              quantity =
                                                                  int.parse(cr[
                                                                          index]
                                                                      [
                                                                      'quantity']);
                                                              image = cr[index]
                                                                  ['image'];
                                                              quantity--;
                                                            });
                                                            cart();
                                                          },
                                                          child: Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      left: 22,
                                                                      right: 22,
                                                                      bottom:
                                                                          10),
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                                color: Color
                                                                    .fromARGB(
                                                                        126,
                                                                        160,
                                                                        165,
                                                                        169),
                                                              ),
                                                              child: const Text(
                                                                "-",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        25,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "₹ " +
                                                            cr[index][
                                                                'total_amount'],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }),
                                      ),
                                      Divider(
                                        thickness: 1.6,
                                        color:
                                            Color.fromARGB(166, 158, 158, 158),
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: StreamBuilder<DocumentSnapshot>(
                                        stream: FirebaseFirestore.instance
                                            .collection('Orders')
                                            .doc(GetStorage().read('mobile'))
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    userend(
                                                                      total: snapshot
                                                                          .data![
                                                                              'Total']
                                                                          .toString(),
                                                                    )));
                                                  },
                                                  child: const Text(
                                                    "Checkout",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        // fontWeight: FontWeight.bold,
                                                        letterSpacing: 1.2),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: const BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(5)),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    totalAmonut = sum;
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        user()),
                                                            (route) => false);
                                                  },
                                                  child: const Text(
                                                    "Add more",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        // fontWeight: FontWeight.bold,
                                                        letterSpacing: 1.2),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  "₹ " +
                                                      snapshot.data!['Total'] +
                                                      ".00",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1.2),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        right: 20, left: 20, bottom: 20),
                                    child: Text(
                                        "(This is an estimated total amount.Final amount will be confirmed by merchant.)"),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        });
  }

  total() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('Orders')
        .doc(GetStorage().read('mobile'))
        .collection('cart')
        .get()
        .whenComplete(() => setState(() {
              sum = 0;
            }));
    snapshot.docs.forEach((element) {
      setState(() {
        var i = int.parse(element.get('total_amount'));
        sum += i;
      });
    });
  }

  final_total() async {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(GetStorage().read('mobile'))
        .set({'Total': sum.toString()});
  }

  addcart() {
    var amt = int.parse(price) * quantity;
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(GetStorage().read('mobile'))
        .collection('cart')
        .doc(product_name)
        .set({
          'quantity': "1",
          'product_name': product_name,
          'image': image,
          "quantity": "1",
          'price': price,
          'total_amount': amt.toString()
        })
        .whenComplete(() => total())
        .whenComplete(() => final_total());
  }

  cart() {
    var amt = int.parse(price) * quantity;

    if (quantity == 0) {
      FirebaseFirestore.instance
          .collection('Orders')
          .doc(GetStorage().read('mobile'))
          .collection('cart')
          .doc(product_name.toString())
          .delete()
          .whenComplete(() => total())
          .whenComplete(() => final_total());
    }
    if (quantity > 0) {
      FirebaseFirestore.instance
          .collection('Orders')
          .doc(GetStorage().read('mobile'))
          .collection('cart')
          .doc(product_name)
          .set({
            'image': image,
            'product_name': product_name,
            'price': price,
            'quantity': quantity.toString(),
            'total_amount': amt.toString()
          })
          .whenComplete(() => total())
          .whenComplete(() => final_total());
    }
  }

  delete_cart(name) {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(GetStorage().read('mobile'))
        .collection('cart')
        .doc(name.toString())
        .delete()
        .whenComplete(() => total())
        .whenComplete(() => final_total());
  }
}
