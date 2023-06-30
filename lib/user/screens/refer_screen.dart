import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/user/screens/checkout.dart';
import 'package:user/user/screens/login.dart';

class shop_cart extends StatefulWidget {
  const shop_cart({super.key});

  @override
  State<shop_cart> createState() => _shop_cartState();
}

class _shop_cartState extends State<shop_cart> {
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text("Refer a Friend"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: hei * 0.3,
                width: wid,
                child: Image.network(
                    'https://img.freepik.com/free-vector/refer-friend-concept-flat-hand-with-smartphone-invite-friends-community-social-media-group-earn-rewards-money-bonus-from-online-referral-program-teenagers-follow-join-influencer_88138-781.jpg?w=900&t=st=1666966113~exp=1666966713~hmac=1360f9ff0652cfb206e343e5b17a3a8bba76912b03b17e9b73cc9f60284713bd'),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Your Refferal Code",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(generateRandomString(8),
                      style: GoogleFonts.poppins(
                          color: Colors.brown,
                          fontSize: wid * 0.08,
                          textStyle: TextStyle(letterSpacing: 5),
                          fontWeight: FontWeight.w500)),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: wid * 0.75,
                    child: Text(
                        "Share your code with your friends and get bonus points",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 139, 139, 139),
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: hei * 0.23,
                width: wid,
                child: Image.network(
                    'https://img.freepik.com/free-vector/loyalty-program-concept_74855-6543.jpg?w=900&t=st=1666968783~exp=1666969383~hmac=31d6e81510e7cc92bb692d28afe2a4fcc2daae9ed7350def543514fe30c1d9fe',
                    fit: BoxFit.fitWidth),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: wid * 0.8,
                    height: hei * 0.054,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => login())); //userend()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      // ignore: sort_child_properties_last
                      child: Text("SHARE TO FRIENDS",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      color: const Color.fromARGB(255, 125, 124, 124),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  String generateRandomString(int length) {
    final random = Random();
    const availableChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();

    return randomString;
  }
}
