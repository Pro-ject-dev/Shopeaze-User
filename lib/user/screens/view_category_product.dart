// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/user/screens/view_products.dart';

import '../widgets/products.dart';
import '../widgets/seeallcategories.dart';
import 'login.dart';
import 'order_screen.dart';

class viewcategorypro extends StatefulWidget {
  const viewcategorypro({super.key, this.caty});
  // ignore: prefer_typing_uninitialized_variables
  final caty;

  @override
  State<viewcategorypro> createState() => _viewcategoryproState();
}

class _viewcategoryproState extends State<viewcategorypro> {
  String cati = "";
  @override
  void initState() {
    setState(() {
      cati = widget.caty;
    });

    print("cati: " + cati);
    super.initState();
  }

  String search = "";
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .doc('+918148082690')
              .collection('products')
              .where("Category", isEqualTo: cati.trim())
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                ),
              );
            }
            final List<DocumentSnapshot> documents = snapshot.data!.docs;

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
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
                                  onTap: () {},
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
                                          builder: (context) =>
                                              order_details()));
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
                        padding: EdgeInsets.only(
                            top: hei * 0.13, left: 30, right: 30),
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
                              initialValue: search,
                              onChanged: (value) {
                                setState(() {
                                  search = value;
                                });

                                print("search:$value");
                                print("summa:" + search);
                              },
                              cursorColor: Colors.grey,
                              decoration: InputDecoration(
                                hintText: "what are you looking for ?",
                                contentPadding: EdgeInsets.only(top: 2),
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: wid * 0.035,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.grey),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(24),
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.only(left: 22.0),
                    child: Row(
                      children: [
                        Text(
                          "Products >",
                          style: GoogleFonts.poppins(
                              fontSize: wid * 0.045,
                              color: Color.fromARGB(255, 106, 106, 106),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1 / 1.3,
                                    crossAxisCount: 2),
                            shrinkWrap: true,
                            primary: true,
                            padding: EdgeInsets.only(top: 12),
                            itemCount: documents
                                .where((element) => element['Product_name']
                                    .toString()
                                    .toLowerCase()
                                    .contains(search.toLowerCase().trim()))
                                .length,
                            itemBuilder: (context, index) {
                              var data = documents
                                  .where((element) => element['Product_name']
                                      .toString()
                                      .toLowerCase()
                                      .contains(search.toLowerCase().trim()))
                                  .toList()[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ViewProduct(data),
                                    ),
                                  );
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
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
