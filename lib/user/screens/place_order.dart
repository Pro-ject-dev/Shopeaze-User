import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/user/screens/order_screen.dart';
import 'package:user/user/screens/user_screen.dart';

class place_order extends StatefulWidget {
  final order_id;
  place_order({required this.order_id});

  @override
  State<place_order> createState() => _place_orderState();
}

class _place_orderState extends State<place_order> {
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: hei * 0.085),
            Container(
              height: hei * 0.36,
              width: wid * 0.9,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 2),
                        blurRadius: 4,
                        color: Color.fromARGB(255, 208, 208, 208))
                  ]),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Please wait for confirmation",
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your order id is",
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.order_id,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 98, 98, 98),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => order_details())));
                    },
                    child: Text(
                      "View order",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 12),
                    ),
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  MaterialButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: ((context) => user())));
                      },
                      child: Text(
                        "Place  a new order",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 12),
                      ),
                      color: Color.fromARGB(255, 0, 0, 0)),
                  MaterialButton(
                      onPressed: () {},
                      child: Text(
                        "Share order",
                        style: GoogleFonts.poppins(
                            color: Colors.white, fontSize: 12),
                      ),
                      color: Color.fromARGB(255, 0, 0, 0)),
                ],
              ),
            ),
            SizedBox(height: hei * 0.3),
            Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Powered by",
                    style: GoogleFonts.roboto(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Shopeaze',
                    style: GoogleFonts.readexPro(
                        fontSize: 26.0,
                        color: Color.fromARGB(255, 122, 44, 218)),
                  ),
                ]),
            Text(
              "Disclaimer & Policy",
              style: GoogleFonts.lato(
                  color: Color.fromARGB(255, 162, 162, 162),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
