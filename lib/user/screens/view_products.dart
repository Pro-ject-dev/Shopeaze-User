import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/user/screens/refer_screen.dart';
import 'package:user/user/screens/shopping_cart.dart';
import 'package:user/user/screens/user_screen.dart';
import 'package:user/user/widgets/image_slider.dart';
import 'package:user/user/widgets/public.dart';

class ViewProduct extends StatefulWidget {
  DocumentSnapshot<Object?> data;
  ViewProduct(this.data);
  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  bool isselect = true;

  var sum = 1;
  var quantity = 0;
  var showCount1 = false;
  var showCount2 = false;

  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    String str = widget.data['Selling_price'];
    var val = str;
    var amount = int.parse(val);

    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .doc(GetStorage().read('mobile'))
            .collection('cart')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Orders')
                    .doc(GetStorage().read('mobile'))
                    .snapshots(),
                builder: ((context, snapshot1) {
                  if (snapshot1.hasData) {
                    var length = snapshot.data!.docs.length;
                    final doc = snapshot.data!.docs;

                    return Scaffold(
                        appBar: AppBar(
                          backgroundColor: Color.fromARGB(255, 125, 124, 124),
                          title: Text("View Products"),
                        ),
                        body: SafeArea(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 20),
                                        Image_slider(
                                            context: context,
                                            hei: hei * 0.28,
                                            wid: wid * 0.95,
                                            img1: widget.data['image'],
                                            img2: widget.data['url_2'],
                                            img3: widget.data['url_3'],
                                            img4: widget.data['url_4'],
                                            img5: widget.data['url_5']),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              widget.data['Product_name'],
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                    fontSize: 25),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: ((context) =>
                                                            user())));
                                              },
                                              child: Text(
                                                'Share',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey,
                                                    )),
                                                child: Text(
                                                  'NEW',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontSize: 17),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 5, 10, 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            17),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: Colors.grey,
                                                    )),
                                                child: Text(
                                                  'TRENDING',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        GestureDetector(
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                                //color: variantOne ? Colors.grey : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                border: Border.all(
                                                  width: 1,
                                                  color: Colors.grey,
                                                )),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Variant One',
                                                  style: GoogleFonts.poppins(
                                                    textStyle: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "₹ "
                                                      '${widget.data['Selling_price']}',
                                                      style: GoogleFonts.lato(
                                                        textStyle:
                                                            const TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      "₹ " +
                                                          '${widget.data['Reduced_price']}',
                                                      style: GoogleFonts.lato(
                                                        textStyle: const TextStyle(
                                                            fontSize: 18,
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary: Colors.black,
                                                      ),
                                                      child: isselect
                                                          ? Text("Add",
                                                              style: GoogleFonts.poppins(
                                                                  textStyle: const TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white)))
                                                          : showCountFun1(),
                                                      onPressed: () {
                                                        setState(() {
                                                          addcart();
                                                          isselect = false;
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                'CATEGORY',
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Text(
                                                '${widget.data['Category']}',
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        bottomNavigationBar: Visibility(
                            replacement: SizedBox.shrink(),
                            visible: int.parse(snapshot1.data!['Total']) > 0,
                            child: SizedBox(
                              width: size.width,
                              height: size.height * .068,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      useSafeArea: true,
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        var price =
                                            widget.data['Selling_price'];
                                        return shopping_cart();
                                      });
                                },
                                splashColor: Colors.black.withOpacity(0.5),
                                hoverColor: Colors.black.withOpacity(0.5),
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: .4),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      color: Colors.black),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 20.0, right: 20),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Total:  ' +
                                                snapshot1.data!['Total'] +
                                                ".00",
                                            style: const TextStyle(
                                              fontSize: 16.0,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Row(
                                            children: const [
                                              Icon(Icons.shopping_cart_sharp,
                                                  color: Colors.white,
                                                  size: 20),
                                              SizedBox(width: 2),
                                              Text(
                                                "View Cart",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "items:  " +
                                                  snapshot.data!.docs.length
                                                      .toString(),
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    letterSpacing: 0.4),
                                                fontSize: 12.0,
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ]),
                                    ]),
                                  ),
                                ),
                              ),
                            )));
                  }
                  return Container();
                }));
          }
          return Container();
        });
  }

  Widget showCountFun1() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Orders')
          .doc(GetStorage().read('mobile'))
          .collection('cart')
          .doc(widget.data['Product_name'])
          .snapshots(),
      builder: (context, snapshot3) {
        if (snapshot3.requireData.exists == false) {
          setState(() {
            isselect = true;
          });
        }
        if (snapshot3.hasData != true) return Text('Error');

        if (snapshot3.hasData) {
          return Row(
            children: [
              IconButton(
                onPressed: () async {
                  setState(() {
                    quantity =
                        int.parse(snapshot3.data!['quantity'].toString());
                    quantity--;
                    cart();
                    print(quantity);
                  });
                },
                icon: Icon(Icons.remove),
              ),
              Text(
                snapshot3.data!['quantity'].toString(),
                style: TextStyle(color: Colors.white),
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    quantity =
                        int.parse(snapshot3.data!['quantity'].toString());
                    quantity++;
                    cart();
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          );
        }

        return CircularProgressIndicator();
      },
    );
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
    var amt = int.parse(widget.data['Selling_price']) * quantity;
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(GetStorage().read('mobile'))
        .collection('cart')
        .doc(widget.data['Product_name'])
        .set({
          'quantity': "1",
          'product_name': widget.data['Product_name'],
          'image': widget.data['image'],
          "quantity": "1",
          'price': widget.data['Selling_price'],
          'total_amount': widget.data['Selling_price']
        })
        .whenComplete(() => total())
        .whenComplete(() => final_total());
  }

  cart() {
    var amt = int.parse(widget.data['Selling_price']) * quantity;

    if (quantity == 0) {
      FirebaseFirestore.instance
          .collection('Orders')
          .doc(GetStorage().read('mobile'))
          .collection('cart')
          .doc(widget.data['Product_name'].toString())
          .delete();
      setState(() {
        isselect = true;
      });
    }
    if (quantity > 0) {
      FirebaseFirestore.instance
          .collection('Orders')
          .doc(GetStorage().read('mobile'))
          .collection('cart')
          .doc(widget.data['Product_name'])
          .set({
            'image': widget.data['image'],
            'product_name': widget.data['Product_name'],
            'price': widget.data['Selling_price'],
            'quantity': quantity.toString(),
            'total_amount': amt.toString()
          })
          .whenComplete(() => total())
          .whenComplete(() => final_total());
    }
  }
}
