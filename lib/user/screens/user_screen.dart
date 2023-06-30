// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/user/screens/login.dart';
import 'package:user/user/screens/order_screen.dart';
import 'package:user/user/screens/view_category_product.dart';
import 'package:user/user/screens/view_products.dart';
import 'package:user/user/screens/viewcategories.dart';
import 'package:user/user/widgets/public.dart';
import '../widgets/category.dart';
import '../widgets/image_slider.dart';
import '../widgets/products.dart';

class user extends StatefulWidget {
  var p_name;
  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  String searchvalue = "";
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    var doc = GetStorage().read('mobile');
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('products')
          .doc('+918148082690')
          .collection('products')
          .snapshots(),
      builder: (context, snapshot) {
        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .doc('+918148082690')
              .collection('category')
              .snapshots(),
          builder: (context, snapshot1) {
            if (!snapshot.hasData) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              );
            }
            if (!snapshot1.hasData) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              );
            }
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              final List<DocumentSnapshot> document = snapshot1.data!.docs;

              return SingleChildScrollView(
                  child: Column(children: [
                //----------->appbar_user end
                Stack(children: [
                  Container(
                    // ignore: sort_child_properties_last
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => login()));
                            },
                            // ignore: duplicate_ignore
                            child: GestureDetector(
                              onTap: () {
                                GetStorage().erase();
                              },
                              // ignore: prefer_const_constructors
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => order_details()));
                            },
                            // ignore: prefer_const_constructors
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    height: hei * 0.16,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 125, 124, 124)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: hei * 0.13, left: 30, right: 30),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 1,
                              offset: Offset(1, 3),
                              color: Color.fromARGB(255, 213, 213, 213),
                            )
                          ]),
                      child: SizedBox(
                        height: hei * 0.055,
                        width: wid * 0.88,
                        child: TextFormField(
                          initialValue: searchvalue,
                          onChanged: (value) {
                            setState(() {
                              searchvalue = value;
                            });

                            // print("search:$value");
                            // print(searchvalue);
                          },
                          cursorColor: Colors.grey,
                          decoration: InputDecoration(
                            hintText: "what are you looking for ?",
                            contentPadding: EdgeInsets.only(top: 2),
                            hintStyle: GoogleFonts.poppins(
                                fontSize: wid * 0.035,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                  )
                ]), //----------->appbar_user end
                const SizedBox(height: 15),

                Image_slider(
                  text_status: true,
                  hei: hei * 0.135,
                  wid: wid * 0.95,
                  img1: documents[0]['image'],
                  img2: documents[0]['url_2'],
                  img3: documents[0]['url_3'],
                  img4: documents[0]['url_4'],
                  img5: documents[0]['url_5'],
                  context: context,
                ),

                const SizedBox(height: 25),

                Padding(
                  padding:
                      EdgeInsets.only(left: wid * 0.057, right: wid * 0.057),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Categories",
                        style: GoogleFonts.poppins(
                            fontSize: wid * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => viewcat()));
                        },
                        child: Text("View All  >",
                            style: GoogleFonts.poppins(
                                fontSize: wid * 0.035,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey)),
                      )
                    ],
                  ),
                ),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    height: hei * 0.17,
                    child: ListView.builder(
                        shrinkWrap: true,
                        primary: true,
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(8),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: document.length,
                        itemBuilder: (context, index) {
                          return category(
                              hei: hei,
                              wid: wid,
                              img: document[index]['image'],
                              text: document[index]['Category']);
                        }),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: wid * 0.057),
                  child: Row(
                    children: [
                      Text("Featured",
                          style: GoogleFonts.poppins(
                              fontSize: wid * 0.045,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1 / 1.3, crossAxisCount: 2),
                      shrinkWrap: true,
                      primary: true,
                      padding: EdgeInsets.only(top: 12),
                      itemCount: documents
                          .where((element) => element['Product_name']
                              .toString()
                              .toLowerCase()
                              .contains(searchvalue.toLowerCase()))
                          .length,
                      itemBuilder: (context, index) {
                        var data = documents
                            .where((element) => element['Product_name']
                                .toString()
                                .toLowerCase()
                                .contains(searchvalue.toLowerCase()))
                            .toList()[index];
                        return GestureDetector(
                          onTap: () {
                            count(data['Product_name'], data);
                          },
                          child: products(
                            hei: hei,
                            wid: wid,
                            offer: "60%",
                            product_name: data['Product_name'],
                            image: data['url_2'],
                            Netamount: data['Reduced_price'],
                            sellingamount: data['Selling_price'],
                          ),
                        );
                      }),
                ),
              ]));
            }
            return Container();
          },
        );
      },
    ));
  }

  count(doc, data) {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc('+918148082690')
        .collection('views')
        .doc(doc)
        .collection('views')
        .doc(GetStorage().read('mobile'))
        .set({'view': 1}).whenComplete(() => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ViewProduct(data),
              ),
            ));
  }
}
