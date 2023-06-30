// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/user/screens/login.dart';
import 'package:user/user/screens/order_screen.dart';
import 'package:user/user/screens/view_category_product.dart';
import 'package:user/user/screens/view_products.dart';
import 'package:user/user/widgets/seeallcategories.dart';

import '../widgets/category.dart';

class viewcat extends StatefulWidget {
  const viewcat({super.key});

  @override
  State<viewcat> createState() => _viewcatState();
}

class _viewcatState extends State<viewcat> {
  String sarosearch = "";
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;

    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('products')
            .doc('+918148082690')
            .collection('category')
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
          return Scaffold(
            body: SingleChildScrollView(
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
                              initialValue: sarosearch.toString(),
                              onChanged: (value) {
                                setState(() {
                                  sarosearch = value;
                                });

                                // print("search:$value");
                                print(sarosearch);
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Text(
                          "All Categories >",
                          style: GoogleFonts.poppins(
                              fontSize: wid * 0.045,
                              color: Color.fromARGB(255, 106, 106, 106),
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1 / 1.1,
                                    crossAxisCount: 2),
                            shrinkWrap: true,
                            primary: true,
                            padding: EdgeInsets.only(top: 0.5),
                            itemCount: documents
                                .where((element) => element['Category']
                                    .toString()
                                    .toLowerCase()
                                    .contains(sarosearch.toString()))
                                .length,
                            itemBuilder: (context, index) {
                              var data = documents.where((element) {
                                print(element["Category"]
                                    .toString()
                                    .toLowerCase()
                                    .contains(sarosearch.trim()));
                                print("sens:$sarosearch");
                                return element['Category']
                                    .toString()
                                    .toLowerCase()
                                    .contains(sarosearch.trim());
                              }).toList()[index];

                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => viewcategorypro(
                                        caty: data['Category'],
                                      ),
                                    ),
                                  );
                                },
                                child: seeall(
                                    hei: hei,
                                    wid: wid,
                                    img: data['image'],
                                    text: data['Category']),
                              );
                            }),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
